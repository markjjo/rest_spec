require 'active_support'
require 'active_support/core_ext'
require 'json'
require 'logger'
require 'uri'
require 'net/https'
require 'optparse'
require_relative 'telemetry'

module SpecMaker
  $options = { version: 'v1.0' }

  OptionParser.new do |parser|
    parser.on('-v', '--version APIVERSION',
              'Specify API version to process. Defaults to v1.0') do |v|
      $options[:version] = v
    end

    parser.on('-m', '--metadata FILE',
              'Specify a local file with custom metadata.') do |m|
      $options[:metadata] = m
    end

    parser.on('-h', '--help', 'Prints this help.') do
      puts(parser)
      exit
    end
  end.parse!

  Telemetry.log_metdata_to_json $options

  puts 'Processing metadata:'
  puts "  API version: #{$options[:version]}"
  puts "  Metadata: #{$options[:metadata].nil? ? 'From graph.microsoft.com' : $options[:metadata]}"

  require_relative 'utils_e2j'

  # Read and load the CSDL file
  metadata = if $options[:metadata].nil?
               Net::HTTP.get(URI.parse("https://graph.microsoft.com/#{$options[:version]}/$metadata"))
             else
               File.read($options[:metadata], encoding: 'UTF-8')
             end

  # Convert to JSON format.
  csdl = JSON.parse(Hash.from_xml(metadata).to_json, symbolize_names: true)
  File.open("#{CSDL_LOCATION}metadata.json", 'w') do |f|
    f.write(JSON.pretty_generate(csdl, encoding: 'UTF-8'))
  end
  schema = csdl[:Edmx][:DataServices][:Schema]

  puts 'Starting...'

  # Process all Enums. Load in memory.
  if schema[:EnumType].is_a?(Array)
    schema[:EnumType].each do |item|
      puts "-> Processing Enum #{item[:Name]}"
      enum = {}
      enum[:isExclusive] = if item[:IsFlags]
                             false
                           else
                             true
                           end
      enum[:options] = {}
      if item[:Member].is_a?(Array)
        item[:Member].each do |member|
          entry = {}
          entry[:value] = member[:Value]
          entry[:description] = ''
          enum[:options][member[:Name].to_sym] = entry
        end
      else
        entry = {
          value: item[:Member]['Value'],
          description: ''
        }
        enum[:options][item[:Member][:Name].to_sym] = entry
      end
      @enum_objects[camelcase(item[:Name]).to_sym] = enum
      @ienums += 1
    end
  elsif schema[:EnumType].is_a?(Hash)
    puts "-> Processing Enum (hash) #{schema[:EnumType][:Name]}, #{schema[:EnumType]}"
    enum = {}
    enum[:isExclusive] = if schema[:EnumType][:IsFlags]
                           false
                         else
                           true
                         end
    enum[:options] = {}
    schema[:EnumType][:Member].each do |member|
      entry = {}
      entry[:value] = member[:Value]
      entry[:description] = ''
      enum[:options][member[:Name].to_sym] = entry
    end
    @enum_objects[camelcase(schema[:EnumType][:Name]).to_sym] = enum
    @ienums += 1
  end

  File.open(ENUMS, 'w') do |f|
    f.write(JSON.pretty_generate(@enum_objects, encoding: 'UTF-8'))
  end

  # # Process ACTIONS
  if schema[:Action].is_a?(Array)
    schema[:Action].each do |item|
      puts "-> Processing Action #{item[:Name]}"
      @iaction += 1
      process_method(item, 'action')
    end
  elsif schema[:Action].is_a?(Hash)
    puts "-> Processing Action (hash) #{schema[:Action][:Name]}, #{schema[:Action]}"
    @iaction += 1
    process_method(schema[:Action], 'action')
  end

  # # Process FUNCTIONS

  if schema[:Function].is_a?(Array)
    schema[:Function].each do |item|
      puts "-> Processing Function #{item[:Name]}"
      @ifunction += 1
      process_method(item, 'function')
    end
  elsif schema[:Function].is_a?(Hash)
    puts "-> Processing Function (hash) #{schema[:Function][:Name]}, #{schema[:Function]}"
    @ifunction += 1
    process_method(schema[:Function][:Name], 'function')
  end

  # Write Functions & Actions
  File.open(ACTIONS, 'w') do |f|
    f.write(JSON.pretty_generate(@methods, encoding: 'UTF-8'))
  end
  #######
  # Loc0
  #####
  # Process complex-types
  schema[:ComplexType].each do |entity|
    @ictypes += 1
    @json_object = nil
    @json_object = deep_copy(@template)

    puts "-> Processing Complex Type #{entity[:Name]}"
    @json_object[:name] = camelcase entity[:Name]
    @json_object[:isComplexType] = true
    @json_object[:allowPatch] = false
    @json_object[:allowUpsert] = false
    @json_object[:allowPatchCreate] = false
    @json_object[:allowDelete] = false
    @json_object[:baseType] = entity[:BaseType]

    parse_annotations(entity[:Name], entity[:Annotation])
    set_description(entity[:Name], @json_object)

    # PROCESS Properties
    if entity[:Property].is_a?(Array)
      entity[:Property].each do |item|
        @json_object[:properties].push process_complextype(entity[:Name], item)
      end
    elsif entity[:Property].is_a?(Hash)
      @json_object[:properties].push process_complextype(entity[:Name], entity[:Property])
    end
    preserve_object_property_descriptions(@json_object[:name])
    File.open("#{JSON_SOURCE_FOLDER}#{(@json_object[:name]).downcase}.json", 'w') do |f|
      f.write(JSON.pretty_generate(@json_object, encoding: 'UTF-8'))
    end
    GC.start
  end

  # Yes, this block is long. :|
  # rubocop:disable Metrics/BlockLength
  schema[:EntityType].each do |entity|
    puts "-> Processing Entity #{entity[:Name]}"
    @ient += 1
    if BASETYPES_ALLCASE.include?(entity[:Name].downcase)
      puts '----> This is a BaseType'
      @base_types[entity[:Name].to_sym] = deep_copy(entity)
    end
    @json_object = deep_copy(@template)

    if entity.key? :OpenType
      @json_object[:isOpenType] = true if entity[:OpenType]
      puts '*---> OpenType'
    end

    # If you find BaseType, pull in Key, Properties and Nav-Properties from BaseType and proceed as usual
    base_type = nil
    if entity.key?(:BaseType)
      @ibasetypemerges += 1
      base_type = entity[:BaseType][(entity[:BaseType].rindex('.') + 1)..-1]

      BASETYPE_MAPPING.each do |k, v|
        if k.casecmp(base_type).zero?
          puts "------> Mapping BaseType #{base_type} back to #{v}"
          base_type = camelcase v
        end
      end

      unless @base_types[base_type.to_sym].nil?
        entity[:Key] = @base_types[base_type.to_sym][:Key]

        entity[:Property] = merge_members(
          entity[:Property],
          @base_types[base_type.to_sym][:Property]
        )
        entity[:NavigationProperty] = merge_members(
          entity[:NavigationProperty],
          @base_types[base_type.to_sym][:NavigationProperty]
        )
        @base_types[entity[:Name].to_sym] = deep_copy(entity)
      end
    end

    @json_object[:name] = camelcase entity[:Name]
    if !entity[:Key].nil? && entity[:Key][:PropertyRef].is_a?(Hash)
      @key_save = entity[:Key][:PropertyRef][:Name]
    elsif !entity[:Key].nil? && entity[:Key][:PropertyRef].is_a?(Array)
      @key_save = ''
      entity[:Key][:PropertyRef].each do |inner_item|
        @key_save = inner_item[:Name] + ' ' + @key_save
      end
    end

    parse_annotations(entity[:Name], entity[:Annotation])
    set_description(entity[:Name], @json_object)

    # PROCESS Properties
    if entity[:Property].is_a?(Array)
      entity[:Property].each do |item|
        @json_object[:properties].push process_property(entity[:Name], item)
      end
    elsif entity[:Property].is_a?(Hash)
      @json_object[:properties].push process_property(entity[:Name], entity[:Property])
    end

    # PROCESS Navigation Properties
    if entity[:NavigationProperty].is_a?(Array)
      entity[:NavigationProperty].each do |item|
        @json_object[:properties].push process_navigation(entity[:Name], item)
      end
    elsif entity[:NavigationProperty].is_a?(Hash)

      @json_object[:properties].push process_navigation(entity[:Name], entity[:NavigationProperty])
    end

    # Add methods and pull in methods from base type.
    if @methods.key?(@json_object[:name].downcase.to_sym)
      puts '----> Found actions or functions to merge'
      @json_object[:methods] = @methods[@json_object[:name].downcase.to_sym]
      @json_object[:methods].concat @methods[base_type.downcase.to_sym] if !base_type.nil? && @methods.key?(base_type.downcase.to_sym)
    elsif !base_type.nil? && @methods.key?(base_type.downcase.to_sym)
      @json_object[:methods] = @methods[base_type.downcase.to_sym]
    end

    preserve_object_property_descriptions(@json_object[:name])

    File.open("#{JSON_SOURCE_FOLDER}#{(@json_object[:name]).downcase}.json", 'w') do |f|
      f.write(JSON.pretty_generate(@json_object, encoding: 'UTF-8'))
    end
    GC.start
  end
  # rubocop:enable Metrics/BlockLength

  @collection_names = {}
  # Process EntitySets
  schema[:EntityContainer][:EntitySet].each do |entity|
    @ientityset += 1
    @icollection += 1
    @json_object = nil
    @json_object = deep_copy(@template)

    puts "-> Processing EntitySet Type #{entity[:Name]}"
    @json_object[:name] = camelcase entity[:Name]
    @json_object[:isEntitySet] = true
    # dt = entity[:EntityType][(entity[:EntityType].rindex('.') + 1)..-1].chomp(')')
    dt = get_type(entity[:EntityType])
    @json_object[:collectionOf] = dt

    # save the collection names & types being created for later checks.
    @collection_names[entity[:Name]] = dt

    # These are different for the collection
    @json_object[:allowPatch] = false
    @json_object[:allowUpsert] = false
    @json_object[:allowPatchCreate] = false
    @json_object[:allowDelete] = false
    @json_object[:relationshipNotes] = nil
    @json_object[:createDescription] = nil
    @json_object[:updateDescription] = nil
    @json_object[:deleteDescription] = nil

    @json_object[:restPath] = { "/#{@json_object[:name]}" => true }

    file_name = (@json_object[:name]).downcase + '_' + dt.downcase + '_collection.json'
    File.open("#{JSON_SOURCE_FOLDER}#{file_name}", 'w') do |f|
      f.write(JSON.pretty_generate(@json_object, encoding: 'UTF-8'))
    end
    # create_auto_examplefiles((@json_object[:name]).downcase, true)

    fill_rest_path("/#{(@json_object[:name])}", dt, true)

    GC.start
  end

  # Process Singleton
  if schema[:EntityContainer][:Singleton].is_a?(Array)
    schema[:EntityContainer][:Singleton].each do |entity|
      @isingleton += 1
      dt = get_type(entity[:Type])
      # No need to write singletons.
      fill_rest_path("/#{entity[:Name]}", dt, false)
    end
  elsif schema[:EntityContainer][:Singleton].is_a?(Hash)
    puts "Processing Singleton #{schema[:EntityContainer][:Singleton][:Name]}"
    @isingleton += 1
    dt = get_type(schema[:EntityContainer][:Singleton][:Type])
    # No need to write singletons.
    puts "calling fill rest path with: /#{schema[:EntityContainer][:Singleton][:Name].downcase}, #{dt} "
    fill_rest_path("/#{schema[:EntityContainer][:Singleton][:Name].downcase}", dt, false)
  end

  File.open(ANNOTATIONS, 'w') do |f|
    f.write(JSON.pretty_generate(@annotations, encoding: 'UTF-8'))
  end

  puts '....Completed.'
  puts "Entities: #{@ient}"
  puts "Base Types Merged: #{@ibasetypemerges}"
  puts "Complex Types: #{@ictypes}"
  puts "Properties: #{@iprop}"
  puts "Navigation Properties: #{@inprop}"
  puts "Actions: #{@iaction}"
  puts "Functions: #{@ifunction}"
  # puts "--> Example files written: #{@iexampleFilesWrittem}"
  puts "Parameters: #{@iparam}"
  puts "Enums: #{@ienums}"
  # puts "Collections: #{@icollection}"
  puts "EntitySet: #{@ientityset}"
end

# item resource type



### JSON representation

Here is a JSON representation of the resource

```json
{
  "audio": {
    "@odata.type": "microsoft.graph.audio"
  },
  "cTag": "String",
  "children": [
    {
      "@odata.type": "microsoft.graph.item"
    }
  ],
  "content": "String",
  "createdBy": {
    "@odata.type": "microsoft.graph.identitySet"
  },
  "createdByUser": {
    "@odata.type": "microsoft.graph.User"
  },
  "createdDateTime": "String (timestamp)",
  "deleted": {
    "@odata.type": "microsoft.graph.deleted"
  },
  "description": "String",
  "eTag": "String",
  "file": {
    "@odata.type": "microsoft.graph.file"
  },
  "fileSystemInfo": {
    "@odata.type": "microsoft.graph.fileSystemInfo"
  },
  "folder": {
    "@odata.type": "microsoft.graph.folder"
  },
  "id": "String (identifier)",
  "image": {
    "@odata.type": "microsoft.graph.image"
  },
  "lastModifiedBy": {
    "@odata.type": "microsoft.graph.identitySet"
  },
  "lastModifiedByUser": {
    "@odata.type": "microsoft.graph.User"
  },
  "lastModifiedDateTime": "String (timestamp)",
  "location": {
    "@odata.type": "microsoft.graph.location"
  },
  "name": "String",
  "openWith": {
    "@odata.type": "microsoft.graph.openWithSet"
  },
  "parentReference": {
    "@odata.type": "microsoft.graph.itemReference"
  },
  "permissions": [
    {
      "@odata.type": "microsoft.graph.permission"
    }
  ],
  "photo": {
    "@odata.type": "microsoft.graph.photo"
  },
  "searchResult": {
    "@odata.type": "microsoft.graph.searchResult"
  },
  "shared": {
    "@odata.type": "microsoft.graph.shared"
  },
  "size": 1024,
  "specialFolder": {
    "@odata.type": "microsoft.graph.specialFolder"
  },
  "thumbnails": [
    {
      "@odata.type": "microsoft.graph.thumbnailSet"
    }
  ],
  "versions": [
    {
      "@odata.type": "microsoft.graph.item"
    }
  ],
  "video": {
    "@odata.type": "microsoft.graph.video"
  },
  "webDavUrl": "String",
  "webUrl": "String"
}

```
### Properties
| Property	   | Type	|Description|
|:---------------|:--------|:----------|
|audio|[audio](audio.md)||
|cTag|String||
|content|Stream||
|createdBy|[identitySet](identityset.md)||
|createdDateTime|DateTimeOffset|The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: `'2014-01-01T00:00:00Z'`|
|deleted|[deleted](deleted.md)||
|description|String||
|eTag|String||
|file|[file](file.md)||
|fileSystemInfo|[fileSystemInfo](filesysteminfo.md)||
|folder|[folder](folder.md)||
|id|String| Read-only.|
|image|[image](image.md)||
|lastModifiedBy|[identitySet](identityset.md)||
|lastModifiedDateTime|DateTimeOffset|The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: `'2014-01-01T00:00:00Z'`|
|location|[location](location.md)||
|name|String||
|openWith|[openWithSet](openwithset.md)||
|parentReference|[itemReference](itemreference.md)||
|photo|[photo](photo.md)||
|searchResult|[searchResult](searchresult.md)||
|shared|[shared](shared.md)||
|size|Int64||
|specialFolder|[specialFolder](specialfolder.md)||
|video|[video](video.md)||
|webDavUrl|String||
|webUrl|String||

### Relationships
| Relationship | Type	|Description|
|:---------------|:--------|:----------|
|children|[item](item.md) collection| Read-only. Nullable.|
|createdByUser|[User](user.md)| Read-only.|
|lastModifiedByUser|[User](user.md)| Read-only.|
|permissions|[permission](permission.md) collection| Read-only. Nullable.|
|thumbnails|[thumbnailSet](thumbnailset.md) collection| Read-only. Nullable.|
|versions|[item](item.md) collection| Read-only. Nullable.|

### Tasks

| Task		   | Return Type	|Description|
|:---------------|:--------|:----------|
|[Get item](../api/item_get.md) | [item](item.md) |Read properties and relationships of item object.|
|[Create item](../api/item_post_children.md) |[item](item.md)| Create a new item by posting to the children collection.|
|[Create permission](../api/item_post_permissions.md) |[permission](permission.md)| Create a new permission by posting to the permissions collection.|
|[Create thumbnailSet](../api/item_post_thumbnails.md) |[thumbnailSet](thumbnailset.md)| Create a new thumbnailSet by posting to the thumbnails collection.|
|[Create item](../api/item_post_versions.md) |[item](item.md)| Create a new item by posting to the versions collection.|
|[Update](../api/item_update.md) | [item](item.md)	|Update item object. |
|[Delete](../api/item_delete.md) | Void	|Delete item object. |
|[Allphotos](../api/item_allphotos.md)|[item](item.md)||
|[Copy](../api/item_copy.md)|[item](item.md)||
|[Createlink](../api/item_createlink.md)|[permission](permission.md)||
|[Createsession](../api/item_createsession.md)|[uploadSession](uploadsession.md)||
|[Delta](../api/item_delta.md)|[item](item.md)||
|[Invite](../api/item_invite.md)|[permission](permission.md)||
|[Search](../api/item_search.md)|[item](item.md)||
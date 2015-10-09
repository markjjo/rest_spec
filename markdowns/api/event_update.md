# Update Event

Update the properties of event object.
### HTTP request
```http
PATCH /users/<objectId>/Events/<Id>
PATCH /groups/<objectId>/Events/<Id>
PATCH /users/<objectId>/CalendarView/<Id>
```
### Optional request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply the values for relevant fields that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values. For best performance you shouldn't include existing values that haven't changed.

| Property	   | Type	|Description|
|:---------------|:--------|:----------|
|Attendees|Attendee||
|Body|ItemBody||
|BodyPreview|String||
|Categories|String||
|ChangeKey|String||
|DateTimeCreated|DateTimeOffset||
|DateTimeLastModified|DateTimeOffset||
|End|DateTimeOffset||
|EndTimeZone|String||
|HasAttachments|Boolean||
|Importance|String| Possible values are: `Low`, `Normal`, `High`.|
|IsAllDay|Boolean||
|IsCancelled|Boolean||
|IsOrganizer|Boolean||
|Location|Location||
|Organizer|Recipient||
|OriginalStart|DateTimeOffset||
|Recurrence|PatternedRecurrence||
|Reminder|Int32||
|ResponseRequested|Boolean||
|ResponseStatus|ResponseStatus||
|SeriesMasterId|String||
|ShowAs|String| Possible values are: `Free`, `Tentative`, `Busy`, `Oof`, `WorkingElsewhere`, `Unknown`.|
|Start|DateTimeOffset||
|StartTimeZone|String||
|Subject|String||
|Type|String| Possible values are: `SingleInstance`, `Occurrence`, `Exception`, `SeriesMaster`.|
|WebLink|String||
|iCalUId|String||

### Response
If successful, this method returns a `200 OK` response code and updated [Event](../resources/event.md) object in the response body.
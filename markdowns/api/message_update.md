# Update Message

Update the properties of message object.
### HTTP request
```http
PATCH /users/<objectId>/Messages/<Id>
PATCH /users/<objectId>/RootFolder/Messages/<Id>
PATCH /users/<objectId>/Folders/<Id>/Messages/<Id>
```
### Optional request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply the values for relevant fields that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values. For best performance you shouldn't include existing values that haven't changed.

| Property	   | Type	|Description|
|:---------------|:--------|:----------|
|BccRecipients|Recipient||
|Body|ItemBody||
|BodyPreview|String||
|Categories|String||
|CcRecipients|Recipient||
|ChangeKey|String||
|ConversationId|String||
|DateTimeCreated|DateTimeOffset||
|DateTimeLastModified|DateTimeOffset||
|DateTimeReceived|DateTimeOffset||
|DateTimeSent|DateTimeOffset||
|From|Recipient||
|HasAttachments|Boolean||
|Importance|String| Possible values are: `Low`, `Normal`, `High`.|
|IsDeliveryReceiptRequested|Boolean||
|IsDraft|Boolean||
|IsRead|Boolean||
|IsReadReceiptRequested|Boolean||
|ParentFolderId|String||
|ReplyTo|Recipient||
|Sender|Recipient||
|Subject|String||
|ToRecipients|Recipient||
|UniqueBody|ItemBody||
|WebLink|String||

### Response
If successful, this method returns a `200 OK` response code and updated [Message](../resources/message.md) object in the response body.
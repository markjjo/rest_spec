# Create Conversation

Use this API to create a new Conversation.
### HTTP request
```http
POST /groups/<objectId>/Conversations
POST /users/<objectId>/JoinedGroups/<objectId>/Conversations
POST /drives/<id>/root/createdByUser/JoinedGroups/<objectId>/Conversations

```
### Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply a JSON representation of [Conversation](../resources/conversation.md) object.


### Response
If successful, this method returns `201, Created` response code and [Conversation](../resources/conversation.md) object in the response body.

### Example
##### Response
Here is an example of the response.
```json
HTTP/1.1 201 Created
Content-type: application/json
Content-length: 198
{
  "Topic": "String-value",
  "HasAttachments": true,
  "DateTimeLastDelivered": "datetime-value",
  "UniqueSenders": [
    "String-value"
  ],
  "Preview": "String-value",
  "Id": "String-value"
}
```
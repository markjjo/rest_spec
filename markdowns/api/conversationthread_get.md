# Get ConversationThread

Retrieve the properties and relationships of conversationthread object.
### HTTP request
```http
GET /groups/<objectId>/Threads/<Id>
GET /groups/<objectId>/Conversations/<Id>/Threads/<Id>
GET /users/<objectId>/JoinedGroups/<objectId>/Threads/<Id>
```
### Optional query parameters
You can use the [OData query parameters](odata-optional-query-parameters.md) to restrict the shape of the objects returned from this call.
### Request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
Do not supply a request body for this method.
### Response
If successful, this method returns a `200 OK` response code and [ConversationThread](../resources/conversationthread.md) object in the response body.
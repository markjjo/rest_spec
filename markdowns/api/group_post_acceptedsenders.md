# Create AcceptedSender

Use this API to create a new AcceptedSender.
### HTTP request
```http
POST /groups/<objectId>/AcceptedSenders
POST /users/<objectId>/JoinedGroups/<objectId>/AcceptedSenders
POST /drives/<id>/root/createdByUser/JoinedGroups/<objectId>/AcceptedSenders

```
### Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply a JSON representation of [DirectoryObject](../resources/directoryobject.md) object.


### Response
If successful, this method returns `201, Created` response code and [DirectoryObject](../resources/directoryobject.md) object in the response body.

### Example
##### Response
Here is an example of the response.
```json
HTTP/1.1 201 Created
Content-type: application/json
Content-length: 105
{
  "objectType": "String-value",
  "objectId": "String-value",
  "deletionTimestamp": "datetime-value"
}
```
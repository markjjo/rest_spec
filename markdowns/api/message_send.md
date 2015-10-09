# Message: Send


### HTTP request
```http
POST /users/<objectId>/Messages/<Id>/Send
POST /users/<objectId>/RootFolder/Messages/<Id>/Send
POST /users/<objectId>/Folders/<Id>/Messages/<Id>/Send

```
### Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body

### Response
If successful, this method returns `200, OK` response code and [None](../resources/none.md) object in the response body.

### Example
Here is an example of how to call this API.
##### Request
```http
POST /users/<objectId>/Messages/<Id>/Send
```
##### Response
```json
HTTP/1.1 200 OK
Content-type: application/json
Content-length: 3
{
}
```
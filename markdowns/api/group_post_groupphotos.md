# Create GroupPhoto

Use this API to create a new GroupPhoto.
### HTTP request
```http
POST /groups/<objectId>/GroupPhotos
POST /users/<objectId>/JoinedGroups/<objectId>/GroupPhotos
POST /drives/<id>/root/createdByUser/JoinedGroups/<objectId>/GroupPhotos

```
### Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply a JSON representation of [Photo](../resources/photo.md) object.


### Response
If successful, this method returns `201, Created` response code and [Photo](../resources/photo.md) object in the response body.

### Example
##### Response
Here is an example of the response.
```json
HTTP/1.1 201 Created
Content-type: application/json
Content-length: 57
{
  "Width": 99,
  "Height": 99,
  "Id": "String-value"
}
```
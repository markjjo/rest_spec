# Create ContactFolder

Use this API to create a new ContactFolder.
### HTTP request
```http
POST /users/<objectId>/ContactFolders
POST /drives/<id>/root/createdByUser/ContactFolders
POST /drives/<id>/root/lastModifiedByUser/ContactFolders

```
### Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply a JSON representation of [ContactFolder](../resources/contactfolder.md) object.


### Response
If successful, this method returns `201, Created` response code and [ContactFolder](../resources/contactfolder.md) object in the response body.

### Example
##### Response
Here is an example of the response.
```json
HTTP/1.1 201 Created
Content-type: application/json
Content-length: 95
{
  "ParentFolderId": "String-value",
  "DisplayName": "String-value",
  "Id": "String-value"
}
```
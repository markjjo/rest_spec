# MailFolder: Move


### HTTP request
```http
POST /users/<objectId>/RootFolder/Move
POST /users/<objectId>/Folders/<Id>/Move
POST /drives/<id>/root/createdByUser/RootFolder/Move

```
### Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, provide a JSON object with the following parameters.

| Parameter	   | Type	|Description|
|:---------------|:--------|:----------|
|DestinationId|String||

### Response
If successful, this method returns `200, OK` response code and [MailFolder](../resources/mailfolder.md) object in the response body.

### Example
Here is an example of how to call this API.
##### Request
```http
POST /users/<objectId>/RootFolder/Move
{
  "DestinationId": "String-value"
}
```
##### Response
```json
HTTP/1.1 200 OK
Content-type: application/json
Content-length: 121
{
  "ParentFolderId": "String-value",
  "DisplayName": "String-value",
  "ChildFolderCount": 99,
  "Id": "String-value"
}
```
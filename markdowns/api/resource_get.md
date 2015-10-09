# Get Resource

Retrieve the properties and relationships of resource object.
### HTTP request
```http
GET /users/<objectId>/notes/resources/<id>
GET /drives/<id>/root/createdByUser/notes/resources/<id>
GET /drives/<id>/root/lastModifiedByUser/notes/resources/<id>
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
If successful, this method returns a `200 OK` response code and [Resource](../resources/resource.md) object in the response body.
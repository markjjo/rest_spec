# Get OAuth2PermissionGrant

Retrieve the properties and relationships of oauth2permissiongrant object.
### HTTP request
```http
GET /oauth2PermissionGrants/<objectId>
GET /users/<objectId>/oauth2PermissionGrants/<objectId>
GET /servicePrincipals/<objectId>/oauth2PermissionGrants/<objectId>
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
If successful, this method returns a `200 OK` response code and [OAuth2PermissionGrant](../resources/oauth2permissiongrant.md) object in the response body.
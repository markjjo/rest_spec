# Create Assignment

Use this API to create a new Assignment.
### HTTP request
```http
POST /PrivilegedRoles/<Id>/Assignments
POST /PrivilegedRoleAssignments/<UserId|RoleId>/RoleInfo/Assignments

```
### Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply a JSON representation of [PrivilegedRoleAssignment](../resources/privilegedroleassignment.md) object.


### Response
If successful, this method returns `201, Created` response code and [PrivilegedRoleAssignment](../resources/privilegedroleassignment.md) object in the response body.

### Example
##### Response
Here is an example of the response.
```json
HTTP/1.1 201 Created
Content-type: application/json
Content-length: 149
{
  "UserId": "Guid-value",
  "RoleId": "Guid-value",
  "IsElevated": true,
  "ExpirationTime": "datetime-value",
  "ResultMessage": "String-value"
}
```
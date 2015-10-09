# Update drive

Update the properties of drive object.
### HTTP request
```http
PATCH /drives/<id>
PATCH /users/<objectId>/drive
PATCH /groups/<objectId>/drive
```
### Optional request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply the values for relevant fields that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values. For best performance you shouldn't include existing values that haven't changed.

| Property	   | Type	|Description|
|:---------------|:--------|:----------|
|driveType|String||
|owner|identitySet||
|quota|quota||

### Response
If successful, this method returns a `200 OK` response code and updated [drive](../resources/drive.md) object in the response body.
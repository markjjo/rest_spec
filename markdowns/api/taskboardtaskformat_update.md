# Update TaskBoardTaskFormat

Update the properties of taskboardtaskformat object.
### HTTP request
```http
PATCH /tasks/<id>/bucketTaskBoardFormat
PATCH /tasks/<id>/statusTaskBoardFormat
PATCH /tasks/<id>/assignedToTaskBoardFormat
```
### Optional request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply the values for relevant fields that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values. For best performance you shouldn't include existing values that haven't changed.

| Property	   | Type	|Description|
|:---------------|:--------|:----------|
|orderHint|String||
|version|String||

### Response
If successful, this method returns a `200 OK` response code and updated [TaskBoardTaskFormat](../resources/taskboardtaskformat.md) object in the response body.
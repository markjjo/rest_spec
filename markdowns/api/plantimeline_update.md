# Update PlanTimeline

Update the properties of plantimeline object.
### HTTP request
```http
PATCH /plans/<id>/timeline
PATCH /users/<objectId>/plans/<id>/timeline
PATCH /groups/<objectId>/plans/<id>/timeline
```
### Optional request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| X-Sample-Header  | string  | Sample of how the HTTP headers used by the API could be displayed.|

### Request body
In the request body, supply the values for relevant fields that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values. For best performance you shouldn't include existing values that haven't changed.

| Property	   | Type	|Description|
|:---------------|:--------|:----------|
|displaySettings|String| Possible values are: `None`, `Today`, `TimeScale`, `TaskDate`, `All`.|
|lockedWidth|Int32||
|version|String||

### Response
If successful, this method returns a `200 OK` response code and updated [PlanTimeline](../resources/plantimeline.md) object in the response body.
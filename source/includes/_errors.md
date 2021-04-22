# Errors

```shell
{
  "errors": {
    "additionalProp1": [
      "string"
    ],
    "additionalProp2": [
      "string"
    ],
    "additionalProp3": [
      "string"
    ]
  },
  "type": "string",
  "title": "string",
  "status": 400,
  "detail": "string",
  "instance": "string"
}
```

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`errors.{property}` | *array* | An array of human readable error messages returned per request `{property}`
`status` | *integer* | HTTP status code of the responses

### Error Codes
Error Code | Meaning
---------- | -------
`400` | Invalid request body.
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | Request entity was not found
`500` | Something went wrong on Basis Theory's side

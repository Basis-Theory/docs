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

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

try {
  const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');
  const application = await bt.applications.create({ ... });
} catch (e) {
  console.log(e.status); // HTTP status code
  console.log(e.data); // HTTP Response body
  console.log(e.data.errors);
}

```

### Response

Attribute | Type | Description
--------- | ---- | -----------
`errors.{property}` | *array* | An array of human readable error messages returned per request `{property}`
`status` | *integer* | HTTP status code of the responses

### Error Codes
Error Code | Meaning
---------- | -------
`400` | Invalid request body
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | Request entity was not found
`422` | Request does not satisfy requirements for processing
`429` | Request has been [rate limited](#limits)
`500` | Something went wrong on Basis Theory's side

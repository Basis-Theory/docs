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

```csharp
using BasisTheory.net.Common.Errors;
using BasisTheory.net.Tokens;

try {
  var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");
  var token = await client.CreateAsync(new Token {...});
} 
catch (BasisTheoryException btex) {
  Console.WriteLine(btex.Message);
  Console.WriteLine(btex.Error.Status); // HTTP status code
  Console.WriteLine(btex.Error.Title);  // error title from HTTP response
  Console.WriteLine(btex.Error.Detail); // error detail from HTTP response
  
  // (optionally) btex.Error.Errors contains Dictionary of validation errors
}
```

```python
import basistheory
from basistheory.api import tokens_api
from basistheory.model.create_token_request import CreateTokenRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    try:
        token = token_client.create(create_token_request=CreateTokenRequest(...))
    except basistheory.ApiException as e:
        print("Exception when calling TokensApi: %s\n" % e)
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  createTokenRequest := *basistheory.NewCreateTokenRequest("Sensitive Value")
  ...

  createTokenResponse, createTokenHttpResponse, createErr := apiClient.TokensApi.Create(contextWithAPIKey).CreateTokenRequest(createTokenRequest).Execute()
  
  if createErr != nil {
    fmt.Printlnf("Create token request failed: %v", createErr)
  }
}
```

### Response

Attribute | Type | Description
--------- | ---- | -----------
`title` | *string* | A short, human-readable summary of the problem
`detail` | *string* | A human-readable explanation specific to this occurrence of the problem
`errors.{property}` | *array* | An array of human readable error messages returned per request `{property}`
`status` | *integer* | HTTP status code of the response

### Error Codes

Error Code | Meaning
---------- | -------
`400` | Invalid request body
`401` | A missing or invalid `BT-API-KEY` was provided
`403` | The provided `BT-API-KEY` does not have the required permissions
`404` | Request entity was not found
`422` | Request does not satisfy requirements for processing
`429` | Request has been [rate limited](#limits)
`500` | Something went wrong on Basis Theory's side


## Reactor Errors

When calling `POST */react` endpoints, vendor-specific errors are translated to the same
response schema as Basis Theory [Errors](#response). Additional response codes may be returned
on calls to `POST */react` mapped from vendor-specific errors.

### Reactor Error Codes

Error Code | Meaning | Common Scenarios
---------- | ------- | ----------------
`400` | Bad Request | <ul><li>Missing or invalid request properties when processing the request with the vendor</li><li>Invalid Reactor Configuration</li></ul>
`401` | Authentication Error | <ul><li>Invalid or unknown credentials</li><li>Credentials are valid, but lack permission to complete the operation</li></ul>
`402` | Invalid Payment Method | <ul><li>Expired Card</li><li>A test card or bank account was used in a production environment, or vice-versa</li><li>The vendor denied the card or bank account</li></ul>
`422` | Unprocessable Entity | <ul><li>Reactor Formula code is not a valid function</li></ul>
`429` | Rate Limit Error | <ul><li>The vendor responded with a 429 HTTP response code</li></ul>
`500` | Reactor Runtime Error | <ul><li>An unhandled exception occurred</li><li>The vendor responded with a 5XX HTTP response code</li><li>Vendor connection failure</li></ul>

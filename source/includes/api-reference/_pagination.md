# Pagination

> Request

```shell
curl "https://api.basistheory.com/applications?page=2&size=10" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const applications = await bt.applications.list({
  page: 2,
  size: 10
});
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var applications = client.GetAsync(new ApplicationGetRequest {
  Page = 2,
  PageSize = 10
});
```

```python
import basistheory
from basistheory.api import applications_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    applications_client = applications_api.ApplicationsApi(api_client)

    applications = applications_client.get(page=2, size=10)
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

  applications, httpResponse, err := apiClient.ApplicationsApi.Get(contextWithAPIKey).Page(2).Size(10).Execute()
}
```

> Response

```json
{
  "pagination": {
    "total_items": 924,
    "page_number": 2,
    "page_size": 10,
    "total_pages": 93
  },
  "data": [
    {...},
    {...},
    {...}
  ]
}
```

All `List` endpoints support pagination to allow bulk fetching multiple items. Each `List` endpoint shares a common response structure. Examples of these requests can be seen in [List Applications](#applications-list-applications) and [List Tokens](#tokens-list-tokens).

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`page` | false | *integer* | 1 | Page number of the results to return.
`size` | false | *integer* | 20 | Number of results per page to return. Maximum size of 100 results.

## Pagination Object

Attribute | Type | Description
--------- | ---- | -----------
`pagination` | *[pagination metadata](#pagination-pagination-object-pagination-metadata-object)* | Pagination metadata for the response
`data` | *array* | Query results of the request. See list endpoint resource for response schema definition

### Pagination Metadata Object

Attribute | Type | Description
--------- | ---- | -----------
`total_items` | *integer* | Total number of items in the Tenant
`page_number` | *integer* | Current page number. Should match `page` query parameter.
`page_size` | *integer* | The size of each page. Should match `size` query parameter.
`total_pages` | *integer* | The total number of pages.

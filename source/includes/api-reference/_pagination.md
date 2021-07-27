# Pagination

> Request

```shell
curl "https://api.basistheory.com/applications?page=2&size=10" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@Basis-Theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');
const applications = await bt.applications.list({
  page: 2,
  size: 10
});
```

```csharp
var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var applications = client.GetAsync(new ApplicationGetRequest {
  Page = 2,
  PageSize = 10
});
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

All `List` endpoints support pagination to allow bulk fetching multiple items. Each `List` endpoint shares a common response structure. Examples of these requests can be seen in [List Applications](#list-applications), [List Tokens](#list-tokens), and [List Atomic Cards](#list-atomic-cards)

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`page` | false | *integer* | 1 | Page number of the results to return
`size` | false | *integer* | 20 | Number of results per page to return. Maximum size of 100 results.

## Pagination Object

Attribute | Type | Description
--------- | ---- | -----------
`pagination` | *[pagination metadata](#pagination-metadata-object)* | Pagination metadata for the response
`data` | *array* | Query results of the request. See list endpoint resource for response schema definition

### Pagination Metadata Object

Attribute | Type | Description
--------- | ---- | -----------
`total_items` | *integer* | Total number of items in the tenant
`page_number` | *integer* | Current page number. Should match `page` query parameter.
`page_size` | *integer* | The size of each page. Should match `size` query parameter.
`total_pages` | *integer* | The total number of pages.

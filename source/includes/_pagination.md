# Pagination

> Pagination Request Example:

```shell
curl "api.basistheory.com/applications?page=2&size=10" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Pagination Response Example:

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

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`pagination` | *object* | Pagination metadata
`data` | *array* | Query results of the request. See list endpoint resource for response schema definition

### Pagination Response Object

Attribute | Type | Description
--------- | ---- | -----------
`total_items` | *integer* | Total number of items in the tenant
`page_number` | *integer* | Current page number. Should match `page` query parameter.
`page_size` | *integer* | The size of each page. Should match `size` query parameter.
`total_pages` | *integer* | The total number of pages.
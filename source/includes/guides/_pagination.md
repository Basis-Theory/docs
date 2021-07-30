All `List` endpoints support pagination to allow bulk fetching multiple items. Each `List` endpoint shares a common response structure. Examples of these requests can be seen in [List Applications](#list-applications), [List Tokens](#list-tokens), and [List Atomic Cards](#list-atomic-cards)

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`page` | false | *integer* | 1 | Page number of the results to return
`size` | false | *integer* | 20 | Number of results per page to return. Maximum size of 100 results.

## Response Schema

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
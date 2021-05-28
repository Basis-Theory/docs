# Atomic Banks

## Create Atomic Bank

> Create Atomic Bank Request Example:

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
      "bank": {
        "routing_number": "021000021",
        "account_number": "1234567890"
      }
    }
  }'
```

> Create Atomic Bank Response Example:

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "bank": {
    "routing_number": "021000021",
    "account_number": "XXXXXX7890"
  }
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/atomic/banks`
</span>

Create a new atomic bank for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:create</span>
  <span class="scope">token:write</span>
</p>

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`bank` | true | *bank* | `null` | [Bank object](#bank-object-schema)

### Bank Object Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`routing_number` | true | *string* | `null` | Nine-digit ABA routing number
`account_number` | true | *string* | `null` | Account number up to seventeen-digits

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get an atomic bank](#get-an-atomic-bank)
`tenant_id` | *string* | The tenant ID which owns the bank
`type` | *string* | `Bank` [token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the atomic bank
`created_at` | *string* | Created date of the application in ISO 8601 format
`bank` | *bank* | Masked [bank object](#bank-object-schema)

### Response Messages

Code | Description
---- | -----------
`201` | Atomic bank successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## List Atomic Banks

> List Atomic Banks Request Example:

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Atomic Banks Response Example:

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "type": "bank",
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2020-09-15T15:53:00+00:00",
      "bank": {
        "routing_number": "021000021",
        "account_number": "XXXXXX7890"
      }
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/banks`
</span>

Get a list of atomic banks for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:read</span>
  <span class="scope">token:read</span>
</p>

### Response Schema

Returns the [Pagination](#pagination) schema. The `data` attribute in the response contains an array of tokens with the following schema:

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get an atomic bank](#get-an-atomic-bank)
`tenant_id` | *string* | The tenant ID which owns the bank
`type` | *string* | `Bank` [token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the atomic bank
`created_at` | *string* | Created date of the application in ISO 8601 format
`bank` | *bank* | Masked [bank object](#bank-object-schema)

### Response Messages

Code | Description
---- | -----------
`200` | Atomic banks successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## Get an Atomic Bank

> Get Atomic Bank Request Example:

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Atomic Bank Response Example:

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "bank": {
    "routing_number": "021000021",
    "account_number": "XXXXXX7890"
  }
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/banks/{id}`
</span>

Get an atomic bank by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:read</span>
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the atomic bank

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get an atomic bank](#get-an-atomic-bank)
`tenant_id` | *string* | The tenant ID which owns the bank
`type` | *string* | `Bank` [token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the atomic bank
`created_at` | *string* | Created date of the application in ISO 8601 format
`bank` | *bank* | Masked [bank object](#bank-object-schema)

### Response Messages

Code | Description
---- | -----------
`200` | Atomic bank successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The atomic bank was not found


## Delete Atomic Bank

> Delete Token Request Example:

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/atomic/banks/{id}`
</span>

Delete an atomic bank by ID in the tenant.

<aside class="warning">
<span>WARNING - The data associated with a deleted atomic bank will be removed forever. The reference will still exists for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">bank:delete</span>
  <span class="scope">token:write</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the atomic bank

### Response Messages

Code | Description
---- | -----------
`204` | Atomic bank successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The atomic bank was not found


## Decrypt Atomic Bank

> Decrypt Token Request Example:

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/decrypt" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Decrypt Atomic Bank Response Example:

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "bank": {
    "routing_number": "021000021",
    "account_number": "1234567890"
  }
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/banks/{id}/decrypt`
</span>

Decrypt an atomic bank by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:decrypt</span>
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the atomic bank

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get an atomic bank](#get-an-atomic-bank)
`tenant_id` | *string* | The tenant ID which owns the bank
`type` | *string* | `Bank` [token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the atomic bank
`created_at` | *string* | Created date of the application in ISO 8601 format
`bank` | *bank* | Masked [bank object](#bank-object-schema)

### Response Messages

Code | Description
---- | -----------
`200` | Atomic bank successfully decrypted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The atomic bank was not found

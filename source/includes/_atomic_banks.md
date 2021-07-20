# Atomic Banks

## Atomic Bank Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the token which can be used to [get an atomic bank](#get-an-atomic-bank)
`tenant_id` | *uuid* | The [tenant](#tenants) ID which owns the bank
`type` | *string* | `Bank` [token type](#token-types)
`bank` | *[bank](#bank-object)* | Bank data
`metadata` | *any* | Non-sensitive token metadata. Can be an object, array, or any primitive type such as an integer, boolean, or string
`created_by` | *uuid* | The [application](#applications) ID which created the atomic bank
`created_at` | *date* | Created date of the application in ISO 8601 format

### Bank Object

Attribute | Type | Description
--------- | ---- | -----------
`routing_number` | *string* | Nine-digit ABA routing number
`account_number` | *string* | Account number up to seventeen-digits


## Create Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
      "bank": {
        "routing_number": "021000021",
        "account_number": "1234567890"
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      }
    }
  }'
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.CreateAsync(new AtomicBank {
  Bank = new Bank {
    RoutingNumber = "021000021",
    AccountNumber = "1234567890"
  },
  Metadata = new {
    nonSensitiveField = "Non-Sensitive Value"
  }
});
```

> Response

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "bank": {
    "routing_number": "021000021",
    "account_number": "XXXXXX7890"
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
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
  <span class="scope">token:create</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`bank` | true | *[bank](#bank-object)* | `null` | Bank data
`metadata` | false | *any* | `null` | Non-sensitive token metadata. Can be an object, array, or any primitive type such as an integer, boolean, or string

### Response

Returns an [atomic bank](#atomic-bank-object) with masked [bank data](#bank-object) if the atomic bank was created. Returns [an error](#errors) if there were validation errors or the atomic bank failed to create.


## List Atomic Banks

> Request

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBanks = await client.GetAsync();
```

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "type": "bank",
      "bank": {
        "routing_number": "021000021",
        "account_number": "XXXXXX7890"
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      },
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2020-09-15T15:53:00+00:00"
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

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [atomic banks](#atomic-bank-object). Providing any query parameters will filter the results. Returns [an error](#errors) if atomic banks could not be retrieved.


## Get an Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.GetByIdAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c");
```

> Response

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "bank": {
    "routing_number": "021000021",
    "account_number": "XXXXXX7890"
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
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
`id` | true | *uuid* | `null` | The ID of the atomic bank

### Response

Returns an [atomic bank](#atomic-bank-object) with the `id` provided. Returns [an error](#errors) if the atomic bank could not be retrieved.


## Delete Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c");
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
  <span class="scope">token:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic bank

### Response

Returns [an error](#errors) if the atomic bank failed to delete.


## Decrypt Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/decrypt" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.GetByIdAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c", 
  new BankGetByIdRequest {
    Decrypt = true
  });
```

> Response

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "bank": {
    "routing_number": "021000021",
    "account_number": "1234567890"
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
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
`id` | true | *uuid* | `null` | The ID of the atomic bank

### Response

Returns an [atomic bank](#atomic-bank-object) with plaintext [bank](#bank-object) data with the `id` provided. Returns [an error](#errors) if the atomic bank could not be retrieved.

## Exchange an Atomic Bank

> Request

```shell
curl "api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/exchange" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "POST"
  -D '{
    "exchange_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
  }'
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/atomic/banks/{id}/exchange`
</span>

Exchange an atomic bank by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:read</span>
  <span class="scope">bank:create</span>
  <span class="scope">bank:read</span>
  <span class="scope">token:create</span>
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic bank
`exchange_id` | true | *uuid* | `null` | The ID of the exchange
`metadata` | false | *any* | `null` | Non-sensitive token metadata. Can be an object, array, or any primitive type such as an integer, boolean, or string

### Response

Returns a [token](#token-object) with type of `bank:exchanged` if the atomic bank was exchanged. Returns [an error](#errors) if the atomic bank failed to exchange.

## Get an Atomic Bank Exchanged Token

> Request

```shell
curl "api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/exchanged/6c12a05d-99e3-4454-bdb0-2e6ff88ec5b0" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "GET"
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/banks/{atomicBankTokenId}/exchanged/{exchangedTokenId}`
</span>

Get an atomic bank exchanged token by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:read</span>
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`atomicBankTokenId` | true | *uuid* | `null` | The ID of the atomic bank
`exchangedTokenId` | true | *uuid* | `null` | The ID of the exchanged token

### Response

Returns a [token](#token-object) with type of `bank:exchanged`. Returns [an error](#errors) if the atomic bank failed to exchange.

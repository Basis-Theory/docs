# Tokens

## Token Types

Name | Type | Description
---- | ---- | -----------
Token | `token` | Generic token type. This is the default token type if none is provided when creating a new token
Card | `card` | [Atomic card](#atomic-cards) token type
Bank | `bank` | [Atomic bank](#atomic-banks) token type


## Create Token

> Create Token Request Example:

```shell
curl "https://api.basistheory.com/tokens" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
    "type": "token",
    "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
    "encryption": {
      "cek": {
        "key": "JLrtGbYSN5/dbqdKtLVG8tHu3QefcZnKsFOPBBXlXcG4zL9US01mW2MqZs6Px4ckSQM8CrRakwLKilrQ0f37Iw==",
        "alg": "AES"
      },
      "kek": {
        "key": "vpXn45HnsoQPR1q8ptngmPvPaqIDJ4vO+FFyQclglePCt8d1SyTDJU0T+F54T7GnAz7vz5OKsjgsFNo9lVB3UA==",
        "alg": "RSA"
      }
    },
    "children": [
      {...},
      {...}
    ]
  }'
```

> Create Token Response Example:

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "children": [
    {...},
    {...}
  ]
}
```

> Create Token Data Examples:

```json
{
  "data": "RandomString"
}
```

```json
{
  "data": true
}
```

```json
{
  "data": [1, 2, 3]
}
```

```json
{
  "data": { 
    "string_field": "RandomString",
    "int_field": 3,
    "bool_field": false,
    "array_field": [1, 2, 3]
    "object_field": {...} 
  }
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens`
</span>


Create a new token for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:create</span>
</p>

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`type` | false | *string* | `token` | [Token type](#token-types) of the token
`data` | true | *any* | `null` | Token data
`metadata` | false | *any* | `null` | Non-sensitive token metadata
`encryption` | false | *object* | `null` | Encryption metadata for an encrypted token data value
`children` | false | *array* | `[]` | An array of tokens, each of which follows the [create token](#create-token) request schema. Can be used to bulk create tokens with [token associations](#create-token-association)

### Encryption Object Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`cek` | false | *object* | `null` | Content [encryption key](#encryption-key-object-schema)
`kek` | false | *object* | `null` | Key [encryption key](#encryption-key-object-schema)

### Encryption Key Object Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`key` | false | *string* | `null` | Encryption key or key identifier
`alg` | false | *string* | `null` | Encryption algorithm (e.g. AES, RSA, etc)

<aside class="notice">
  <span><code>data</code> and <code>metadata</code> values can be an object, array, or any primitive type such as an integer, boolean, or string. See JSON examples for reference.</span>
</aside>

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the token
`type` | *string* | [Token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the token
`created_at` | *string* | Created date of the token in ISO 8601 format
`metadata` | *any* | The metadata provided when [creating the token](#create-token)
`children` | *array* | The child tokens provided when [creating the token](#create-token)

### Response Messages

Code | Description
---- | -----------
`201` | Token successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions

<aside class="success">
  <span>Basis Theory recommends encrypting the <code>data</code> attribute of the token. Our recommendation is encrypt the data with a one-time use symmetric encryption key such as <code>AES-256</code> and then encrypt the symmetric key with an asymmetric public key such as <code>RSA</code>. Our SDK will automatically handle this for you.</span>
</aside>

<aside class="warning">
  <span>WARNING - Never store sensitive plaintext information in your token such as plaintext <code>data</code>, <code>metadata</code> or plaintext, private encryption keys in the <code>encryption</code> attributes of your token.</span>
</aside>


## List Tokens

> List Tokens Request Example:

```shell
curl "https://api.basistheory.com/tokens" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Tokens Response Example:

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
      "type": "token",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      }
      "encryption": {
        "cek": {
          "key": "JLrtGbYSN5/dbqdKtLVG8tHu3QefcZnKsFOPBBXlXcG4zL9US01mW2MqZs6Px4ckSQM8CrRakwLKilrQ0f37Iw==",
          "alg": "AES"
        },
        "kek": {
          "key": "vpXn45HnsoQPR1q8ptngmPvPaqIDJ4vO+FFyQclglePCt8d1SyTDJU0T+F54T7GnAz7vz5OKsjgsFNo9lVB3UA==",
          "alg": "RSA"
        }
      },
      "children": [
        {...},
        {...}
      ]
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

> List Tokens by IDs Request Example:

```shell
curl "https://api.basistheory.com/tokens?id=c06d0789-0a38-40be-b7cc-c28a718f76f1&id=c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> List Tokens by Types Request Example:

```shell
curl "https://api.basistheory.com/tokens?type=card&type=bank" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> List Tokens with Children Request Example:

```shell
curl "https://api.basistheory.com/tokens?children=true" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> List Tokens with Children by Child Types Request Example:

```shell
curl "https://api.basistheory.com/tokens?children_type=card&children_type=bank" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens`
</span>

Get a list of tokens for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | false | *array* | `[]` | An optional list of token ID's to filter the list of tokens by
`type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter the list of tokens by
`children` | false | *boolean* | `false` | Include child tokens where the token is a parent in [token association](#token-associations)
`children_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter child tokens where the token is a parent in the [token association](#token-associations)

### Response Schema

Returns the [Pagination](#pagination) schema. The `data` attribute in the response contains an array of tokens with the following schema:

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the token
`type` | *string* | [Token type](#token-types)
`data` | *any* | The data provided when [creating the token](#create-token)
`metadata` | *any* | The metadata provided when [creating the token](#create-token)
`encryption` | *any* | The [encryption](#encryption-object-schema) data provided when [creating the token](#create-token)
`children` | *array* | An array of child tokens where the token is a parent in the [token association](#token-associations). Only populated if `children` or `children_type` query parameter is provided
`created_by` | *string* | The [application](#applications) ID which created the token
`created_at` | *string* | Created date of the token in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Tokens successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## Get a Token

> Get a Token Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Get a Token with Children Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1?children=true" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Get a Token with Children by Child Types Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1?children_type=card&children_type=bank" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Token Response Example:

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "type": "token",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  }
  "encryption": {
    "cek": {
      "key": "JLrtGbYSN5/dbqdKtLVG8tHu3QefcZnKsFOPBBXlXcG4zL9US01mW2MqZs6Px4ckSQM8CrRakwLKilrQ0f37Iw==",
      "alg": "AES"
    },
    "kek": {
      "key": "vpXn45HnsoQPR1q8ptngmPvPaqIDJ4vO+FFyQclglePCt8d1SyTDJU0T+F54T7GnAz7vz5OKsjgsFNo9lVB3UA==",
      "alg": "RSA"
    }
  },
  "children": [
    {...},
    {...}
  ]
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens/{id}`
</span>

Get a token by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the token

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`children` | false | *boolean* | `false` | Include child tokens where the token is a parent in [token association](#token-associations)
`children_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter child tokens where the token is a parent in the [token association](#token-associations)

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the token
`type` | *string* | [Token type](#token-types)
`data` | *any* | The data provided when [creating the token](#create-token)
`metadata` | *any* | The metadata provided when [creating the token](#create-token)
`encryption` | *any* | The [encryption](#encryption-object-schema) data provided when [creating the token](#create-token)
`children` | *array* | An array of child tokens where the token is a parent in the [token association](#token-associations). Only populated if `children` or `children_type` query parameter is provided
`created_by` | *string* | The [application](#applications) ID which created the token
`created_at` | *string* | Created date of the token in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Tokens successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The token was not found


## Delete Token

> Delete Token Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tokens/{id}`
</span>


Delete a token by ID in the tenant.

<aside class="warning">
<span>WARNING - The data associated with a deleted token will be removed forever. The reference will still exists for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">token:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the token

### Response Messages

Code | Description
---- | -----------
`204` | Token successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The token was not found

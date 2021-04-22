# Tokens

## Token Types

Name | Type | Description
---- | ---- | -----------
Token | `token` | Generic token type. This is the default token type if none is provided when creating a new token
Card | `card` | [Atomic card](#atomic-cards) token type


## Create Token

> Create Token Request Example:

```shell
curl "api.basistheory.com/tokens" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
    "type": "token",
    "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
    "metadata": {
      "NonSensitiveField": "Non-Sensitive Value"
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
    }
  }'
```

> Create Token Response Example:

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "owner_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "created_at": "2020-09-15T15:53:00+00:00",
  "metadata": {
    "NonSensitiveField": "Non-Sensitive Value"
  }
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

<span class="http-method post">POST</span> `https://api.basistheory.com/tokens`

Create a new token for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:write</span>
</p>

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`type` | false | *string* | `token` | [Token type](#token-types) of the token
`data` | true | *any* | `null` | Token data
`metadata` | false | *any* | `null` | Non-sensitive token metadata
`encryption` | false | *object* | `null` | Encryption metadata for an encrypted token data value

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
  <code>data</code> and <code>metadata</code> values can be an object, array, or any primitive type such as an integer, boolean, or string. See JSON examples for reference.
</aside>

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`owner_id` | *string* | The tenant ID which owns the token
`type` | *string* | [Token type](#token-types)
`created_at` | *string* | Created date of the token in ISO 8601 format
`metadata` | *any* | The metadata provided when [creating the token](#create-token)

### Response Messages

Code | Description
---- | -----------
`201` | Token successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions

<aside class="success">
  Basis Theory recommends encrypting the <code>data</code> attribute of the token. Our recommendation is encrypt the data with a one-time use symmetric encryption key such as <code>AES-256</code> and then encrypt the symmetric key with an asymmetric public key such as <code>RSA</code>. Our SDK will automatically handle this for you.
</aside>

<aside class="warning">
  WARNING - Never store sensitive plaintext information in your token such as plaintext <code>data</code>, <code>metadata</code> or plaintext, private encryption keys in the <code>encryption</code> attributes of your token.
</aside>


## List Tokens

> List Tokens Request Example:

```shell
curl "api.basistheory.com/tokens" \
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
      "owner_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
      "metadata": {
        "NonSensitiveField": "Non-Sensitive Value"
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
      "created_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">GET</span> `https://api.basistheory.com/tokens`

Get a list of tokens for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

### Response Schema

Returns the [Pagination](#pagination) schema. The `data` attribute in the response contains an array of tokens with the following schema:

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`owner_id` | *string* | The tenant ID which owns the token
`type` | *string* | [Token type](#token-types)
`data` | *any* | The data provided when [creating the token](#create-token)
`metadata` | *any* | The metadata provided when [creating the token](#create-token)
`encryption` | *any* | The [encryption](#encryption-object-schema) data provided when [creating the token](#create-token)
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
curl "api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Token Response Example:

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "type": "token",
  "owner_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
  "metadata": {
    "NonSensitiveField": "Non-Sensitive Value"
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
  "created_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">GET</span> `https://api.basistheory.com/tokens/{id}`

Get a token by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the token

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`owner_id` | *string* | The tenant ID which owns the token
`type` | *string* | [Token type](#token-types)
`data` | *any* | The data provided when [creating the token](#create-token)
`metadata` | *any* | The metadata provided when [creating the token](#create-token)
`encryption` | *any* | The [encryption](#encryption-object-schema) data provided when [creating the token](#create-token)
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
curl "api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

<span class="http-method delete">DELETE</span> `https://api.basistheory.com/tokens/{id}`

Delete a token by ID in the tenant.

<aside class="warning">
WARNING - The data associated with a deleted token will be removed forever. The reference will still exists for audit purposes
</aside>

### Permissions

<p class="scopes">
  <span class="scope">token:write</span>
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
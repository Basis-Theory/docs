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
  "data": "true"
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

POST `https://api.basistheory.com/tokens`

Create a new token for the tenant.

### Permissions

`token:write`

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`type` | false | *string* | `token` | [Token type](#token-types) of the token
`data` | true | *any* | `null` | Token data
`metadata` | false | *any* | `null` | Non-sensitive token metadata
`encryption` | false | *object* | `null` | Encryption metadata for an encrypted token data value

### Encryption Request Object

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`cek` | false | *object* | Content [encryption key](#encryption-key-request-object)
`kek` | false | *object* | Key [encryption key](#encryption-key-request-object)

### Encryption Key Request Object

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`key` | false | *string* | Encryption key or key identifier
`alg` | false | *string* | Encryption algorithm (e.g. AES, RSA, etc)

<aside class="notice">
  <code>data</code> and <code>metadata</code> values can be an object, array, or any primitive type such as an integer, boolean, or string. See JSON examples for reference.
</aside>

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`owner_id` | *string* | The tenant ID which owns the application
`type` | *string* | [Token type](#token-types)
`created_at` | *string* | Created date of the application in ISO 8601 format
`metadata` | *any* | The metadata provided when creating the token

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

## Get a Token

## Delete Token


## Create a new token

```shell
curl --request POST \
  "https://api-dev.basistheory.com/tokens" \
  --header 'Content-Type: application/json' \
  --header "X-API-KEY: test_123456790"
  --data '{
  "data": "string or object data",
  }'
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")

BasisTheory.vault.createToken("string or object data")
  .then(function (res) { 
      console.log(res.id) // token id, e.g. "bt_tok_1234" 
  });
```

> The above command returns JSON structured like this:

```json
{
  "id": "tok_1234",
  "data": "{encrypted_data}"
}
```

This endpoint tokenize any set of data passed to the `/tokens` endpoint. This will store and encrypt you data and return a uniquely generated token back to you. 

### HTTP Request

`POST https://api-dev.basistheory.com/tokens`

### Required Scopes

- `vault:write`

### Query Parameters

Parameter | Description
--------- | -----------
data | string or object to be tokenized

### Response Properties

Parameter | Description
--------- | -----------
id | the id of the token that has been created
data | string or object that was tokenized

## Get an existing token

```shell
curl "https://api-dev.basistheory.com/tokens/tok_1234" \
  -H "X-API-KEY: test_123456790"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")

let token = BasisTheory.vault.getToken("tok_1234")
  .then(function (res) { 
      console.log(res.data); // string or object data 
  });
```

> The above command returns JSON structured like this:

```json
{
  "token": "tok_1234",
  "data": "{encrypted_data}"
}
```

Returns the raw data associated with a `token`

### HTTP Request

`GET https://api-dev.basistheory.com/tokens/:token_id`

### Required Scopes

- `vault:read`

### Query Parameters

Parameter | Description
--------- | -----------
token_id | token id that you want to retrieve

### Response Properties

Parameter | Description
--------- | -----------
id | the id of the token that has been created
data | string or object that was tokenized


## List your tokens

```shell
curl "https://api-dev.basistheory.com/tokens" \
  -H "X-API-KEY: test_123456790"
```

> The above command returns JSON structured like this:

```json
[
  {
    "token": "tok_1234",
    "data": "{encrypted_data}"
  },
  //... additional tokens
]
```

Returns the raw data associated with a `token`.

### HTTP Request

`GET https://api-dev.basistheory.com/tokens`

### Required Scopes

- `vault:read`

### Query Parameters

Parameter | Description
--------- | -----------
token_id | token id that you want to retrieve

### Response Properties

Parameter | Description
--------- | -----------
id | the id of the token that has been created
data | string or object that was tokenized

## Delete a token

```shell
curl "https://api-dev.basistheory.com/tokens/tok_1234" \
  -X DELETE \
  -H "Authorization: api_key_1234"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("api_key_1234")

BasisTheory.vault.deleteToken("tok_1234");
```

This endpoint will remove any underlying data associated with the token, we will retain the token reference and audit logs for future reference. The data will be permanently deleted.

<aside class="warning">
WARNING - The data associated with a deleted token will be removed forever. The reference will still exists for audit purposes
</aside>

### HTTP Request

`DELETE http://api.basistheory.com/tokens/:token_id`

### Required Scopes

- `vault:delete`

### URL Parameters

Parameter | Description
--------- | -----------
token_id | token id that you want to retrieve


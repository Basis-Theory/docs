# Token Associations

Token associations allow you to associate any two tokens, of any type, together. This allows you to create parent-child relationships between tokens and do token traversal between tokens.

## Create Token Association

> Create Token Association Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens/{parent_id}/children/{child_id}`
</span>

Create a new parent/child association between two tokens in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:create</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`parent_id` | true | *string* | `null` | The ID of the parent token
`child_id` | true | *string* | `null` | The ID of the child token

<aside class="notice">
  <span>Bi-directional associations can be made between two tokens by creating a token association and swapping the <code>parent_id</code> and <code>child_id</code>.</span>
</aside>

### Response Messages

Code | Description
---- | -----------
`204` | Token association successfully created
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The parent or child token was not found


## Delete Token Association

> Delete Token Association Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "DELETE"
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tokens/{parent_id}/children/{child_id}`
</span>

Delete a parent/child association between two tokens in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`parent_id` | true | *string* | `null` | The ID of the parent token
`child_id` | true | *string* | `null` | The ID of the child token

### Response Messages

Code | Description
---- | -----------
`204` | Token association successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The parent or child token was not found


## Create Child Token for a Token

> Create Child Token for a Token Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children" \
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

> Create Child Token Response Example:

```json
{
  "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
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

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens/{parent_id}/children`
</span>

Create a new child token a token in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:create</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`parent_id` | true | *string* | `null` | The ID of the parent token

### Request Schema

A token which follows the [create token](#create-token) request schema. Can be used to bulk create tokens with [token associations](#create-token-association)

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the token
`type` | *string* | [Token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the token
`created_at` | *string* | Created date of the token in ISO 8601 format
`metadata` | *any* | The metadata provided when [creating the child token](#create-child-token-for-a-token)
`children` | *array* | The child tokens provided when [creating the child token](#create-child-token-for-a-token)

### Response Messages

Code | Description
---- | -----------
`201` | Child token successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## List Child Tokens for a Token

> List Child Tokens for a Token Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Child Tokens Response Example:

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
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

> List Child Tokens by IDs Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children?id=c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> List Child Tokens by Types Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children?type=card&type=bank" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> List Child Tokens with Children Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children?children=true" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> List Child Tokens with Children by Child Types Request Example:

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children?children_type=card&children_type=bank" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens/{parent_id}/children`
</span>

Get a list of child tokens for a token in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`parent_id` | true | *string* | `null` | The ID of the parent token

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | false | *array* | `[]` | An optional list of token ID's to filter the list of child tokens by
`type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter the list of child tokens by
`children` | false | *boolean* | `false` | Include child tokens where the child token is a parent in [token association](#token-associations)
`children_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter child tokens where the child token is a parent in the [token association](#token-associations)

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
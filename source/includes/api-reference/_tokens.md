# Tokens

## Token Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the token which can be used to [get a token](#get-a-token)
`tenant_id` | *uuid* | The [Tenant](#tenant-object) ID which owns the token
`type` | *string* | [Token type](#token-types)
`data` | *any* | Token data
`metadata` | *map* | A key-value map of non-sensitive data.
`encryption` | *[encryption object](#encryption-object)* | Encryption metadata for an encrypted token data value
`children` | *array* | Array of child tokens where this token is the parent in an [association](#token-associations)
`created_by` | *uuid* | The [Application](#application-object) ID which created the token
`created_at` | *date* | Created date of the token in ISO 8601 format

### Encryption Object

Attribute | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`cek` | *[encryption key](#encryption-key-object)* | Content encryption key
`kek` | *[encryption key](#encryption-key-object)* | Key encryption key

### Encryption Key Object

Attribute | Type | Default | Description
--------- | ---- | ------- | -----------
`key` | *string* | Encryption key or key identifier
`prov` | *string* | An optional provider to simplify lookup of the encryption key for the provider
`alg` | *string* | Encryption algorithm (e.g. AES, RSA, etc)


## Token Types

Name | Type | Description
---- | ---- | -----------
Token | `token` | Generic token type. This is the default token type if none is provided when creating a new token
Card | `card` | [Atomic card](#atomic-cards) token type
Bank | `bank` | [Atomic bank](#atomic-banks) token type
Card Reaction | `card:reaction` | This token type is the resulting token type of a reacted [Atomic card](#atomic-cards) token
Bank Reaction | `bank:reaction` | This token type is the resulting token type of a reacted [Atomic bank](#atomic-banks) token


## Create Token

> Request

```shell
curl "https://api.basistheory.com/tokens" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "type": "token",
    "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    },
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

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.create({
  type: 'token',
  data: 'ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==',
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  },
  encryption: {
    cek: {
      key: 'JLrtGbYSN5/dbqdKtLVG8tHu3QefcZnKsFOPBBXlXcG4zL9US01mW2MqZs6Px4ckSQM8CrRakwLKilrQ0f37Iw==',
      alg: 'AES'
    },
    kek: {
      key: 'vpXn45HnsoQPR1q8ptngmPvPaqIDJ4vO+FFyQclglePCt8d1SyTDJU0T+F54T7GnAz7vz5OKsjgsFNo9lVB3UA==',
      alg: 'RSA'
    }
  },
  children: [
    { ... },
    { ... }
  ]
});
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.CreateAsync(new Token {
  Type = "token",
  Data = "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField",  "Non-Sensitive Value" }
  },
  Encryption = new Encryption {
    ContentEncryptionKey = new EncryptionKey {
      Key = "JLrtGbYSN5/dbqdKtLVG8tHu3QefcZnKsFOPBBXlXcG4zL9US01mW2MqZs6Px4ckSQM8CrRakwLKilrQ0f37Iw==",
      Algorithm: "AES"
    },
    KeyEncryptionKey = new EncryptionKey {
      Key = "vpXn45HnsoQPR1q8ptngmPvPaqIDJ4vO+FFyQclglePCt8d1SyTDJU0T+F54T7GnAz7vz5OKsjgsFNo9lVB3UA==",
      Algorithm: "RSA"
    }
  },
  Children = new List<Token> {
    new Token { ... },
    new Token { ... }
  }
});
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "children": [
    {...},
    {...}
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens`
</span>

Create a new token for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:create</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`type` | false | *string* | `token` | [Token type](#token-types) of the token
`data` | true | *any* | `null` | Token data. Can be an object, array, or any primitive type such as an integer, boolean, or string
`metadata` | false | *map* | `null` | A key-value map of non-sensitive data.
`encryption` | false | *[encryption object](#encryption-object)* | `null` | Encryption metadata for an encrypted token data value
`children` | false | *array* | `[]` | An array of [tokens](#token-object). Can be used to bulk create tokens with [token associations](#create-token-association)

<aside class="success">
  <span>Basis Theory recommends encrypting the <code>data</code> attribute of the token. Our recommendation is encrypt the data with a one-time use symmetric encryption key such as <code>AES-256</code> and then encrypt the symmetric key with an asymmetric public key such as <code>RSA</code>. Our SDK will automatically handle this for you.</span>
</aside>

<aside class="warning">
  <span>WARNING - Never store sensitive plaintext information in your token such as plaintext <code>data</code>, <code>metadata</code> or plaintext, private encryption keys in the <code>encryption</code> attributes of your token.</span>
</aside>


### Response

Returns a [token](#token-object) if the token was created. Returns [an error](#errors) if there were validation errors, or the token failed to create.


## List Tokens

> Request

```shell
curl "https://api.basistheory.com/tokens" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tokens = await bt.tokens.list();
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var tokens = await client.GetAsync();
```

> Response

```json
{
  "pagination": {...},
  "data": [
    {
      "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
      "type": "token",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      },
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
      ],
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens`
</span>

Get a list of tokens for the Tenant.

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

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [tokens](#token-object). Providing any query parameters will filter the results. Returns [an error](#errors) if tokens could not be retrieved.


## List Decrypted Tokens

> Request

```shell
curl "https://api.basistheory.com/tokens/decrypt" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tokens = await bt.tokens.listDecrypted();
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var tokens = await client.GetAsync(new TokenGetRequest { Decrypt = true });
```

> Response

```json
{
  "pagination": {...},
  "data": [
    {
      "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
      "type": "token",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      },
      "children": [
        {...},
        {...}
      ],
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens/decrypt`
</span>

Get a list of decrypted tokens for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:decrypt</span>
</p>

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | false | *array* | `[]` | An optional list of token ID's to filter the list of tokens by
`type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter the list of tokens by
`children` | false | *boolean* | `false` | Include child tokens where the token is a parent in [token association](#token-associations)
`children_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter child tokens where the token is a parent in the [token association](#token-associations)
`decrypt_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter token types that should be decrypted

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of decrypted [tokens](#token-object). Providing any query parameters will filter the results. Returns [an error](#errors) if tokens could not be retrieved.
Token types other than `token` or non-BasisTheory encrypted tokens will not be decrypted.


## Get a Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.retrieve('c06d0789-0a38-40be-b7cc-c28a718f76f1');
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.GetByIdAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1");
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "type": "token",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
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
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens/{id}`
</span>

Get a token by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the token

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`children` | false | *boolean* | `false` | Include child tokens where the token is a parent in [token association](#token-associations)
`children_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter child tokens where the token is a parent in the [token association](#token-associations)

### Response

Returns a [token](#token-object) with the `id` provided. Returns [an error](#errors) if the token could not be retrieved.


## Get a Decrypted Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/decrypt" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.retrieveDecrypted('c06d0789-0a38-40be-b7cc-c28a718f76f1');
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.GetByIdAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1", new TokenGetByIdRequest { Decrypt = true });
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "type": "token",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "data": "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "children": [
    {...},
    {...}
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens/{id}/decrypt`
</span>

Get a decrypted token by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:decrypt</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the token

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`children` | false | *boolean* | `false` | Include child tokens where the token is a parent in [token association](#token-associations)
`children_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter child tokens where the token is a parent in the [token association](#token-associations)
`decrypt_type` | false | *array* | `[]` | An optional array of [token types](#token-types) to filter token types that should be decrypted

### Response

Returns a decrypted [token](#token-object) with the `id` provided. Returns [an error](#errors) if the token could not be retrieved.
Token types other than `token` or non-BasisTheory encrypted tokens will not be decrypted.


## Delete Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.tokens.delete('c06d0789-0a38-40be-b7cc-c28a718f76f1');
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tokens/{id}`
</span>

Delete a token by ID in the Tenant.

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
`id` | true | *uuid* | `null` | The ID of the token

### Response

Returns [an error](#errors) if the token failed to delete.

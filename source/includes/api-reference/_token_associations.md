# Token Associations

Token associations allow you to associate any two tokens, of any type, together. This allows you to create parent-child relationships between tokens and traverse between tokens.

## Create Token Association

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.tokens.createAssociation('c06d0789-0a38-40be-b7cc-c28a718f76f1', 
  'c1e565009-1984-4638-8fca-dce8a82cc2af');
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

await client.CreateAssociationAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1", 
  "c1e565009-1984-4638-8fca-dce8a82cc2af");
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens/{parent_id}/children/{child_id}`
</span>

Create a new parent/child association between two tokens in the Tenants.

### Permissions

<p class="scopes">
  <span class="scope">token:create</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`parent_id` | true | *uuid* | `null` | The ID of the parent token
`child_id` | true | *uuid* | `null` | The ID of the child token

<aside class="notice">
  <span>Bi-directional associations can be made between two tokens by creating a token association and swapping the <code>parent_id</code> and <code>child_id</code>.</span>
</aside>

### Response

Returns [an error](#errors) if the token association failed to create.


## Delete Token Association

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.tokens.deleteAssociation('c06d0789-0a38-40be-b7cc-c28a718f76f1', 
  'c1e565009-1984-4638-8fca-dce8a82cc2af');
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAssociationAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1", 
  "c1e565009-1984-4638-8fca-dce8a82cc2af");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tokens/{parent_id}/children/{child_id}`
</span>

Delete a parent/child association between two tokens in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`parent_id` | true | *uuid* | `null` | The ID of the parent token
`child_id` | true | *uuid* | `null` | The ID of the child token

### Response

Returns [an error](#errors) if the token association failed to delete.


## Create Child Token for a Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
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

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.createChild('c06d0789-0a38-40be-b7cc-c28a718f76f1', {
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

var token = await client.CreateChildAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1", 
  new Token {
    Type = "token",
    Data = "ebSG3IohNmg5gTOjN2HBwBbhjDZ6BY3fCWZJfXSucVMfQ+7YNMXQYrPuRSXgSkhuTMYS+BNfVUur4qZSvUbgCA==",
    Metadata = new Dictionary<string, string> {
      { "nonSensitiveField", "Non-Sensitive Value" }
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
  }
);
```

> Response

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

Create a new child token a token in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:create</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`parent_id` | true | *string* | `null` | The ID of the parent token

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`type` | false | *string* | `token` | [Token type](#token-types) of the token
`data` | true | *any* | `null` | Token data
`metadata` | false | *map* | `null` | A key-value map of non-sensitive data.
`encryption` | false | *[encryption object](#encryption-object)* | `null` | Encryption metadata for an encrypted token data value
`children` | false | *array* | `[]` | An array of [tokens](#token-object). Can be used to bulk create tokens with [token associations](#create-token-association)

### Response

Returns a [token](#token-object) if the child token was created for the parent token. Returns [an error](#errors) if there were validation errors, or the token failed to create.


## List Child Tokens for a Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tokens = await bt.tokens.listChildren('c06d0789-0a38-40be-b7cc-c28a718f76f1');
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var tokens = await client.GetChildrenAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1");
```

> Response

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

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tokens/{parent_id}/children`
</span>

Get a list of child tokens for a token in the Tenant.

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

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [child tokens](#token-object) for the parent token. Providing any query parameters will filter the child tokens. Returns [an error](#errors) if tokens could not be retrieved.

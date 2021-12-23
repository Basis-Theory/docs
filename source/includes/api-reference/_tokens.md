# Tokens

<aside class="notice">
  <span>Want to understand how to own the encryption of your data? Checkout the <a href="https://guides.basistheory.com/guides/own-your-encryption-keys/" target="_blank">Own Your Encryption Keys Guide</a> and our <a href="/encryption">Encryption Reference Documentation</a>.</span>
</aside>

## Token Object

| Attribute     | Type                                                          | Description                                                                                                                  |
|---------------|---------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| `id`          | *uuid*                                                        | Unique identifier of the token which can be used to [get a token](#get-a-token)                                              |
| `tenant_id`   | *uuid*                                                        | The [Tenant](#tenants-tenant-object) ID which owns the token                                                                 |
| `type`        | *string*                                                      | [Token type](#tokens-token-types)                                                                                            |
| `data`        | *any*                                                         | Token data                                                                                                                   |
| `fingerprint` | *string*                                                      | Uniquely identifies the contents of this token. Fingerprints are only available for Atomic Card and Atomic Bank token types. |
| `privacy`     | *[privacy object](#tokens-token-object-privacy-object)*       | Token Privacy Settings                                                                                                       |
| `metadata`    | *map*                                                         | A key-value map of non-sensitive data.                                                                                       |
| `encryption`  | *[encryption object](#tokens-token-object-encryption-object)* | Encryption metadata for an encrypted token data value                                                                        |
| `created_by`  | *uuid*                                                        | (Optional) The [Application](#applications-application-object) ID which created the token                                    |
| `created_at`  | *date*                                                        | (Optional) Created date of the token in ISO 8601 format                                                                      |
| `modified_by` | *uuid*                                                        | (Optional) The [Application](#applications) ID which last modified the token                                                 |
| `modified_at` | *date*                                                        | (Optional) Last modified date of the token in ISO 8601 format                                                                |

### Encryption Object

| Attribute | Type                                                           | Description            |
|-----------|----------------------------------------------------------------|------------------------|
| `cek`     | *[encryption key](#tokens-token-object-encryption-key-object)* | Content encryption key |
| `kek`     | *[encryption key](#tokens-token-object-encryption-key-object)* | Key encryption key     |

<aside class="success">
  <span>Basis Theory encrypts the <code>data</code> attribute of the token with a one-time use <code>AES-256</code> symmetric encryption key and then encrypts the symmetric key with an asymmetric <code>RSA</code> public key. Our SDK will automatically handle this for you if you use our encryption modules to encrypt each token with your own encryption keys.</span>
</aside>

### Encryption Key Object

| Attribute | Type     | Description                                               |
|-----------|----------|-----------------------------------------------------------|
| `key`     | *string* | Encryption key or key identifier                          |
| `prov`    | *string* | Optional encryption provider (e.g. AWS, AZURE, GCP, etc.) |
| `alg`     | *string* | Encryption algorithm (e.g. AES, RSA, etc)                 |

### Privacy Object

Token Privacy defines the privacy settings applied to a Token. By default, privacy settings will be applied based on the [Token Type](#tokens-token-types).
Default privacy settings can be overridden at the time of creation, but only to a setting with a higher specificity level.

| Attribute            | Type     | Description                                                                                                                                                                            |
|----------------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `classification`     | *string* | [Classification](#tokens-token-classifications) of the Token (e.g. `general`, `bank`, `pci`)                                                                                           |
| `impact_level`       | *string* | [Impact level](#tokens-token-impact-levels) of the Token (i.e. `low`, `moderate`, `high`)                                                                                              |
| `restriction_policy` | *string* | [Restriction policy](#tokens-token-restriction-policies) applied to the Token when read by a User or Application with read permissions at a lower impact level (i.e. `mask`, `redact`) |

## Token Types

| Name  | Type    | Description                             | Default Classification | Default Impact Level | Minimum Impact Level | Default Restriction Policy |
|-------|---------|-----------------------------------------|------------------------|----------------------|----------------------|----------------------------|
| Token | `token` | Generic token type                      | `general`              | `high`               | `low`                | `redact`                   |
| Card  | `card`  | [Atomic card](#atomic-cards) token type | `pci`                  | `high`               | `high`               | `mask`                     |
| Bank  | `bank`  | [Atomic bank](#atomic-banks) token type | `bank`                 | `high`               | `high`               | `mask`                     |

## Token Classifications

Each token has a data classification associated with it which defines the type of data it contains.
Basis Theory permissions access to Tokens based on data classifications (see [Token Permissions](#permissions-permission-types-token-permissions) for more details). 
The following data classifications are supported:

| Name      | Description                                                                                                | Specificity Level |
|-----------|------------------------------------------------------------------------------------------------------------|-------------------|
| `general` | Contains sensitive data that does not fall under a more specific classification or compliance requirements | 0                 |
| `bank`    | Contains data that falls under banking compliance (e.g. Nacha)                                             | 10                |
| `pci`     | Contains data that falls under PCI compliance                                                              | 10                |
| `pii`     | Contains user or customer specific identifiers (e.g. email, date of birth, address)                        | 10                |

## Token Impact Levels

Basis Theory follows the standard **<a href="https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.199.pdf#page=6" target="_blank">NIST-defined impact levels</a>** of low, moderate, and high to classify the impact unauthorized exposure of a particular piece of data would have on an organization.
Token impact levels are used to further classify and permit access to Tokens within a [Token Classification](#tokens-token-classifications).

| Name       | Description                                                                                                            | Specificity Level |
|------------|------------------------------------------------------------------------------------------------------------------------|-------------------|
| `low`      | Loss of data confidentiality, integrity, or availability is expected to have **limited** adverse effect                | 0                 |
| `moderate` | Loss of data confidentiality, integrity, or availability is expected to have **serious** adverse effect                | 1                 |
| `high`     | Loss of data confidentiality, integrity, or availability is expected to have **severe or catastrophic** adverse effect | 2                 |


## Token Restriction Policies

A Token Restriction Policy defines the policy to enforce on a Token's data when read by a User or Application
with permission to read the Token's classification but at a lower impact level.

| Name     | Description                                                                                                                          | Specificity Level |
|----------|--------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| `mask`   | Token data will be masked in the response, falling back to `redact` restriction policy if a mask is not available for the Token Type | 0                 |
| `redact` | Token data will be completely removed in the response                                                                                | 1                 |


## Create Token

> Request

```shell
curl "https://api.basistheory.com/tokens" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "type": "token",
    "data": "Sensitive Value",
    "privacy": {
      "impact_level": "moderate"
    },
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.create({
  type: 'token',
  data: 'Sensitive Value',
  privacy: {
    impactLevel: "moderate"
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  }
});
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.CreateAsync(new Token {
  Type = "token",
  Data = "Sensitive Value",
  Privacy = new DataPrivacy {
    ImpactLevel = DataImpactLevel.MODERATE
  },
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField",  "Non-Sensitive Value" }
  }
});
```

```python
import basistheory
from basistheory.api import tokens_api
from basistheory.model.token import Token

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    token = token_client.create(token=Token(
        type="token",
        data="Sensitive Value",
        metadata={
            "nonSensitiveField": "Non-Sensitive Value"
        }
    ))
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "privacy": {
    "classification": "general",
    "impact_level": "moderate",
    "restriction_policy": "redact"
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
  `https://api.basistheory.com/tokens`
</span>

Create a new token for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:&lt;classification&gt;:create</span>
</p>

### Request Parameters

| Attribute    | Required | Type                                                          | Default | Description                                                                                                                                                  |
|--------------|----------|---------------------------------------------------------------|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `type`       | true     | *string*                                                      | `null`  | [Token type](#tokens-token-types) of the token                                                                                                               |
| `data`       | true     | *any*                                                         | `null`  | Token data. Can be an object, array, or any primitive type such as an integer, boolean, or string                                                            |
| `privacy`    | false    | *[privacy object](#tokens-token-object-privacy-object)*       | `null`  | Token Privacy Settings overrides. Overrides must be a higher specificity level than the default or minimum setting for the [Token Type](#token-token-types). |
| `metadata`   | false    | *map*                                                         | `null`  | A key-value map of non-sensitive data.                                                                                                                       |
| `encryption` | false    | *[encryption object](#tokens-token-object-encryption-object)* | `null`  | Encryption metadata for an encrypted token data value                                                                                                        |

<aside class="warning">
  <span>WARNING - Never store sensitive plaintext information in the <code>metadata</code> or plaintext, private encryption keys in the <code>encryption</code> attributes of your token.</span>
</aside>


### Response

Returns a [token](#tokens-token-object) if the token was created. Returns [an error](#errors) if there were validation errors, or the token failed to create.


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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    tokens = token_client.list()
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
      "data": null, // Redacted based on Restriction Policy
      "privacy": {
        "classification": "general",
        "impact_level": "moderate",
        "restriction_policy": "redact"
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      },
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
  <span class="scope">token:&lt;classification&gt;:read:&lt;impact_level&gt;</span>
</p>

### Query Parameters

| Parameter       | Required | Type      | Default | Description                                                                                                                                                |
|-----------------|----------|-----------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`            | false    | *array*   | `[]`    | An optional list of token ID's to filter the list of tokens by                                                                                             |
| `type`          | false    | *array*   | `[]`    | An optional array of [token types](#tokens-token-types) to filter the list of tokens by                                                                    |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [tokens](#tokens-token-object). Providing any query parameters will filter the results. Returns [an error](#errors) if tokens could not be retrieved.


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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    tokens = token_client.list_decrypted()
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
      "data": "Sensitive Value",
      "privacy": {
        "classification": "general",
        "impact_level": "moderate",
        "restriction_policy": "redact"
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      },
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
  <span class="scope">token:&lt;classification&gt;:read:&lt;impact_level&gt;</span>
</p>

### Query Parameters

| Parameter       | Required | Type      | Default | Description                                                                                                                                                |
|-----------------|----------|-----------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`            | false    | *array*   | `[]`    | An optional list of token ID's to filter the list of tokens by                                                                                             |
| `type`          | false    | *array*   | `[]`    | An optional array of [token types](#tokens-token-types) to filter the list of tokens by                                                                    |
| `decrypt_type`  | false    | *array*   | `[]`    | An optional array of [token types](#tokens-token-types) to filter token types that should be decrypted                                                     |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of decrypted [tokens](#tokens-token-object). Providing any query parameters will filter the results. Returns [an error](#errors) if tokens could not be retrieved.
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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    token = token_client.get_by_id(id="c06d0789-0a38-40be-b7cc-c28a718f76f1")
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "type": "token",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "data": null, // Redacted based on Restriction Policy
  "privacy": {
    "classification": "general",
    "impact_level": "moderate",
    "restriction_policy": "redact"
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
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
  <span class="scope">token:&lt;classification&gt;:read:&lt;impact_level&gt;</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description         |
|-----------|----------|--------|---------|---------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the token |

### Response

Returns a [token](#tokens-token-object) with the `id` provided. Returns [an error](#errors) if the token could not be retrieved.


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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    token = token_client.get_decrypted(id="c06d0789-0a38-40be-b7cc-c28a718f76f1")
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "type": "token",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "data": "Sensitive Value",
  "privacy": {
    "classification": "general",
    "impact_level": "moderate",
    "restriction_policy": "redact"
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
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
  <span class="scope">token:&lt;classification&gt;:read:&lt;impact_level&gt;</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description         |
|-----------|----------|--------|---------|---------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the token |

### Query Parameters

| Parameter       | Required | Type      | Default | Description                                                                                                                                                |
|-----------------|----------|-----------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `decrypt_type`  | false    | *array*   | `[]`    | An optional array of [token types](#tokens-token-types) to filter token types that should be decrypted                                                     |

### Response

Returns a decrypted [token](#tokens-token-object) with the `id` provided. Returns [an error](#errors) if the token could not be retrieved.
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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    token_client.delete(id="c06d0789-0a38-40be-b7cc-c28a718f76f1")
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
  <span class="scope">token:&lt;classification&gt;:delete</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description         |
|-----------|----------|--------|---------|---------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the token |

### Response

Returns [an error](#errors) if the token failed to delete.

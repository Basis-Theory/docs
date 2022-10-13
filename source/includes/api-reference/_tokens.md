# Tokens

## Token Object

| Attribute                | Type                                                    | Description                                                                                                                                                                                                                     |
|--------------------------|---------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`                     | *string*                                                | Unique identifier of the token which can be used to [get a token](#get-a-token)                                                                                                                                                 |
| `tenant_id`              | *uuid*                                                  | The [Tenant](#tenants-tenant-object) ID which owns the token                                                                                                                                                                    |
| `type`                   | *string*                                                | [Token type](#token-types)                                                                                                                                                                                                      |
| `data`                   | *any*                                                   | Token data                                                                                                                                                                                                                      |
| `mask`                   | *any*                                                   | An [expression](/expressions/#masks) defining the mask to apply when retrieving token data with restricted permissions.                                                                                                         |
| `fingerprint`            | *string*                                                | Uniquely identifies the contents of this token. See [Token Types](#token-types) for the default expression for each token type.                                                                                                 |
| `privacy`                | *[privacy object](#tokens-token-object-privacy-object)* | (Deprecated) Token Privacy Settings                                                                                                                                                                                             |
| `containers`             | *array*                                                 | Array of containers to place this token within. Each container is a path representing a logical grouping of tokens. See [Token Containers](https://developers.basistheory.com/concepts/what-are-token-containers/) for details. |
| `metadata`               | *map<string, string>*                                   | A key-value map of strings containing non-sensitive data.                                                                                                                                                                       |
| `created_by`             | *uuid*                                                  | The [Application](#applications-application-object) ID which created the token                                                                                                                                                  |
| `created_at`             | *date*                                                  | Created date of the token in ISO 8601 format                                                                                                                                                                                    |
| `modified_by`            | *uuid*                                                  | (Optional) The [Application](#applications) ID which last modified the token                                                                                                                                                    |
| `modified_at`            | *date*                                                  | (Optional) Last modified date of the token in ISO 8601 format                                                                                                                                                                   |
| `search_indexes`         | *array*                                                 | (Optional) Array of search index [expressions](/expressions/#search-indexes) used when creating the token.                                                                                                                      |
| `fingerprint_expression` | *string*                                                | (Optional) An [expression](/expressions/#fingerprints) defining the value to fingerprint when creating the token.                                                                                                               |
| `expires_at`             | *string*                                                | (Optional) The [token expiration](#tokens-token-expiration) date.                                                                                                                                                               |

### Privacy Object

<aside class="warning">
  <span>
    Privacy settings have been deprecated and replaced by a more flexible authorization model based upon 
    <a href="https://developers.basistheory.com/concepts/what-are-token-containers">Containers</a> and 
    <a href="https://developers.basistheory.com/concepts/access-controls/#what-are-access-rules">Access Rules</a>. 
    If you are currently using Token Privacy settings, see our documentation on 
    <a href="/#deprecations-migrating-from-privacy-settings">Migrating from Privacy Settings</a>.
  </span>
</aside>

The following object defines the privacy settings applied to a Token. If unspecified, a default set of privacy settings will be applied based on the [Token Type](#token-types).
Default privacy settings can be overridden at the time of creation, but only to a setting with a higher specificity level.

| Attribute            | Type     | Description                                                                                  |
|----------------------|----------|----------------------------------------------------------------------------------------------|
| `classification`     | *string* | [Classification](#tokens-token-classifications) of the Token (e.g. `general`, `bank`, `pci`) |
| `impact_level`       | *string* | [Impact level](#tokens-token-impact-levels) of the Token (i.e. `low`, `moderate`, `high`)    |
| `restriction_policy` | *string* | (Deprecated) [Restriction policy](#tokens-token-restriction-policies) applied to the Token.  |

## Token Data Validations

### Bank Object

| Attribute        | Required | Type     | Default | Description                                               |
|------------------|----------|----------|---------|-----------------------------------------------------------|
| `routing_number` | true     | *string* | `null`  | Nine-digit ABA routing number. Its checksum is validated. |
| `account_number` | true     | *string* | `null`  | Account number up to seventeen-digits                     |

### Card Object

| Attribute          | Required | Type      | Default | Description                                               |
|--------------------|----------|-----------|---------|-----------------------------------------------------------|
| `number`           | true     | *string*  | `null`  | The card number without any separators                    |
| `expiration_month` | false    | *integer* | `null`  | Two-digit number representing the card's expiration month |
| `expiration_year`  | false    | *integer* | `null`  | Four-digit number representing the card's expiration year |
| `cvc`              | false    | *string*  | `null`  | Three or four-digit card verification code                |

### Test Card Numbers

To enable testing of Cards, we've implemented a list of acceptable test card numbers to ensure you are able to test with non-sensitive data.  

<aside class="warning">
<span>WARNING - while testing our system, these card numbers will be the only accepted cards available to test with.</span>
</aside>

| Card             | Description |
|------------------|-------------|
| 4242424242424242 | Test card   |
| 4000056655665556 | Test card   |
| 5555555555554444 | Test card   |
| 2223003122003222 | Test card   |
| 5200828282828210 | Test card   |
| 5105105105105100 | Test card   |
| 378282246310005  | Test card   |
| 371449635398431  | Test card   |
| 6011111111111117 | Test card   |
| 6011000990139424 | Test card   |
| 3056930009020004 | Test card   |
| 36227206271667   | Test card   |
| 3566002020360505 | Test card   |
| 620000000000000  | Test card   |


## Token Classifications

Each Token has a data classification associated with it which defines the type of data it contains.

Basis Theory scopes access to Tokens based upon their [Containers](https://developers.basistheory.com/concepts/what-are-token-containers). 
While the `containers` attribute can be explicitly provided when creating a Token, if unspecified, 
its value defaults to `["/<classification>/<impact_level>/"]`.

The following data classifications are supported:

| Name      | Description                                                                                                | Specificity Level |
|-----------|------------------------------------------------------------------------------------------------------------|-------------------|
| `general` | Contains sensitive data that does not fall under a more specific classification or compliance requirements | 0                 |
| `bank`    | Contains data that falls under banking compliance (e.g. Nacha)                                             | 10                |
| `pci`     | Contains data that falls under PCI compliance                                                              | 10                |
| `pii`     | Contains user or customer specific identifiers (e.g. email, date of birth, address)                        | 10                |

## Token Impact Levels

Basis Theory follows the standard **<a href="https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.199.pdf#page=6" target="_blank">NIST-defined impact levels</a>** 
of low, moderate, and high to classify the impact unauthorized exposure of a particular piece of data would have on an organization.

Basis Theory scopes access to Tokens based upon their [Containers](https://developers.basistheory.com/concepts/what-are-token-containers).
While the `containers` attribute can be explicitly provided when creating a Token, if unspecified,
its value defaults to `["/<classification>/<impact_level>/"]`.

The following impact levels are supported:


| Name       | Description                                                                                                            | Specificity Level |
|------------|------------------------------------------------------------------------------------------------------------------------|-------------------|
| `low`      | Loss of data confidentiality, integrity, or availability is expected to have **limited** adverse effect                | 0                 |
| `moderate` | Loss of data confidentiality, integrity, or availability is expected to have **serious** adverse effect                | 1                 |
| `high`     | Loss of data confidentiality, integrity, or availability is expected to have **severe or catastrophic** adverse effect | 2                 |


## Token Restriction Policies

<aside class="warning">
  <span>
    Restriction Policies have been deprecated and replaced by transforms on <a href="https://developers.basistheory.com/concepts/access-controls/#what-are-access-rules">Access Rules</a>.
    Setting a Restriction Policy on a Token no longer has any functional purpose.
  </span>
</aside>

| Name     | Specificity Level |
|----------|-------------------|
| `mask`   | 0                 |
| `redact` | 1                 |


## Token Expiration 

By default a created token will not expire, however, users can optionally set the `expires_at` property with an ISO8601 <code>DateTime</code> when creating a token to determine its expiration date.
An expired token is **deleted** from the tenant up to **1 hour** after it's expiration time.

### Expiration Date Formats
| Format                      | Example                     |
|-----------------------------|-----------------------------|
| `DateTime` String w/ Offset | 8/26/2030 7:23:57 PM -07:00 |
| `ShortDate` String          | 9/27/2030                   |

<aside class="notice">
  <span>If an offset is not provided with the <code>DateTime</code> string, it's considered that the provided time is in&nbsp;<strong>UTC</strong>.</span>
</aside>

<aside class="notice">
  <span>When using the <code>ShortDate</code> format, the expiration time will be set as&nbsp;<strong>12AM UTC</strong>.</span>
</aside>

## Create Token

> Request

```shell
curl "https://api.basistheory.com/tokens" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "type": "token",
    "data": "Sensitive Value",
    "mask": "{{ data | reveal_last: 4 }}",
    "privacy": {
      "restriction_policy": "mask"
    },
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    },
    "search_indexes": [
      "{{ data }}",
      "{{ data | last4}}"
    ],
    "fingerprint_expression": "{{ data }}",
    "deduplicate_token": true,
    "expires_at": "8/26/2030 7:23:57 PM -07:00"
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.create({
  type: 'token',
  data: 'Sensitive Value',
  mask: '{{ data | reveal_last: 4 }}',
  containers: ['/general/high/'],
  privacy: {
    restriction_policy: 'mask'
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  },
  searchIndexes: [
    '{{ data }}',
    '{{ data | last4}}'
  ],
  fingerprintExpression: '{{ data }}',
  deduplicateToken: true,
  expiresAt: '8/26/2030 7:23:57 PM -07:00'
});
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.CreateAsync(new Token {
  Type = "token",
  Data = "Sensitive Value",
  Mask = "{{ data | reveal_last: 4 }}",
  Containers = new List<string> { "/general/high/" },
  Privacy = new DataPrivacy {
    RestrictionPolicy = DataRestrictionPolicy.MASK
  },
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField",  "Non-Sensitive Value" }
  },
  SearchIndexes = new List<string> {
    "{{ data }}",
    "{{ data | last4}}"
  }
  FingerprintExpression = "{{ data }}",
  DeduplicateToken = true,
  ExpiresAt = "8/26/2030 7:23:57 PM -07:00"
});
```

```python
import basistheory
from basistheory.api import tokens_api
from basistheory.model.create_token_request import CreateTokenRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    token = token_client.create(create_token_request=CreateTokenRequest(
        type="token",
        data="Sensitive Value",
        mask="{{ data | reveal_last: 4 }}",
        metadata={
            "nonSensitiveField": "Non-Sensitive Value"
        },
        containers=["/general/high/"],
        privacy=Privacy(
          restriction_policy="mask"
        ),
        search_indexes=[
          "{{ data }}",
          "{{ data | last4}}"
        ],
        fingerprint_expression="{{ data }}",
        expires_at="8/26/2030 7:23:57 PM -07:00"
    ))
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  createTokenRequest := *basistheory.NewCreateTokenRequest("Sensitive Value")
  createTokenRequest.SetMask("{{ data | reveal_last: 4 }}")
  createTokenRequest.SetType("token")
  createTokenRequest.SetMetadata(map[string]string{
    "myMetadata": "myMetadataValue",
  })
  createTokenRequest.SetSearchIndexes([]string{"{{ data }}", "{{ data | last4}}"})
  createTokenRequest.SetFingerprintExpression("{{ data }}")
  createTokenRequest.SetDeduplicateToken(true)
  createTokenRequest.SetContainers([]string{"/general/high/"})
  createTokenRequest.SetExpiresAt("8/26/2030 7:23:57 PM -07:00")

  privacy := *basistheory.NewPrivacy()
  privacy.SetRestrictionPolicy("mask")
  createTokenRequest.SetPrivacy(privacy)

  createTokenResponse, createTokenHttpResponse, createErr := apiClient.TokensApi.Create(contextWithAPIKey).CreateTokenRequest(createTokenRequest).Execute()
}
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "data": "XXXXXXXXXXXalue",
  "mask": "{{ data | reveal_last: 4 }}",
  "containers": ["/general/high/"],
  "privacy": {
    "classification": "general",
    "impact_level": "high",
    "restriction_policy": "mask"
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "search_indexes": [
    "{{ data }}",
    "{{ data | last4}}"
  ],
  "fingerprint_expression": "{{ data }}",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "expires_at": "2030-08-26T19:23:57-07:00"
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

| Attribute                | Required | Type                                                    | Default                                   | Description                                                                                                                                                                                                                     |
|--------------------------|----------|---------------------------------------------------------|-------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`                     | false    | *string*                                                | `null`                                    | A value or [expression](/expressions/#aliasing) specifying the token's ID. If not specified, a UUID will be assigned.                                                                                                           |
| `type`                   | true     | *string*                                                | `null`                                    | [Token type](#token-types) of the token                                                                                                                                                                                         |
| `data`                   | true     | *any*                                                   | `null`                                    | Token data. Can be an object, array, or any primitive type such as an integer, boolean, or string                                                                                                                               |
| `mask`                   | false    | *any*                                                   | Depends on the [token type](#token-types) | Token data mask. Can be an object, array, or any primitive type such as an integer, boolean, or string. See [mask expressions](/expressions/#masks).                                                                            |
| `privacy`                | false    | *[privacy object](#tokens-token-object-privacy-object)* | `null`                                    | Token Privacy Settings overrides. Overrides must be a higher specificity level than the default or minimum setting for the [Token Type](#token-token-types).                                                                    |
| `containers`             | false    | *array*                                                 | Depends on the [token type](#token-types) | Array of containers to place this token within. Each container is a path representing a logical grouping of tokens. See [Token Containers](https://developers.basistheory.com/concepts/what-are-token-containers/) for details. |
| `metadata`               | false    | *map<string, string>*                                   | `null`                                    | A key-value map of strings containing non-sensitive data.                                                                                                                                                                       |
| `search_indexes`         | false    | *array*                                                 | `null`                                    | Array of [expressions](/expressions/#search-indexes) used to generate indexes to be able to search against.                                                                                                                     |
| `fingerprint_expression` | false    | *string*                                                | <code>{{ data &#124; stringify }}</code>  | [Expressions](/expressions/#fingerprints) used to fingerprint your token.                                                                                                                                                       |
| `deduplicate_token`      | false    | *bool*                                                  | `null`                                    | Whether the token is deduplicated on creation.                                                                                                                                                                                  |
| `expires_at`             | false    | *string*                                                | `null`                                    | ISO8601 compatible Token expiration DateTime. See [Token Expiration](#token-expiration) for more details.                                                                                                                       |


<aside class="warning">
  <span>WARNING - Never reveal sensitive information in the <code>id</code> of your token. See the documentation on <a href="/expressions/#aliasing-best-practices">Aliasing</a> to learn more about best practices when specifying your own token ID.</span>
</aside>

<aside class="warning">
  <span>WARNING - Never store sensitive plaintext information in the <code>metadata</code> of your token.</span>
</aside>

<aside class="warning">
  <span>WARNING - <code>search_indexes</code> can only be provided for the token types: <code>token</code>, <code>social_security_number</code> and <code>employer_id_number</code></span>
</aside>


### Response

Returns a [token](#tokens-token-object) if the token was created. Returns [an error](#errors) if there were validation errors, or the token failed to create.


## List Tokens

> Request

```shell
curl "https://api.basistheory.com/tokens" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

    tokens = token_client.get()
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  tokens, httpResponse, err := apiClient.TokensApi.Get(contextWithAPIKey).Execute()
}
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
      "containers": ["/general/high/"],
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

Get a list of tokens for the Tenant, supporting basic search criteria. 
If you need to perform a more advanced token search, see [Search Tokens](#tokens-search-tokens).

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

### Query Parameters

| Parameter        | Required | Type     | Default | Description                                                                                                                                                                                                                                                                                             |
|------------------|----------|----------|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`             | false    | *string* | `null`  | One to many Token IDs to retrieve. Multiple IDs can be passed in the form `?id=<value1>&id=<value2>`.                                                                                                                                                                                                   |
| `type`           | false    | *string* | `null`  | One to many [token types](#token-types) to filter the list of tokens by. Can be repeated in the form `?type=<value1>&type=<value2>`.                                                                                                                                                                    |
| `metadata.[key]` | false    | *map*    | `{}`    | Map of key-value pairs to filter tokens with matching metadata in the form `?metadata.key1=value1&metadata.key2=value2`. *Note*, `[key]` must be unique and repeated keys will be ignored. Metadata will be searched for a case-insensitive, exact match. Multiple parameters will be `AND`ed together. |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [tokens](#tokens-token-object).
Plaintext token data will be returned when the requester has read permissions on the token classification at equal or greater impact level.
Token data will be restricted based on the token's [restriction policy](#tokens-token-restriction-policies) when the requester has read permissions on the token classification at a lower impact level.
Providing any query parameters will filter the results. Returns [an error](#errors) if tokens could not be retrieved.


## Get a Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  token, httpResponse, err := apiClient.TokensApi.GetById(contextWithAPIKey, "c06d0789-0a38-40be-b7cc-c28a718f76f1").Execute()
}
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "type": "token",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "data": null, // Redacted based on Restriction Policy
  "containers": ["/general/high/"],
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
  <span class="scope">token:read</span>
</p>

### URI Parameters

| Parameter | Required | Type     | Default | Description         |
|-----------|----------|----------|---------|---------------------|
| `id`      | true     | *string* | `null`  | The ID of the token |

### Response

Returns a [token](#tokens-token-object) with the `id` provided.
Plaintext token data will be returned when the requester has read permissions on the token classification at equal or greater impact level.
Token data will be restricted based on the token's [restriction policy](#tokens-token-restriction-policies) when the requester has read permissions on the token classification at a lower impact level.
Returns [an error](#errors) if the token could not be retrieved.


## Update Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/merge-patch+json" \
  -X "PATCH" \
  -d '{
    "data": "Sensitive Value",
    "mask": "{{ data | reveal_last: 4 }}",
    "privacy": {
      "restriction_policy": "mask"
    },
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    },
    "search_indexes": [
      "{{ data }}",
      "{{ data | last4}}"
    ],
    "fingerprint_expression": "{{ data }}",
    "deduplicate_token": true,
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.update('c06d0789-0a38-40be-b7cc-c28a718f76f1', {
  data: 'Sensitive Value',
  mask: '{{ data | reveal_last: 4 }}',
  privacy: {
    restrictionPolicy: "mask"
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  },
  searchIndexes: [
    '{{ data }}',
    '{{ data | last4}}'
  ],
  fingerprintExpression: "{{ data }}",
  deduplicateToken: true,
});
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.UpdateAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1", new TokenUpdateRequest {
  Data = "Sensitive Value",
  Mask = "{{ data | reveal_last: 4 }}",
  Privacy = new PrivacyUpdateModel {
    RestrictionPolicy = DataRestrictionPolicy.MASK
  },
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField",  "Non-Sensitive Value" }
  },
  SearchIndexes = new List<string> {
    "{{ data }}",
    "{{ data | last4}}"
  }
  FingerprintExpression = "{{ data }}",
  DeduplicateToken = true,
});
```

```python
import basistheory
from basistheory.api import tokens_api
from basistheory.model.update_token_request import UpdateTokenRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    token = token_client.update(id="c06d0789-0a38-40be-b7cc-c28a718f76f1", update_token_request=UpdateTokenRequest(
        data="Sensitive Value",
        mask="{{ data | reveal_last: 4 }}",
        metadata={
            "nonSensitiveField": "Non-Sensitive Value"
        },
        privacy=UpdatePrivacy(
          restriction_policy="mask"
        ),
        search_indexes=[
          "{{ data }}",
          "{{ data | last4}}"
        ],
        fingerprint_expression="{{ data }}"
    ))
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  updateTokenRequest := *basistheory.NewUpdateTokenRequest("Sensitive Value")
  updateTokenRequest.SetMask("{{ data | reveal_last: 4 }}")
  updateTokenRequest.SetMetadata(map[string]string{
    "myMetadata": "myMetadataValue",
  })
  updateTokenRequest.SetSearchIndexes([]string{"{{ data }}", "{{ data | last4}}"})
  updateTokenRequest.SetFingerprintExpression("{{ data }}")

  privacy := *basistheory.NewPrivacy()
  privacy.SetRestrictionPolicy("mask")
  updateTokenRequest.SetPrivacy(privacy)

  updateTokenResponse, updateTokenHttpResponse, createErr := apiClient.TokensApi.Update(contextWithAPIKey, "c06d0789-0a38-40be-b7cc-c28a718f76f1").UpdateTokenRequest(updateTokenRequest).Execute()
}
```

> Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "data": "XXXXXXXXXXXalue",
  "mask": "{{ data | reveal_last: 4 }}",
  "containers": ["/general/high/"],
  "privacy": {
    "classification": "general",
    "impact_level": "high",
    "restriction_policy": "mask"
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "search_indexes": [
    "{{ data }}",
    "{{ data | last4}}"
  ],
  "fingerprint_expression": "{{ data }}",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method patch">
  <span class="box-method">PATCH</span>
  `https://api.basistheory.com/tokens`
</span>

Update an existing token for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:update</span>
</p>

### Request Parameters

| Attribute                | Required | Type                                                    | Behavior                                                                               | Description                                                                                                                                                                                                                                         |
|--------------------------|----------|---------------------------------------------------------|----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `data`                   | false    | *any*                                                   | Merge Patch (see <a href="https://datatracker.ietf.org/doc/html/rfc7386">RFC 7386</a>) | Token data. Can be an object, array, or any primitive type such as an integer, boolean, or string                                                                                                                                                   |
| `mask`                   | false    | *any*                                                   | Merge Patch (see <a href="https://datatracker.ietf.org/doc/html/rfc7386">RFC 7386</a>) | Token data mask. Can be an object, array, or any primitive type such as an integer, boolean, or string. See [mask expressions](/expressions/#masks).                                                                                                |
| `privacy`                | false    | *[privacy object](#tokens-token-object-privacy-object)* | Replace                                                                                | Token Privacy Settings overrides. Overrides must be a higher specificity level than the default or minimum setting for the [Token Type](#token-token-types). The `classfication` attribute of the `privacy` object *cannot* be overriden on update. |
| `metadata`               | false    | *map<string, string>*                                   | Merge Patch (see <a href="https://datatracker.ietf.org/doc/html/rfc7386">RFC 7386</a>) | A key-value map of strings containing non-sensitive data.                                                                                                                                                                                           |
| `search_indexes`         | false    | *array*                                                 | Replace                                                                                | Array of [expressions](/expressions/#search-indexes) used to generate indexes to be able to search against.                                                                                                                                         |
| `fingerprint_expression` | false    | *string*                                                | Replace                                                                                | [Expressions](/expressions/#fingerprints) used to fingerprint your token.                                                                                                                                                                           |
| `deduplicate_token`      | false    | *bool*                                                  | Replace                                                                                | Whether the token is deduplicated on creation.                                                                                                                                                                                                      |

### Response

Returns the updated [token](#tokens-token-object) if successful. Returns [an error](#errors) if there were validation errors, or the token failed to create.

<aside class="notice">
  <span>If the updated token results in a duplicate of an existing token and the application does not have the original token's read permission, the <code>data</code>,    <code>metadata</code>, <code>fingerprint_expression</code>, <code>search_indexes</code> and <code>mask</code> attributes will be redacted.</span>
</aside>


## Search Tokens

> Request

```shell
curl "https://api.basistheory.com/tokens/search" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "query": "data:6789 AND type:social_security_number",
    "page": 1,
    "size": 20
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tokens = await bt.tokens.search({
  query: 'data:6789 AND type:social_security_number',
  page: 1,
  size: 20
});
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var tokens = await client.SearchAsync(new TokenSearchRequest {
  Query = "data:6789 AND type:social_security_number",
  Page = 1,
  Size = 20);
```

```python
import basistheory
from basistheory.api import tokens_api
from basistheory.model.search_tokens_request import SearchTokensRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    token_client = tokens_api.TokensApi(api_client)

    tokens = token_client.search(search_tokens_request=SearchTokensRequest(
        query="data:6789 AND type:social_security_number",
        page=1,
        size=20
    ))
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  searchTokenRequest := *basistheory.NewSearchTokensRequest()
  searchTokenRequest.SetQuery("data:6789 AND type:social_security_number")
  searchTokenRequest.SetPage(1)
  searchTokenRequest.SetSize(20)

  tokens, httpResponse, err := apiClient.TokensApi.Search(contextWithAPIKey).SearchTokensRequest(searchTokenRequest).Execute()
}
```

> Response

```json
{
  "pagination": {...},
  "data": [
    {
      "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
      "type": "social_security_number",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "data": "XXX-XX-6789",
      "fingerprint": "AKCUXS83DokKo4pDRKSAy4d42t9i8dcP1X2jijwEBCQH",
      "containers": ["/pii/high/"],
      "privacy": {
        "classification": "pii",
        "impact_level": "high",
        "restriction_policy": "mask"
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      },
      "search_indexes": [
        "{{ data }}",
        "{{ data | replace: '-' }}",
        "{{ data | last4 }}"
      ],
      "fingerprint_expression": "{{ data }}",
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens/search`
</span>

Search for tokens using a Lucene-based [query syntax](#tokens-search-tokens-query-syntax). 
Use this endpoint to perform an advanced token search using token data or to build complex searches combining multiple terms with boolean operators.
For simpler search use cases, see [List Tokens](#list-tokens).

### Permissions

<p class="scopes">
  <span class="scope">token:read</span>
</p>

At least one token read [permission](#permissions-permission-types-token-permissions) is required in order to perform a token search. 
A token search will only return tokens that your application or user is authorized to read. 

Applications are permitted to search on the `data` field of a token only if the application's [permissions](#permissions-permission-types-token-permissions)
allow reading the [unrestricted](#tokens-token-restriction-policies) plaintext token data. 
Applications may search across non-data fields (eg. `metadata`, `type`) on tokens with any read permission for that data [classification](#tokens-token-classifications), even if that read permission only allows [restricted](#tokens-token-restriction-policies) access to the token data.

### Request Parameters

| Attribute | Required | Type      | Default | Description                                                                     |
|-----------|----------|-----------|---------|---------------------------------------------------------------------------------|
| `query`   | false    | *string*  | `null`  | A query string using [Lucene query syntax](#tokens-search-tokens-query-syntax). |
| `page`    | false    | *integer* | `1`     | Page number of the results to return.                                           |
| `size`    | false    | *integer* | `20`    | Number of results per page to return. Maximum size of 100 results.              |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [tokens](#tokens-token-object).
Plaintext token data will be returned when the requester has read permissions on the token classification at equal or greater impact level.
Token data will be restricted based on the token's [restriction policy](#tokens-token-restriction-policies) when the requester has read permissions on the token classification at a lower impact level.
Returns [an error](#errors) if tokens could not be retrieved or when an invalid [query](#tokens-search-tokens-query-syntax) is submitted.

### Query Syntax

Token search supports a <a href="http://www.lucenetutorial.com/lucene-query-syntax.html" target="_blank">Lucene-based query syntax</a> to build complex search criteria. 
A query string is comprised of one or more Terms that can be combined with the `AND` and `OR` Operators.

Search terms are formed by combining a field name and a value to search with a `:` - `field:value`. 
See the [Searchable Token Fields](#tokens-search-tokens-searchable-token-fields) table below for a complete list of supported fields. 
For example, to search for tokens having a `type` of `card_number`, query for:
<span class="text-snippet">
  `type:card_number`
</span>

Token data may be searched on some token types, by performing a case-insensitive exact match to one of several indexed data patterns.
As an example, the following query will search for tokens containing the data `123-45-6789`:
<span class="text-snippet">
  `data:123-45-6789`
</span>

For more detailed information about supported data searches, see [Searching Data](#tokens-search-tokens-searching-data).

Phrases or values containing spaces may be searched by wrapping the searched value in quotes, for example:
<span class="text-snippet">
  `data:"data containing multiple words"`
</span>

Metadata search terms require both a key and value to be specified in the form of `metadata.key:value`. 
Metadata will be searched for a case-insensitive, exact match.
For example, to search for tokens having the metadata `{ customer_id: "123456" }`, query for:
<span class="text-snippet">
  `metadata.customer_id:123456`
</span>

Container search terms support both exact and wildcard matches. An exact container search will only return tokens in
the searched container and will not include tokens in parent or child containers. For example, to return only tokens
in the `/customer-123/pii/` container, you can query:
<span class="text-snippet">
  `container:"/customer-123/pii/"`
</span>

Wildcard container searches can be used to match on all tokens within a container or its sub-containers. 
The wildcard character `*` can only appear at the end of a container search term.
For example, to return all tokens for `customer-123` which may be partitioned into sub-containers `/customer-123/pii/` or `/customer-123/general/`, you can query:
<span class="text-snippet">
  `container:"/customer-123/*"`
</span>

Date range searches are supported using the Lucene bracketed range syntax. 
`[START_DATE TO END_DATE]` denotes an inclusive range and `{START_DATE TO END_DATE}` denotes an exclusive range. 
Values are formatted as a string in ISO 8601 format and can either represent a date or date and time in UTC.
For example, to search for tokens that were created in the year 2021, you can query:
<span class="text-snippet">
  `created_at:[2021-01-01 TO 2021-12-31T23:59:59Z]`
</span>

To search a range without a start or end date, use the wildcard `*` in place of the start or end date, for example:
<span class="text-snippet">
  `created_at:{* TO 2022-01-01}`
</span>

Multiple terms may be combined using the `AND`, `OR` and `NOT` operators (case sensitive) and grouped using parentheses. The `NOT` operator could be interchanged with the `!` or `-` symbols. For example:
<span class="text-snippet">
  `(type:social_security_number AND !metadata.user_id:1234) OR data:111-11-1111`
</span>

<aside class="warning">
  <span>
    The supported Lucene syntax is currently limited to the operations documented above, and not all standard Lucene syntax is supported.
    If you would like to have support for any additional Lucene features, please <a href="mailto:support@basistheory.com?subject=Token Search Feature Request" target="_blank">let us know</a>.
  </span>
</aside>

### Searchable Token Fields

| Fields            | Type     | Description                                                                                  | Example                                            |
|-------------------|----------|----------------------------------------------------------------------------------------------|----------------------------------------------------|
| `id`              | *string* | Token ID.                                                                                    | `id:fe24d4cc-de50-4d8c-8da7-8c7483ba21bf`          |
| `type`            | *string* | The [token type](#token-types).                                                              | `type:card_number`                                 |
| `data`            | *string* | Token data. See [Searching Data](#tokens-search-tokens-searching-data) for supported values. | `data:6789`                                        |
| `fingerprint`     | *string* | Token's content unique identifier.                                                           | `fingerprint:fe24d4cc-de50-4d8c-8da7-8c7483ba21bf` |
| `container`       | *string* | Searches across a token's [containers](#tokens-token-containers).                            | `container:"/pci/high/"`                           |
| `privacy.[field]` | *string* | Token [privacy settings](#tokens-token-object-privacy-object).                               | `privacy.classification:pci`                       |
| `metadata.[key]`  | *string* | Search against token metadata having the given `[key]`.                                      | `metadata.user_id:34445`                           |
| `created_by`      | *string* | Application ID which created the token.                                                      | `created_by:fe24d4cc-de50-4d8c-8da7-8c7483ba21bf`  |
| `created_at`      | *date*   | The date or date and time a token was created in ISO 8601 format.                            | `created_at:[2020-01-01 TO 2020-01-28]`            |
| `modified_by`     | *string* | Application ID which last modified the token.                                                | `modified_by:fe24d4cc-de50-4d8c-8da7-8c7483ba21bf` |
| `modified_at`     | *date*   | The last date or date and time a token was modified in ISO 8601 format.                      | `modified_at:[2020-01-01 TO 2020-01-28]`           |

### Searching Data

Basis Theory currently supports data searches on `social_security_number`, `employer_id_number` and `token` token types.
When creating tokens of these types, Basis Theory will securely index several data patterns to enable searching on these values 
based on the `search_indexes` provided in the [Create Token Request](#tokens-create-token) or [Tokenize Request](#tokenize).

If `search_indexes` are not provided when creating a token, then `social_security_number` and `employer_id_number` will have the following default search indexes:

- `{{ data }}` which results in the input value being indexed, eg. `123-45-6789`
- `{{ data | remove: '-'}}` which results in the value without delimiters, eg. `123456789`
- `{{ data | last4 }}` which results in the last 4 digits of the value, eg. `6789`

For generic tokens (type `token`), default indexes are not applied, and you are free to specify any desired indexes within the `search_indexes` property during [token creation](#tokens-create-token). The `search_indexes` property supports the use of [expressions](/expressions/#search-indexes), which are based on the [Liquid templating language](https://shopify.github.io/liquid/). Each expression must result in a single value, which cannot be null or empty, otherwise a 400 error will be returned.

Any expressions contained within `search_indexes` will be evaluated against the token data before generating indexes. Token data searches will only return a token if there is an exact match on one of the evaluated `search_indexes`; full wildcard search is not currently supported.

For example, to search for a `social_security_number` token with the value `123-45-6789`, you may search for: 

<span class="text-snippet">
  `data:123-45-6789 AND type:social_security_number`
</span>

To search for all `social_security_number` tokens with the last 4 digits of `6789`, you may search for:

<span class="text-snippet">
  `data:6789 AND type:social_security_number`
</span>

Note that the results returned by this query may not be unique if you have stored multiple `social_security_number` tokens ending with the same 4 digits.

## Delete Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  httpResponse, err := apiClient.TokensApi.Delete(contextWithAPIKey, "c06d0789-0a38-40be-b7cc-c28a718f76f1").Execute()
}
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tokens/{id}`
</span>

Delete a token by ID in the Tenant.

<aside class="warning">
  <span>WARNING - The data associated with a deleted token will be removed forever. The reference will still exist for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">token:delete</span>
</p>

### URI Parameters

| Parameter | Required | Type     | Default | Description         |
|-----------|----------|----------|---------|---------------------|
| `id`      | true     | *string* | `null`  | The ID of the token |

### Response

Returns [an error](#errors) if the token failed to delete.

# Tokenize

The `tokenize` endpoint enables you to tokenize any request and tokenize several [types of tokens](#token-types) in the same request. It can be utilized to combine multiple API calls into a single request to match your current data structure or bulk token creation.


> Create Basic Token Request

```shell
curl "https://api.basistheory.com/tokenize" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "first_name": "John",
    "last_name": "Doe"
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokenize({
  first_name: 'John',
  last_name: 'Doe'
});
```

```csharp
using BasisTheory.net.Tokenize;

var client = new TokenizeClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.Tokenize(new {
  first_name = "John",
  last_name = "Doe"
});
```

```python
import basistheory
from basistheory.api import tokenize_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokenize_client = tokenize_api.TokenizeApi(api_client)

    token = tokenize_client.tokenize(body={
      "first_name": "John",
      "last_name": "Doe"
    })
```

> Create Basic Token Response

```json
{
  "first_name": "b0804096-5a47-4b8c-8fb7-b9ecc5e72eec",
  "last_name": "814a6416-3410-4224-8ea9-c0b4d453c9ce"
}
```


> Create Token Request

```shell
curl "https://api.basistheory.com/tokenize" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "type": "token",
    "data": "Sensitive Value",
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    },
    "search_indexes": [ "{{ data }}" ],
    "fingerprint_expression": "{{ data }}"
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokenize({
  type: 'token',
  data: 'Sensitive Value',
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  },
  searchIndexes: [ '{{ data }}' ],
  fingerprintExpression: '{{ data }}',
});
```

```csharp
using BasisTheory.net.Tokenize;

var client = new TokenizeClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.Tokenize(new Token {
  Type = "token",
  Data = "Sensitive Value",
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField",  "Non-Sensitive Value" }
  },
  SearchIndexes = new List<string> {
    "{{ data }}"
  },
  FingerprintExpression = "{{ data }}" 
});
```

```python
import basistheory
from basistheory.api import tokenize_api 
from basistheory.model.token import Token

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokenize_client = tokenize_api.TokenizeApi(api_client)

    token = tokenize_client.tokenize(body=Token(
      type="token",
      data="Sensitive Value",
      metadata={
        "nonSensitive": "Non-Sensitive Value"
      },
      search_indexes=[
        "{{ data }}"
      ],
      fingerprint_expression="{{ data }}"
    ))
```

> Create Token Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "search_indexes": [ "{{ data }}" ],
  "fingerprint_expression": "{{ data }}",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```


> Create Card Request

```shell
curl "https://api.basistheory.com/tokenize" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "type": "card",
    "data": {
      "number": "4242424242424242",
      "expiration_month": 12,
      "expiration_year": 2025,
      "cvc": "123"
    },
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokenize({
  type: 'card',
  data: {
    number: '4242424242424242',
    expiration_month: 12,
    expiration_year: 2025,
    cvc: '123'
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  }
});
```

```csharp
using BasisTheory.net.Tokenize;

var client = new TokenizeClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.Tokenize(new Token {
  Type = "card",
  Data = new Card {
    CardNumber = "4242424242424242",
    ExpirationMonth = 12,
    ExpirationYear = 2025,
    CardVerificationCode = "123"
  },
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField",  "Non-Sensitive Value" }
  }
});
```

```python
import basistheory
from basistheory.api import tokenize_api 
from basistheory.model.token import Token

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokenize_client = tokenize_api.TokenizeApi(api_client)

    token = tokenize_client.tokenize(body=Token(
      type="card",
      data={
          "number": "4242424242424242",
          "expiration_month": 12,
          "expiration_year": 2025,
          "cvc": "123"
      },
      metadata={
        "nonSensitive": "Non-Sensitive Value"
      }
    ))
```

> Create Card Response

```json
{
  "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "card",
  "mask": {
    "number": "XXXXXXXXXXXX4242",
    "expiration_month": 12,
    "expiration_year": 2025
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "fingerprint_expression": "{{ data.number }}",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

> Tokenize Array Request

```shell
curl "https://api.basistheory.com/tokenize" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '[
    "John",
    "Doe",
    {
      "type": "card",
      "data": {
        "number": "4242424242424242",
        "expiration_month": 12,
        "expiration_year": 2025,
        "cvc": "123"
      }
    },
    {
      "type": "token",
      "data": "Sensitive Value"
    }
  ]'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokenize([
  'John',
  'Doe',
  {
    type: 'card',
    data: {
      number: '4242424242424242',
      expiration_month: 12,
      expiration_year: 2025,
      cvc: '123'
    },
    metadata: {
      nonSensitiveField: 'Non-Sensitive Value'
    }
  },
  {
    type: 'token',
    data: 'Sensitive Value'
  }
]);
```

```csharp
using BasisTheory.net.Tokenize;

var client = new TokenizeClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.Tokenize(new object[
  "John",
  "Doe",
  new Token {
    Type = "card",
    Data = new Card {
      CardNumber = "4242424242424242",
      ExpirationMonth = 12,
      ExpirationYear = 2025,
      CardVerificationCode = "123"
    }
  },
  new Token {
    Type = "token",
    Data = "Sensitive Value"
  }
]);
```

```python
import basistheory
from basistheory.api import tokenize_api
from basistheory.model.token import Token

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokenize_client = tokenize_api.TokenizeApi(api_client)

    token = tokenize_client.tokenize(body=[
        "John",
        "Doe",
        Token(
            type="card",
            data={
                "number": "4242424242424242",
                "expiration_month": 12,
                "expiration_year": 2025,
                "cvc": "123"
            },
            metadata={
                "nonSensitive": "Non-Sensitive Value"
            }
        ),
        Token(
            type="token",
            data="Sensitive Value"
        )])
```

> Tokenize Array Response

```json
[
  "b0804096-5a47-4b8c-8fb7-b9ecc5e72eec",
  "814a6416-3410-4224-8ea9-c0b4d453c9ce",
  {
    "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
    "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
    "type": "card",
    "data": {
      "number": "XXXXXXXXXXXX4242",
      "expiration_month": 12,
      "expiration_year": 2025
    },
    "fingerprint_expression": "{{ data.number }}",
    "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
    "created_at": "2020-09-15T15:53:00+00:00"
  },
  {
    "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
    "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
    "type": "token",
    "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
    "created_at": "2020-09-15T15:53:00+00:00"
  }
]
```


> Composite Request

```shell
curl "https://api.basistheory.com/tokenize" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "primary_card": {
      "type": "card",
      "data": {
        "number": "4242424242424242",
        "expiration_month": 12,
        "expiration_year": 2025,
        "cvc": "123"
      }
    },
    "sensitive_tags": [
      "preferred",
      {
        "type": "token",
        "data": "vip"
      }
    ]
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokenize({
  first_name: 'John',
  last_name: 'Doe',
  primary_card: {
    type: 'card',
    data: {
      number: '4242424242424242',
      expiration_month: 12,
      expiration_year: 2025,
      cvc: '123'
    }
  },
  sensitive_tags: [
    'preferred',
    {
      type: 'token',
      data: 'vip'
    }
  ]
});
```

```csharp
using BasisTheory.net.Tokenize;

var client = new TokenizeClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.Tokenize(new {
  first_name = "John",
  last_name = "Doe",
  primary_card = new Token {
    Type = "card",
    Data = new Card {
      CardNumber = "4242424242424242",
      ExpirationMonth = 12,
      ExpirationYear = 2025,
      CardVerificationCode = "123"
    }
  },
  sensitive_tags = new object[] {
    "preferred",
    new Token {
      Type = "token",
      Data = "vip"
    }
  }
});
```

```python
import basistheory
from basistheory.api import tokenize_api
from basistheory.model.token import Token

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokenize_client = tokenize_api.TokenizeApi(api_client)

    token = tokenize_client.tokenize(body={
        "first_name": "John",
        "last_name": "Doe",
        "primary_card": Token(
            type="card",
            data={
                "number": "4242424242424242",
                "expiration_month": 12,
                "expiration_year": 2025,
                "cvc": "123"
            }),
        "sensitive_tags": [
            "preferred",
            {
                "type": "token",
                "data": "vip"
            }
        ]
    })
```

> Composite Response

```json
{
  "first_name": "b0804096-5a47-4b8c-8fb7-b9ecc5e72eec",
  "last_name": "814a6416-3410-4224-8ea9-c0b4d453c9ce",
  "primary_card": {
    "id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
    "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
    "type": "card",
    "data": {
      "number": "XXXXXXXXXXXX4242",
      "expiration_month": 12,
      "expiration_year": 2025
    },
    "fingerprint_expression": "{{ data.number }}",
    "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
    "created_at": "2020-09-15T15:53:00+00:00"
  },
  "sensitive_tags": [
    "be3dff7a-4e01-4a52-93e6-9f8ef03f3cd9",
    {
      "id": "aaed779a-3152-437d-8e8a-10afeb0fe620",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "type": "token",
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2020-09-15T15:53:00+00:00"
    }
  ]
}
```


<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokenize`
</span>

Tokenize one to many tokens for the Tenant.

### Permissions

Permissions are determined by the [classification(s)](#tokens-token-classifications) being tokenized and require the appropriate `token:<classification>:create` permission(s) based on the request.

# Token Associations

Token associations allow you to associate any two tokens, of any type, together. This allows you to create parent-child relationships between tokens and traverse between tokens.

## Create Token Association

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokens_client = tokens_api.TokensApi(api_client)

    tokens_client.create_association("c06d0789-0a38-40be-b7cc-c28a718f76f1", "c1e565009-1984-4638-8fca-dce8a82cc2af")
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

  httpResponse, err := apiClient.TokensApi.CreateAssociation(contextWithAPIKey, "c06d0789-0a38-40be-b7cc-c28a718f76f1", "c1e565009-1984-4638-8fca-dce8a82cc2af").Execute()
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens/{parent_id}/children/{child_id}`
</span>

Create a new parent/child association between two tokens in the Tenants.

### Permissions

Creating an association between two existing tokens requires the appropriate read permission based on the parent and child
tokens' privacy settings.

<p class="scopes">
  <span class="scope">token:&lt;classification&gt;:read:&lt;impact_level&gt;</span>
</p>

### URI Parameters

| Parameter   | Required | Type     | Default | Description                |
|-------------|----------|----------|---------|----------------------------|
| `parent_id` | true     | *string* | `null`  | The ID of the parent token |
| `child_id`  | true     | *string* | `null`  | The ID of the child token  |

<aside class="notice">
  <span>Bi-directional associations can be made between two tokens by creating a token association and swapping the <code>parent_id</code> and <code>child_id</code>.</span>
</aside>

### Response

Returns [an error](#errors) if the token association failed to create.


## Delete Token Association

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokens_client = tokens_api.TokensApi(api_client)

    tokens_client.delete_association("c06d0789-0a38-40be-b7cc-c28a718f76f1", "c1e565009-1984-4638-8fca-dce8a82cc2af")
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

  httpResponse, err := apiClient.TokensApi.DeleteAssociation(contextWithAPIKey, "c06d0789-0a38-40be-b7cc-c28a718f76f1", "c1e565009-1984-4638-8fca-dce8a82cc2af").Execute()
}
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tokens/{parent_id}/children/{child_id}`
</span>

Delete a parent/child association between two tokens in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:&lt;classification&gt;:delete</span>
</p>

### URI Parameters

| Parameter   | Required | Type     | Default | Description                |
|-------------|----------|----------|---------|----------------------------|
| `parent_id` | true     | *string* | `null`  | The ID of the parent token |
| `child_id`  | true     | *string* | `null`  | The ID of the child token  |

### Response

Returns [an error](#errors) if the token association failed to delete.


## Create Child Token for a Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "type": "token",
    "data": "Sensitive Value",
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const token = await bt.tokens.createChild('c06d0789-0a38-40be-b7cc-c28a718f76f1', {
  type: 'token',
  data: 'Sensitive Value',
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  }
});
```

```csharp
using BasisTheory.net.Tokens;

var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

var token = await client.CreateChildAsync("c06d0789-0a38-40be-b7cc-c28a718f76f1", 
  new Token {
    Type = "token",
    Data = "Sensitive Value",
    Metadata = new Dictionary<string, string> {
      { "nonSensitiveField", "Non-Sensitive Value" }
    }
  }
);
```

```python
import basistheory
from basistheory.api import tokens_api
from basistheory.model.create_token_request import CreateTokenRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokens_client = tokens_api.TokensApi(api_client)

    token = tokens_client.create_child("c06d0789-0a38-40be-b7cc-c28a718f76f1", create_token_request=CreateTokenRequest(
        type="token",
        data="Sensitive Value",
        metadata={
            "nonSensitiveField": "Non-Sensitive Value"
        }
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
  createTokenRequest.SetType("token")
  createTokenRequest.SetMetadata(map[string]string{
    "nonSensitiveField": "Non-Sensitive Value",
  })

  token, httpResposne, err := apiClient.TokensApi.CreateChild(contextWithAPIKey, "c06d0789-0a38-40be-b7cc-c28a718f76f1").CreateTokenRequest(createTokenRequest).Execute()
}
```

> Response

```json
{
  "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "token",
  "container": "/general/high/",
  "privacy": {
    "classification": "general",
    "impact_level": "high",
    "restriction_policy": "redact"  
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  }
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tokens/{parent_id}/children`
</span>

Create a new child token a token in the Tenant.

### Permissions

Creating a child token requires the appropriate create permission based on the child's classification as well as the appropriate `read`
permission based on the parent token's privacy settings.

<p class="scopes">
  <span class="scope">token:&lt;classification&gt;:create</span>
  <span class="scope">token:&lt;classification&gt;:read:&lt;impact_level&gt;</span>
</p>

### URI Parameters

| Parameter   | Required | Type     | Default | Description                |
|-------------|----------|----------|---------|----------------------------|
| `parent_id` | true     | *string* | `null`  | The ID of the parent token |

### Request Parameters

| Attribute    | Required | Type                                                          | Default | Description                                           |
|--------------|----------|---------------------------------------------------------------|---------|-------------------------------------------------------|
| `type`       | true     | *string*                                                      | `null`  | [Token type](#token-types) of the token               |
| `data`       | true     | *any*                                                         | `null`  | Token data                                            |
| `privacy`    | false    | *[privacy object](#tokens-token-object-privacy-object)*       | `null`  | Token Privacy Settings                                |
| `metadata`   | false    | *map*                                                         | `null`  | A key-value map of non-sensitive data.                |

### Response

Returns a [token](#tokens-token-object) if the child token was created for the parent token. Returns [an error](#errors) if there were validation errors, or the token failed to create.


## List Child Tokens for a Token

> Request

```shell
curl "https://api.basistheory.com/tokens/c06d0789-0a38-40be-b7cc-c28a718f76f1/children" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

```python
import basistheory
from basistheory.api import tokens_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tokens_client = tokens_api.TokensApi(api_client)

    tokens = tokens_client.get_children("c06d0789-0a38-40be-b7cc-c28a718f76f1")
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

  tokens, response, err := apiClient.TokensApi.GetChildren(contextWithAPIKey, "c06d0789-0a38-40be-b7cc-c28a718f76f1").Execute()
}
```

> Response

```json
{
  "pagination": {...},
  "data": [
    {
      "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
      "type": "token",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "data": null, // Redacted based on restriction policy
      "container": "/general/high/",
      "privacy": {
        "classification": "general",
        "impact_level": "high",
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
  `https://api.basistheory.com/tokens/{parent_id}/children`
</span>

Get a list of child tokens for a token in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:&lt;classification&gt;:read:&lt;impact_level&gt;</span>
</p>

### URI Parameters

| Parameter   | Required | Type     | Default | Description                |
|-------------|----------|----------|---------|----------------------------|
| `parent_id` | true     | *string* | `null`  | The ID of the parent token |

### Query Parameters

| Parameter | Required | Type    | Default | Description                                                                            |
|-----------|----------|---------|---------|----------------------------------------------------------------------------------------|
| `id`      | false    | *array* | `[]`    | An optional list of token ID's to filter the list of child tokens by                   |
| `type`    | false    | *array* | `[]`    | An optional array of [token types](#token-types) to filter the list of child tokens by |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [child tokens](#tokens-token-object) for the parent token. Providing any query parameters will filter the child tokens. Returns [an error](#errors) if tokens could not be retrieved.

# Authentication

> Request

```shell
curl "https://api.basistheory.com" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

// at instance
const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

// per call
const bt = await new BasisTheory().init();

const applications = await bt.applications.list({}, {
  apiKey: 'key_N88mVGsp3sCXkykyN2EFED'
});
```

```csharp
using BasisTheory.net.Tokens;

// At service
var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

// Per call
var client = new TokenClient();

client.GetAsync(requestOptions: new RequestOptions {
  ApiKey = "key_N88mVGsp3sCXkykyN2EFED"
});
```

```python
import basistheory
from basistheory.api import tokens_api

# At instance
api_client = basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED"))
client = tokens_api.TokensApi(api_client)

# Per call
client.list(request_options=basistheory.RequestOptions(api_key="key_N88mVGsp3sCXkykyN2EFED"))
```

Basis Theory uses API keys to allow access to the API.

Basis Theory requires the API key to be included in all API requests to the server in a header that looks like the following:

`BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED`

<aside class="notice">
  <span>You must replace <code>key_N88mVGsp3sCXkykyN2EFED</code> with your API key supplied when you <a href="#applications-create-application">created an Application</a>.</span>
</aside>

# Authentication

> Request

```shell
curl "https://api.basistheory.com" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```


```javascript
import { BasisTheory } from '@Basis-Theory/basis-theory-js';

// at instance
const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

// per call
const bt = await new BasisTheory().init();
const applications = await bt.applications.list({}, {
  apiKey: 'key_N88mVGsp3sCXkykyN2EFED'
});
```

```csharp
// At service
var client = new TokenClient("key_N88mVGsp3sCXkykyN2EFED");

// Per call
var client = new TokenClient();
client.GetAsync(requestOptions: new RequestOptions {
  ApiKey = "key_N88mVGsp3sCXkykyN2EFED"
});
```

Basis Theory uses API keys to allow access to the API.

Basis Theory expects for the API key to be included in all API requests to the server in a header that looks like the following:

`X-API-KEY: key_N88mVGsp3sCXkykyN2EFED`

<aside class="notice">
  <span>You must replace <code>key_N88mVGsp3sCXkykyN2EFED</code> with your API key supplied when you [created an application](#create-application).</span>
</aside>

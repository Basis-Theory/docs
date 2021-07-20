# Authentication

> Request

```shell
curl "https://api.basistheory.com" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import BasisTheory from '@Basis-Theory/basis-theory-js';

await BasisTheory.init("test_1234567890", { elements: true });
```

Our hosted elements uses Elements keys to allow access to the API. To create one, login into our [portal](https://portal.basistheory.com) and create a new Elements appliation with the permissions you require.

<aside class="notice">
  <span>You must replace <code>test_1234567890</code> with your API key supplied when you [created an application](#create-application).</span>
</aside>

# Authentication

> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request
curl "api_endpoint_here" \
  -H "X-API-KEY: test_1234567890"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")
```

> Make sure to replace `test_1234567890` with your API key.

Basis Theory uses API keys to allow access to the API.

Basis Theory expects for the API key to be included in all API requests to the server in a header that looks like the following:

`X-API-KEY: test_1234567890`

<aside class="notice">
You must replace <code>test_1234567890</code> with your personal API key.
</aside>

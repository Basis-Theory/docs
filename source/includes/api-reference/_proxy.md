# Proxy

## Proxying Requests

The Basis Theory Proxy provides a simple way to facilitate the transfer of sensitive data via HTTP API calls. This Proxy can be configured to sit in front of your API to tokenize or transform an inbound request and also between you and a 3rd Party, keeping the sensitive data from touching your systems. To learn more, check out our [Proxy Concept](https://developers.basistheory.com/concepts/what-is-the-proxy/).

Basis Theory token identifiers included in the request will be replaced with the raw token data and then the modified request will be forwarded to the destination specified in the `BT-PROXY-URL` request header. The destination will receive the raw data in the request without your system needing to interact with sensitive data on your own servers.

### Proxy Requests

> Request with BT-PROXY-KEY

```shell
curl "https://api.basistheory.com/proxy" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "BT-PROXY-KEY: e29a50980ca5" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "parameter1": "{{26818785-547b-4b28-b0fa-531377e99f4e}}",
    "parameter2": "non-sensitive"
  }'
```

> Request with BT-PROXY-URL

```shell
curl "https://api.basistheory.com/proxy" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "BT-PROXY-URL: https://example.com/api" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "parameter1": "{{26818785-547b-4b28-b0fa-531377e99f4e}}",
    "parameter2": "non-sensitive"
  }'
```

<span class="http-method post">
  <span class="method-wrapper">
    <span class="box-method">POST</span>
  </span>
  `https://api.basistheory.com/proxy`
</span>

<span class="http-method put">
  <span class="method-wrapper">
    <span class="box-method">PUT</span>
  </span>
  `https://api.basistheory.com/proxy`
</span>

<span class="http-method patch">
  <span class="method-wrapper">
    <span class="box-method">PATCH</span>
  </span>
  `https://api.basistheory.com/proxy`
</span>

<span class="http-method delete">
  <span class="method-wrapper">
    <span class="box-method">DELETE</span>
  </span>
  `https://api.basistheory.com/proxy`
</span>

<span class="http-method get">
  <span class="method-wrapper">
    <span class="box-method">GET</span>
  </span>
  `https://api.basistheory.com/proxy`
</span>

Proxy a request to a third party API.

**Authentication**

Proxy requests must be authenticated using a `BT-API-KEY` header (see [Authentication](#authentication)).

Any authentication required by the destination service can be set on the request and will be forwarded through the proxy,
(for example, by setting the `Authorization` header).

**Permissions**

Depending on the [classification(s)](#tokens-token-classifications) of Tokens you need to forward to a third party, the corresponding `token:<classification>:use:proxy` permission is required.
At least one `token:<classification>:use:proxy` permission is required, for example:

<p class="scopes">
  <span class="scope">token:general:use:proxy</span>
  <span class="scope">token:pci:use:proxy</span>
  <span class="scope">token:bank:use:proxy</span>
</p>

**Configuration**

Basis Theory's Proxy provides two ways to configure a request. The first option is to [create a pre-configured Proxy](#proxies-create-a-proxy) and set the `BT-PROXY-KEY` header which will route traffic to the configured `destination_url`.

The alternative is to set the `BT-PROXY-URL` request header. The value of the `BT-PROXY-URL` header defines the base URL to which the request will be proxied. 

The configured proxy URL must use HTTPS with DNS as the host (explicit IP addresses are not allowed). Destinations must use HTTPS >= TLSv1.2.
  
The proxy URL will serve as the base URL for the proxied request. Any path and/or query parameters under `/proxy/**` will be appended to the base URL before forwarding the request.

For example, sending a proxy request to `https://api.basistheory.com/proxy/foo/bar?param=value` and including the header `BT-PROXY-URL=https://example.com/api` will result in the request being forwarded to `https://example.com/api/foo/bar?param=value`.

**Reactors**

Basis Theory's Proxy supports executing reactors when making requests. When pre-configuring a [Proxy](#proxies-create-a-proxy), the `request_reactor_id` property can be set to the ID of an existing [Reactor](#reactors). This reactor will be executed when the request is made allow you to transform the request body and headers.

The reactor will receive a JSON object with the following payload:

<div class="center-column"></div>
```js
{
  args: {
    body, // detokenized request body
    headers //request headers
  }
}
```

The Reactor must respond with the following object:

<div class="center-column"></div>
```js
{
  raw: {
    body,
    headers
  }
}
```

Within the reactor, the headers and body of the request can be changed.

In some situations, you may want to tokenize or detokenize part of the request body. In order to do this, set the `application.id` property when [creating your reactor](#reactors-create-reactor). This will inject a pre-configured Basis Theory JS instance into the request:

<div class="center-column"></div>
```js
module.exports = async function (req) {
   const token = await req.bt.tokenize({
      type: 'token',
      data: req.args.body.sensitive_value
  });

  req.args.body.sensitive_value = token.id;

  return {
    raw {
      body: req.args.body,
      headers: req.args.headers
    }
  }
}
```

In the above example, we utilized the injected Basis Theory JS instance to tokenize a property called `sensitive_value` on our request body and passed the token back as the updated `sensitive_value` to be forwarded to the configured `destination_url` on our [Proxy](#proxies).

**Detokenization**

The Basis Theory Proxy will attempt to [detokenize](/detokenization) any [detokenization expressions](/detokenization#detokenization-expressions) present in the request and inject the raw token data in the request body before it is sent to the downstream destination.

For example, given a token:

<div class="center-column"></div>
```json
{
    "id": "26818785-547b-4b28-b0fa-531377e99f4e",
    "data": "sensitive data"
}
```  

and a proxy request with the body:

<div class="center-column"></div>
```json
{
    "parameter1": "{{26818785-547b-4b28-b0fa-531377e99f4e}}",
    "parameter2": "non-sensitive data"
}
```  

then the following request body will be sent to the destination:

<div class="center-column"></div>
```json
{
    "parameter1": "sensitive data",
    "parameter2": "non-sensitive data"
}
```

The `token:<classification>:use:proxy` permission is required in order to detokenize tokens classified as `<classification>` within a proxy request. 
At most, 100 tokens may be detokenized within a single proxy request. You can find more information about the supported detokenization expressions [here](/detokenization#detokenization-expressions).

<aside class="notice">
  <span>For more detailed examples about how to detokenize within the Proxy, check out our <a href="/detokenization#examples">Detokenization Examples</a>.</span>
</aside>

### Proxy Responses

Unless an error occurs within the Basis Theory Proxy, the raw response from the destination will be returned from the proxy.

If an error occurs within the proxy (eg. missing or invalid `BT-PROXY-URL` header), then the following error response will be returned:

| Attribute     | Type  | Description                              |
|---------------|-------|------------------------------------------|
| `proxy_error` | *any* | A standard Basis Theory [error](#errors) |

<aside class="warning">
  <span>If you are interested in using the proxy and your use case is not currently supported, please <a href="mailto:support@basistheory.com?subject=Proxy Feature Request">submit a feature request</a>!</span>
</aside>

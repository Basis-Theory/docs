<h1 id="proxy">Proxy <span class="beta menu">BETA</span></h1>

<aside class="warning">
  <span>The Basis Theory Proxy is currently available in Public Beta. The features listed below are subject to change. If you are interested in using the proxy and your use case is not currently supported, please <a href="mailto:support@basistheory.com?subject=Proxy Feature Request">submit a feature request</a>!</span>
</aside>

## Proxying Outbound Requests

The Basis Theory Proxy provides a simple mechanism to use the data you've stored with Basis Theory in outbound requests to a third party API.
Basis Theory token identifiers included in the request will be replaced with the raw token data and then the modified request will be forwarded to the destination specified in the `BT-PROXY-URL` request header. The destination will receive the raw data in the request without your system needing to interact with sensitive data on your own servers.

### Proxy Requests

> Request

```shell
curl "https://api.basistheory.com/proxy" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "BT-PROXY-URL: https://example.com/api" \
  -X "POST" \
  -d '{
    "parameter1": "{{26818785-547b-4b28-b0fa-531377e99f4e}}",
    "parameter2": "non-interpolated"
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

Proxy requests must be authenticated using an `X-API-KEY` header (see [Authentication](#authentication)). 

**Permissions**

Depending on the [classification(s)](#tokens-token-classifications) of Tokens you need to forward to a third party, the corresponding `token:<classification>:use:proxy` permission is required.
At least one `token:<classification>:use:proxy` permission is required, for example:

<p class="scopes">
  <span class="scope">token:general:use:proxy</span>
  <span class="scope">token:pci:use:proxy</span>
  <span class="scope">token:bank:use:proxy</span>
</p>

**Configuration**

Proxy requests require a `BT-PROXY-URL` request header to be set. The value of the `BT-PROXY-URL` header defines the base URL to which the request will be proxied.
The `BT-PROXY-URL` request header must use HTTPS with DNS as the host. Destinations must use HTTPS >= TLSv1.2 over port 443.
  
The `BT-PROXY-URL` request header will serve as the base URL for the proxied request. Any path and/or query parameters under `/proxy/**` will be appended to the base URL before forwarding the request.

For example, sending a proxy request to `https://api.basistheory.com/proxy/foo/bar?param=value` and including the header `BT-PROXY-URL=https://example.com/api` will result in the request being forwarded to `https://example.com/api/foo/bar?param=value`.

**Detokenization**

The Basis Theory Proxy will attempt to detokenize certain interpolation patterns and inject the raw token data in the request body before sending the request to the downstream destination.

The proxy will substitute any patterns of the form `{{tokenId}}` within the request with the raw token data represented by that `tokenId`. For example,
given a token:

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
    "parameter2": "non-interpolated"
}
```  

then the following request body will sent to the desintation:

<div class="center-column"></div>
```json
{
    "parameter1": "senstive data",
    "parameter2": "non-interpolated"
}
```

Requests may contain a mixture of both token interpolation patterns and non-interpolated raw data. The `token:<classification>:use:proxy` permission is required in order to detokenize tokens classified as `<classification>` within a proxy request. At most, 100 unique tokens may be detokenized within a single proxy request.

<aside class="notice">
  <span>In the current beta version of the proxy, only primitive generic tokens (of type <code>token</code>) can be interpolated in proxy requests. Proxy requests that contain <code>card</code> or <code>bank</code> tokens, or generic tokens containing complex structured json data will be rejected with a 400 error.</span>
</aside>

### Proxy Responses

Unless an error occurs within the Basis Theory Proxy, the raw response from the destination will be returned from the proxy.

If an error occurs within the proxy (eg. missing or invalid `BT-PROXY-URL` header), then the following error response will be returned:

| Attribute     | Type  | Description                              |
|---------------|-------|------------------------------------------|
| `proxy_error` | *any* | A standard Basis Theory [error](#errors) |

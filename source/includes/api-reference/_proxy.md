# Proxy

<aside class="warning">
  <span>The Basis Theory Proxy is currently available publicly but is still in beta status. The features listed below are subject to change. If you are interested in using the proxy and your use case is not currently supported, please <a href="mailto:support@basistheory.com?subject=Proxy Feature Request">submit a feature request</a>!</span>
</aside>

## Proxying Outbound Requests

The Basis Theory Proxy provides a simple mechanism to use your token data stored in the Basis Theory Vault in outbound requests to a third party API.
Requests containing tokens can be sent to a third party through the proxy and Basis Theory will detect the presence of these tokens and substitute the raw token data within the request that is forwarded to the third party API. The third party will receive the detokenized data in the request without your system needing to interact with this sensitive data on your own servers.

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

At least one of the following permissions is required:

<p class="scopes">
  <span class="scope">token:use</span>
  <span class="scope">card:use</span>
  <span class="scope">bank:use</span>
</p>

**Configuration**

Proxy requests require a `BT-PROXY-URL` header to be included. The value of this header defines the destination url to which the request will be proxied.
We require that the destination url uses HTTPS with >= TLSv1.2 on port 443. The url must specify the url using DNS - direct IP addresses are not supported.
  
The `BT-PROXY-URL` header and the `/proxy` endpoint both support urls that include routes or query string parameters and these values will be included in the proxied request. 

For example, sending a proxy request to `https://api.basistheory.com/proxy/foo/bar?param=value` and including the header `BT-PROXY-URL=https://example.com/api` will result in the request being forwarded to `https://example.com/api/foo/bar?param=value`.

**Detokenization**

Detokenization is the process of exchanging a non-sensitive token for the senstitive data that token represents. The Basis Theory Proxy will attempt to detokenize certain interpolation patterns in the request body before sending the request to the downstream destination.

The proxy will substitute any patterns of the form `{{tokenId}}` within the request with the raw token data represented by that `tokenId`. For example,
given a token of the form:

<div class="center-column"></div>
```json
{
    "id": "26818785-547b-4b28-b0fa-531377e99f4e",
    "data": "sensitive data"
}
```  

and a proxy request with a body of the form:

<div class="center-column"></div>
```json
{
    "parameter1": "{{26818785-547b-4b28-b0fa-531377e99f4e}}",
    "parameter2": "non-interpolated"
}
```  

then the following request body will sent to the desintation url:

<div class="center-column"></div>
```json
{
    "parameter1": "senstive data",
    "parameter2": "non-interpolated"
}
```

Note that requests may contain a mixture of both token interpolation patterns and non-interpolated raw data. The `<token_type>:use` permission is required in order to detokenize tokens of type `<token_type>` within a proxy request. At most 100 unique tokens may be detokenized within a single proxy request.

<aside class="notice">
  <span>In the current beta version of the proxy, only primitive generic tokens (of type <code>token</code>) can be interpolated in proxy requests. Proxy requests that contain <code>card</code> or <code>bank</code> tokens, or generic tokens containing complex structured json data will be rejected with a 400 error.</span>
</aside>

### Proxy Responses

Unless an error occurs within the Basis Theory Proxy, the raw response from the destination will be returned from the proxy.

If an error occurs within the proxy (eg. missing or invalid `BT-PROXY-URL` header), then the following error response will be returned:

| Attribute     | Type  | Description                              |
|---------------|-------|------------------------------------------|
| `proxy_error` | *any* | A standard Basis Theory [error](#errors) |
  
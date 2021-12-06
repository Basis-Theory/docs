# Proxy

<aside class="notice">
  <span>The Basis Theory Proxy is currently available publicly but is still in beta status. The features listed below are subject to change. If you are interested in using the proxy and your use case is not currently supported, please submit a feature request to <a href="mailto:support@basistheory.com?subject=Proxy Feature Request"></a>.</span>
</aside>

## Proxying Outbound Requests

The Basis Theory Proxy provides a simple mechanism to use your token data stored in the Basis Theory Vault in outbound requests to a third party API.
Requests containing tokens can be sent to a third party through the proxy and Basis Theory will detect the presence of these tokens and substitute the raw token data within the request that is forwarded to the third party API. The third party will receive the detokenized data in the request without your system needing to interact with this sensitive data on your own servers.

### Proxy Requests

<span class="http-method post">
  `https://api.basistheory.com/proxy`
</span>

Proxy a request to a third party API. The following HTTP verbs are supported:  

- POST
- PUT
- PATCH
- DELETE
- GET

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
  
The `BT-PROXY-URL` header and the `/proxy` endpoint both support urls that include routes or query string parameters and these values will be included in the proxied request. For example, sending a proxy request to `https://api.basistheory.com/proxy/foo/bar?param=value` and including the header `BT-PROXY-URL=https://example.com/api` will result in the request being forwarded to `https://example.com/api/foo/bar?param=value`.

**Detokenization**
- detokenization
  - interpolation patterns
  - restriction on primitive token data
  - supported token types
  - Required permissions (`token:use`)

### Proxy Responses
- header forwarding / addition / removal (how much do we disclose here?)
- Response
  - success behavior

*Errors*
  - proxy_error, and common error status codes
  - errors from third party
  
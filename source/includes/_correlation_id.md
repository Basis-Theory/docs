# Request correlation

> Correlation ID Example:

```shell
curl "api.basistheory.com" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "bt-trace-id: aa5d3379-6385-4ef4-9fdb-ca1341572153"
```

Basis Theory utilizes Correlation IDs to assist with request tracing, logging, and debugging.

All API endpoints accepts a client-provided Correlation ID if sent with the `bt-trace-id` HTTP header within POST, PUT, PATCH, DELETE methods.

If a `bt-trace-id` Correlation ID is not provided by the client, a new Correlation ID will be generated by the Basis Theory API.
# Exchanges


## Create Exchange

> Create Exchange Request Example:

```shell
curl "https://api.basistheory.com/exchanges" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
    "name": "My Exchange",
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    },
    "template": {
      "id": "17069df1-80f4-439e-86a7-4121863e4678"
    }
  }'
```

> Create Exchange Response Example:

```json
{
  "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Exchange",
  "template": {...},
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/exchanges`
</span>

Create a new exchange from an exchange template for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:create</span>
</p>

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange. Has a maximum length of `200`
`configuration` | true | *object* | `null` | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-schema)
`template.id` | true | *string* | `null` | Unique identifier of the exchange template to configure an exchange for

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange which can be used to [get an exchange](#get-an-exchange)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the exchange
`name` | *string* | The name of the exchange
`template` | *object* | The [exchange template](#get-an-exchange-template) the exchange is configured for
`configuration` | *object* | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-schema)
`created_at` | *string* | Created date of the exchange in ISO 8601 format


### Response Messages

Code | Description
---- | -----------
`201` | Exchange successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## List Exchanges

> List Exchanges Request Example:

```shell
curl "https://api.basistheory.com/exchanges" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Exchanges Response Example:

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "name": "My Exchange",
      "template": {...},
      "configuration": {
        "SERVICE_API_KEY": "key_abcd1234"
      },
      "created_at": "2020-09-15T15:53:00+00:00",
      "modified_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/exchanges`
</span>

Get a list of exchanges for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | false | *array* | `[]` | An optional list of exchange ID's to filter the list of exchanges by
`name` | false | *string* | `null` | Wildcard search of exchanges by name
`source_token_type` | false | *string* | `null` | Filter exchanges by exchange template [source token type](#token-types)

### Response Schema

Returns the [Pagination](#pagination) schema. The `data` attribute in the response contains an array of exchanges with the following schema:

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange which can be used to [get an exchange](#get-an-exchange)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the exchange
`name` | *string* | The name of the exchange
`template` | *object* | The [exchange template](#get-an-exchange-template) the exchange is configured for
`configuration` | *object* | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-schema)
`created_at` | *string* | Created date of the exchange in ISO 8601 format
`modified_at` | *string* | Last modified date of the exchange in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Exchanges successfully retrieved
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## Get an Exchange

> Get an Exchange Request Example:

```shell
curl "https://api.basistheory.com/exchanges/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Get an Exchange Response Example:

```json
{
  "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Exchange",
  "template": {...},
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/exchanges/{id}`
</span> 

Get an exchange by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the exchange

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange which can be used to [get an exchange](#get-an-exchange)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the exchange
`name` | *string* | The name of the exchange
`template` | *object* | The [exchange template](#get-an-exchange-template) the exchange is configured for
`configuration` | *object* | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-schema)
`created_at` | *string* | Created date of the exchange in ISO 8601 format
`modified_at` | *string* | Last modified date of the exchange in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Exchange successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The exchange was not found


## Update Exchange

> Update Exchange Request Example:

```shell
curl "https://api.basistheory.com/exchanges/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "PUT"
  -D '{
    "name": "My Exchange",
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    }
  }'
```

> Update Exchange Response Example:

```json
{
  "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Exchange",
  "template": {...},
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/exchanges/{id}`
</span>

Update an exchange by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:update</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the exchange

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange. Has a maximum length of `200`
`configuration` | true | *object* | `null` | A key-value map of all configuration name and values for the [exchange template configuration](#exchange-template-configuration-schema)

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange which can be used to [get an exchange](#get-an-exchange)
`tenant_id` | *string* | The [tenant](#tenants) ID which owns the exchange
`name` | *string* | The name of the exchange
`template` | *object* | The [exchange template](#get-an-exchange-template) the exchange is configured for
`configuration` | *object* | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-schema)
`created_at` | *string* | Created date of the exchange in ISO 8601 format
`modified_at` | *string* | Last modified date of the exchange in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Exchange successfully updated
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The exchange was not found


## Delete Exchange

> Delete Exchange Request Example:

```shell
curl "https://api.basistheory.com/exchanges/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/exchanges/{id}`
</span>

Delete an exchange by ID in the tenant.

### Permissions

`exchange:delete`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the exchange

### Response Messages

Code | Description
---- | -----------
`204` | Exchange successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The exchange was not found

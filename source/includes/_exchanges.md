# Exchanges


## Exchange Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the exchange which can be used to [get an exchange](#get-an-exchange)
`tenant_id` | *uuid* | The [tenant](#tenants) ID which owns the exchange
`name` | *string* | The name of the exchange
`template` | *[exchange template](#exchange-template-object)* | Exchange template this exchange is configured for
`configuration` | *map* | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-object)
`created_at` | *string* | Created date of the exchange in ISO 8601 format
`modified_at` | *string* | Last modified date of the exchange in ISO 8601 format


## Create Exchange

> Request

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

```csharp
var client = new ExchangeClient("key_N88mVGsp3sCXkykyN2EFED");

var exchange = await client.CreateAsync(new Exchange {
  Name = "My Exchange",
  Configuration = new Dictionary<string, string> {
    { "SERVICE_API_KEY", "key_abcd1234" }
  },
  Template = new Template {
    Id = new Guid("17069df1-80f4-439e-86a7-4121863e4678")
  }
});
```

> Response

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

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange. Has a maximum length of `200`
`configuration` | true | *object* | `null` | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-object)
`template.id` | true | *uuid* | `null` | Unique identifier of the [exchange template](#exchange-template-object) to configure an exchange for

### Response

Returns an [exchange](#exchange-object) if the exchange was created. Returns [an error](#errors) if there were validation errors or the exchange failed to create.


## List Exchanges

> Request

```shell
curl "https://api.basistheory.com/exchanges" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new ExchangeClient("key_N88mVGsp3sCXkykyN2EFED");

var exchanges = await client.GetAsync();
```

> Response

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

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | false | *array* | `[]` | An optional list of exchange ID's to filter the list of exchanges by
`name` | false | *string* | `null` | Wildcard search of exchanges by name
`source_token_type` | false | *string* | `null` | Filter exchanges by exchange template [source token type](#token-types)

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [exchanges](#exchange-object). Providing any query parameters will filter the results. Returns [an error](#errors) if exchanges could not be retrieved.


## Get an Exchange

> Request

```shell
curl "https://api.basistheory.com/exchanges/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new ExchangeClient("key_N88mVGsp3sCXkykyN2EFED");

var exchange = await client.GetByIdAsync("5b493235-6917-4307-906a-2cd6f1a90b13");
```

> Response

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
`id` | true | *uuid* | `null` | The ID of the exchange

### Response

Returns an [exchange](#exchange-object) with the `id` provided. Returns [an error](#errors) if the exchange could not be retrieved.


## Update Exchange

> Request

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

```csharp
var client = new ExchangeClient("key_N88mVGsp3sCXkykyN2EFED");

var exchange = await client.UpdateAsync("5b493235-6917-4307-906a-2cd6f1a90b13", 
  new Exchange {
    Name = "My Exchange",
    Configuration = new Dictionary<string, string> {
      { "SERVICE_API_KEY", "key_abcd1234" }
    }
  }
);
```

> Response

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
`id` | true | *uuid* | `null` | The ID of the exchange

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange. Has a maximum length of `200`
`configuration` | true | *object* | `null` | A key-value map of all configuration name and values for an [exchange template configuration](#exchange-template-configuration-object)

### Response

Returns an [exchange](#exchange-object) if the exchange was updated. Returns [an error](#errors) if there were validation errors or the exchange failed to update.


## Delete Exchange

> Request

```shell
curl "https://api.basistheory.com/exchanges/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

```csharp
var client = new ExchangeTClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("fb124bba-f90d-45f0-9a59-5edca27b3b4a");
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
`id` | true | *uuid* | `null` | The ID of the exchange

### Response

Returns [an error](#errors) if the exchange failed to delete.

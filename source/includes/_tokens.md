# Tokens

## Create a new token

```shell
curl --request POST \
  "https://api-dev.basistheory.com/tokens" \
  --header 'Content-Type: application/json' \
  --header "X-API-KEY: test_123456790"
  --data '{
  "data": "string or object data",
  }'
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")

BasisTheory.vault.createToken("string or object data")
  .then(function (res) { 
      console.log(res.id) // token id, e.g. "bt_tok_1234" 
  });
```

> The above command returns JSON structured like this:

```json
{
  "id": "tok_1234",
  "data": "{encrypted_data}"
}
```

This endpoint tokenize any set of data passed to the `/tokens` endpoint. This will store and encrypt you data and return a uniquely generated token back to you. 

### HTTP Request

`POST https://api-dev.basistheory.com/tokens`

### Required Scopes

- `vault:write`

### Query Parameters

Parameter | Description
--------- | -----------
data | string or object to be tokenized

### Response Properties

Parameter | Description
--------- | -----------
id | the id of the token that has been created
data | string or object that was tokenized

## Get an existing token

```shell
curl "https://api-dev.basistheory.com/tokens/tok_1234" \
  -H "X-API-KEY: test_123456790"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")

let token = BasisTheory.vault.getToken("tok_1234")
  .then(function (res) { 
      console.log(res.data); // string or object data 
  });
```

> The above command returns JSON structured like this:

```json
{
  "token": "tok_1234",
  "data": "{encrypted_data}"
}
```

Returns the raw data associated with a `token`

### HTTP Request

`GET https://api-dev.basistheory.com/tokens/:token_id`

### Required Scopes

- `vault:read`

### Query Parameters

Parameter | Description
--------- | -----------
token_id | token id that you want to retrieve

### Response Properties

Parameter | Description
--------- | -----------
id | the id of the token that has been created
data | string or object that was tokenized


## List your tokens

```shell
curl "https://api-dev.basistheory.com/tokens" \
  -H "X-API-KEY: test_123456790"
```

> The above command returns JSON structured like this:

```json
[
  {
    "token": "tok_1234",
    "data": "{encrypted_data}"
  },
  //... additional tokens
]
```

Returns the raw data associated with a `token`.

### HTTP Request

`GET https://api-dev.basistheory.com/tokens`

### Required Scopes

- `vault:read`

### Query Parameters

Parameter | Description
--------- | -----------
token_id | token id that you want to retrieve

### Response Properties

Parameter | Description
--------- | -----------
id | the id of the token that has been created
data | string or object that was tokenized

## Delete a token

```shell
curl "https://api-dev.basistheory.com/tokens/tok_1234" \
  -X DELETE \
  -H "Authorization: api_key_1234"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("api_key_1234")

BasisTheory.vault.deleteToken("tok_1234");
```

This endpoint will remove any underlying data associated with the token, we will retain the token reference and audit logs for future reference. The data will be permanently deleted.

<aside class="warning">
WARNING - The data associated with a deleted token will be removed forever. The reference will still exists for audit purposes
</aside>

### HTTP Request

`DELETE http://api.basistheory.com/tokens/:token_id`

### Required Scopes

- `vault:delete`

### URL Parameters

Parameter | Description
--------- | -----------
token_id | token id that you want to retrieve

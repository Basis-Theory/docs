# Vault

## Get Token

```shell
curl "http://example.com/token/tok_1234" \
  -H "X-API-KEY: test_123456790"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")

let token = BasisTheory.vault.getToken("tok_1234");
```

> The above command returns JSON structured like this:

```json
{
  "token": "tok_1234",
  "data": "{encrypted_data}"
}
```

This endpoint tokenizes encrypted string data.

### HTTP Request

`POST http://example.com/api/token/{token_id}`

### Query Parameters

Parameter | Description
--------- | -----------
ID | token id that you want to retrieve 

<aside class="success">
Remember — you'll need to be authenticated to use this endpoint!
</aside>

## Delete a Specific Token

```shell
curl "http://example.com/token/tok_1234" \
  -X DELETE \
  -H "Authorization: api_key_1234"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("api_key_1234")

BasisTheory.vault.deleteToken("tok_1234");
```

This endpoint deletes a token.

### HTTP Request

`DELETE http://example.com/token/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | token id that you want to retrieve


# Detokenization Expressions

Detokenization is performed whenever a **detokenization expression** is identified within a request.
In their simplest form, these are expressions of the form `{{<tokenId>}}` which will be replaced with the token data contained within the token with id `<tokenId>`.

Any pattern that is wrapped in `{{ }}` will be evaluated for detokenization.
Detokenization expressions containing non-uuid values, such as `{{non uuid value}}` will be ignored and the expression will not be replaced within the request.

Any `uuid` value contained in a detokenization expression is expected to represent the `id` of a token within your tenant. 
If no such token is found with that identifier, the request will be rejected with a 400 error.

If a token is found with the given `uuid` identifier, but the calling application is missing permission to use that 
token, then the request will be rejected with a 403 error. 
See the following links for more information about the permissions required to use tokens in a 
[Reactor](/#reactors-invoke-a-reactor) or [Proxy](/#proxy-proxying-outbound-requests).

Token data can also be transformed within a detokenization expression before including it in a request, for example,
to project a single primitive value out of a complex object or to format a value.
In general, transformations are applied to token data using the syntax:   
`{{ <tokenId> | <transformation> }}`

Check out the section on [Transformations](#transformations) below for more background information
and detailed documentation about all supported transformation functions. 
Also, check out the [examples](#examples) below to see transformations in action.

## Detokenizing Primitive Data

Tokens containing primitive data values, such as a single string or numeric value, can be easily detokenized within a 
request just by substituting the token data in place of the detokenization expression. For example, say you have the token:

<div class="center-column"></div>
```json
{
  "id": "1d08babf-456a-4bef-993d-aece3c1a2f66",
  "type": "social_security_number",
  "data": "111-22-3333"
}
```

Then a request containing the detokenization expression: 

<div class="center-column"></div>
```json
{
  "ssn": "{{1d08babf-456a-4bef-993d-aece3c1a2f66}}"
}
```

will be detokenized into the request:   

<div class="center-column"></div>
```json
{
  "ssn": "111-22-3333"
}
```

## Detokenizing Complex Data

Card, Bank, or generic tokens containing complex JSON objects can all be detokenized as well.
Detokenization of complex token data is performed by embedding the token's JSON data within the request.
For example, say you have the Card token:

<div class="center-column"></div>
```json
{
  "id": "5c20545b-52dc-4a60-b9b5-5b7c84f22369",
  "type": "card",
  "data": {
    "number": "4242424242424242",
    "expiration_month": 12,
    "expiration_year": 2025,
    "cvc": "123"
  }
}
```

Then you can embed the entire [Card](/#token-types-card) object within a request with the detokenization expression:

<div class="center-column"></div>
```json
{
  "card": "{{5c20545b-52dc-4a60-b9b5-5b7c84f22369}}"
}
```

which will be detokenized into the request:

<div class="center-column"></div>
```json
{
  "card": {
    "number": "4242424242424242",
    "expiration_month": 12,
    "expiration_year": 2025,
    "cvc": "123"
  }
}
```

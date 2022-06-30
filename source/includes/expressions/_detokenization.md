# Detokenization

Detokenization refers to the process by which non-sensitive token identifiers are replaced with the original token data represented by those tokens.
Basis Theory supports detokenization through the use of expressions within our serverless [Reactor](https://developers.basistheory.com/concepts/what-are-reactors) 
platform and the [Proxy](https://developers.basistheory.com/concepts/what-is-the-proxy).

Detokenization is performed whenever a **detokenization expression** is identified within a request.
In their simplest form, these are Liquid [objects](#language-objects) of the form `{{<tokenId>}}`. 
This expression will be replaced with the token data contained within the token with ID `<tokenId>`.

Any `string` value contained in a detokenization expression is expected to represent the `id` of a token within your tenant. 
If no such token is found with that identifier, the request will be rejected with a 400 error.

If a token is found with the given identifier, but the calling application is missing permission to use that 
token, then the request will be rejected with a 403 error. 
See the following links for more information about the permissions required to use tokens in a 
[Reactor](/#reactors-invoke-a-reactor) or [Proxy](/#proxy-proxying-outbound-requests).

Token data can also be transformed before including it in a request by applying [filters](#filters) within an expression.
In general, filters are applied during detokenization using the syntax:   
`{{ <tokenId> | <filter1> | <filter2> | ... }}`
 
Check out the [detokenization examples](#detokenization-examples) below to see some examples of filters in action.

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
For example, say you have the `card` token:

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

## Examples

Each of the use cases shown below include an example for both Reactors and the Proxy - 
select the appropriate tab at the top of the right-hand column to choose which examples to show.

- [Use Complex Tokens](#detokenization-examples-use-complex-tokens)
- [Override a Field on a Token](#detokenization-examples-override-a-field-on-a-token)
- [Use Multiple Tokens](#detokenization-examples-use-multiple-tokens)
- [Combine Multiple Tokens within a Single Argument](#detokenization-examples-combine-multiple-tokens-within-a-single-argument)
- [Using Custom Token Schemas](#detokenization-examples-using-custom-token-schemas)
- [Transforming Token Data](#detokenization-examples-transforming-token-data)

### Reactor Prerequisites

For the examples below, we will be using a [Reactor](https://developers.basistheory.com/concepts/what-are-reactors) created using the `Spreedly - Card` Reactor Formula.
We will need the `id` of this Reactor in the examples below: `d08bc998-9301-495c-a2e5-04f8dc0916b4`.

This Reactor Formula accepts the following [request parameters](/#reactor-formulas-reactor-formula-object):

| name                    | type     | optional |
|:------------------------|:---------|:---------|
| `card.number`           | *string* | false    |
| `card.expiration_month` | *number* | false    |
| `card.expiration_year`  | *number* | false    |
| `card.cvc`              | *string* | true     |
| `card_owner_full_name`  | *string* | false    |


### Proxy Prerequisites

Also in the examples below, we will [proxy](https://developers.basistheory.com/concepts/what-is-the-proxy) requests to Spreedly using their [Payment Methods API](https://docs.spreedly.com/reference/api/v1/#create-credit-card).
This is the same request that is being made from within the `Spreedly - Card` Reactor Formula.

This API endpoint accepts POST requests with a body of the form:

<div class="center-column"></div>
```json
{
  "payment_method": {
    "credit_card": {
      "number": "4242424242424242",
      "month": "12",
      "year": "2025",
      "verification_value": "123",
      "full_name": "Card Owner"
    },
    "retained": true
  }
}
```

and it authenticates using [basic auth](https://docs.spreedly.com/reference/api/v1/#authentication) -
we will be passing a simulated value in the `Authorization` header on the example proxy requests -
replace this with your own authentication credentials if you want to follow along.

### Use Complex Tokens

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c}}",
              "card_owner_full_name": "John Doe"
            }
        }'
```

```shell--proxy
curl "https://api.basistheory.com/proxy" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "BT-PROXY-URL: https://core.spreedly.com/v1/payment_methods.json" \
      -H "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "payment_method": {
              "credit_card": {
                "number": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.number'}}",
                "month": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.expiration_month'}}",
                "year": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.expiration_year'}}",
                "verification_value": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.cvc'}}",
                "full_name": "John Doe"
              },
              "retained": true
            }
          }'
```

> Detokenized Request

```shell--reactor
{
  "args": {
    "card": {
      "number": "4242424242424242",
      "expiration_month": 11,
      "expiration_year": 2025,
      "cvc": "123"
    },
    "card_owner_full_name": "John Doe"
  }, 
  "configuration": {...}
}
```

```shell--proxy
{
  "payment_method": {
    "credit_card": {
      "number": "4242424242424242",
      "month": "11",
      "year": "2025",
      "verification_value": "123",
      "full_name": "John Doe"
    },
    "retained": true
  }
}
```

In this example, we show how you can use a [Card](/#token-types-card) token to create a Spreedly payment method.

Say you have created the `card` token:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "815029c2-29ec-4fc2-8cd4-99feb3ee582c",
  "type": "card",
  "data": {
    "number": "4242424242424242", 
    "expiration_month": 11,
    "expiration_year": 2025,
    "cvc": "123"
  }
}
```

We have not tokenized the card owner's name, `John Doe`. Assume that we have this plaintext value directly available to our application to pass into the Reactor or Proxy request.

<div></div>

### Override a Field on a Token

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": {
                "number": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.number'}}",
                "expiration_month": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.expiration_month'}}",
                "expiration_year": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.expiration_year'}}",
                "cvc": "987"
              },
              "card_owner_full_name": "John Doe"
            }
        }'
```

```shell--proxy
curl "https://api.basistheory.com/proxy" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "BT-PROXY-URL: https://core.spreedly.com/v1/payment_methods.json" \
      -H "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "payment_method": {
              "credit_card": {
                "number": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.number'}}"
                "month": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.expiration_month'}}",
                "year": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | json: '$.expiration_year'}}",
                "verification_value": "987",
                "full_name": "John Doe"
              },
              "retained": true
            }
          }'
```

> Detokenized Request

```shell--reactor
{
  "args": {
    "card": {
      "number": "4242424242424242",
      "expiration_month": 11,
      "expiration_year": 2025,
      "cvc": "987"
    },
    "card_owner_full_name": "John Doe"
  }, 
  "configuration": {...}
}
```

```shell--proxy
{
  "payment_method": {
    "credit_card": {
      "number": "4242424242424242",
      "month": "11",
      "year": "2025",
      "verification_value": "987",
      "full_name": "John Doe"
    },
    "retained": true
  }
}
```

In this example, we show how you can use a [Card](/#token-types-card) token to create a Spreedly payment method,
but provide an updated CVC (`987`) that is different from the `cvc` value stored within the token.
This could be desired if the updated CVC was collected directly from a user interface, possibly as a challenge to the user to prove they own the card.

Here, we will be using the same `card` token and card owner name from the previous [Use Complex Tokens](#detokenization-examples-use-complex-tokens) example.

<div></div>

### Use Multiple Tokens

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": {
                "number": "{{d9939ddc-d7be-423b-a0f5-69f65fec57df}}"
                "expiration_month": 10,
                "expiration_year": 2024,
                "cvc": "789"
              },
              "card_owner_full_name": "{{f4d86311-1254-4155-b532-b651279a8cc0}}"
            }
        }'
```

```shell--proxy
curl "https://api.basistheory.com/proxy" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "BT-PROXY-URL: https://core.spreedly.com/v1/payment_methods.json" \
      -H "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "payment_method": {
              "credit_card": {
                "number": "{{d9939ddc-d7be-423b-a0f5-69f65fec57df}}",
                "month": "10",
                "year": "2024",
                "verification_value": "789",
                "full_name": "{{f4d86311-1254-4155-b532-b651279a8cc0}}"
              },
              "retained": true
            }
          }'
```

> Detokenized Request

```shell--reactor
{
  "args": {
    "card": {
      "number": "5555555555554444",
      "expiration_month": 10,
      "expiration_year": 2024,
      "cvc": "789"
    },
    "card_owner_full_name": "Jane Doe"
  }, 
  "configuration": {...}
}
```

```shell--proxy
{
  "payment_method": {
    "credit_card": {
      "number": "5555555555554444",
      "month": "10",
      "year": "2024",
      "verification_value": "789",
      "full_name": "Jane Doe"
    },
    "retained": true
  }
}
```

In this example, we will show how you can use multiples tokens - a [Card Number](/#token-types-card-number) token and a
generic `PII` token to hold the card owner's name:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d9939ddc-d7be-423b-a0f5-69f65fec57df",
  "type": "card_number",
  "data": "5555555555554444",
  "privacy": {
    "classification": "pci",
    "impact_level": "high"
  }
}
```

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "f4d86311-1254-4155-b532-b651279a8cc0",
  "type": "token",
  "data": "Jane Doe",
  "privacy": {
    "classification": "pii",
    "impact_level": "moderate"
  }
}
```

In this example, we have not tokenized the card's expiration date or CVC - say our application accepts these values in
plaintext and forwards them directly into the request.

<div></div>

### Combine Multiple Tokens within a Single Argument

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": "{{b78b4bee-5499-42dd-8671-f1d23d32355b}}",
              "card_owner_full_name": "{{523949a9-e32f-4b5b-a0ad-7a435c79deb4}} {{42af9170-e6ca-4ea7-a43b-730a0b47b6d0}}"
            }
        }'
```

```shell--proxy
curl "https://api.basistheory.com/proxy" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "BT-PROXY-URL: https://core.spreedly.com/v1/payment_methods.json" \
      -H "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "payment_method": {
              "credit_card": {
                "number": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | json: '$.number'}}",
                "month": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | json: '$.expiration_month'}}",
                "year": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | json: '$.expiration_year'}}",
                "verification_value": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | json: '$.cvc'}}",
                "full_name": "{{523949a9-e32f-4b5b-a0ad-7a435c79deb4}} {{42af9170-e6ca-4ea7-a43b-730a0b47b6d0}}"
              },
              "retained": true
            }
          }'
```

> Detokenized Request

```shell--reactor
{
  "args": {
    "card": {
      "number": "5105105105105100",
      "expiration_month": 5,
      "expiration_year": 2025,
      "cvc": "123"
    },
    "card_owner_full_name": "John Brown"
  }, 
  "configuration": {...}
}
```

```shell--proxy
{
  "payment_method": {
    "credit_card": {
      "number": "5105105105105100",
      "month": "5",
      "year": "2025",
      "verification_value": "123",
      "full_name": "John Brown"
    },
    "retained": true
  }
}
```

In this example, we will show how you can combine the data from multiple tokens within a single field on a request. Say we have
chosen to store the card holder's first and last names as separate tokens:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "523949a9-e32f-4b5b-a0ad-7a435c79deb4",
  "type": "token",
  "data": "John"
}
```

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "42af9170-e6ca-4ea7-a43b-730a0b47b6d0",
  "type": "token",
  "data": "Brown"
}
```

Also, we have the `card` token:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "b78b4bee-5499-42dd-8671-f1d23d32355b",
  "type": "card",
  "data": {
    "number": "5105105105105100", 
    "expiration_month": 5,
    "expiration_year": 2025,
    "cvc": "123"
  }
}
```

Then we can concatenate the first and last name tokens within the request as shown in the sample requests.

<div></div>

### Using Custom Token Schemas

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": {
                "number": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.card_number'}}",
                "expiration_month": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.exp_month'}}",
                "expiration_year": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.exp_year'}}",
              },
              "card_owner_full_name": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.owner.first_name'}} {{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.owner.last_name'}}"
            }
        }'
```

```shell--proxy
curl "https://api.basistheory.com/proxy" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "BT-PROXY-URL: https://core.spreedly.com/v1/payment_methods.json" \
      -H "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "payment_method": {
              "credit_card": {
                "number": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.card_number'}}",
                "month": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.exp_month'}}",
                "year": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.exp_year'}}",
                "full_name": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.owner.first_name'}} {{9a48a051-972b-4569-8fd5-cbe17a604f96 | json: '$.card.owner.last_name'}}"
              },
              "retained": true
            }
          }'
```

> Detokenized Request

```shell--reactor
{
  "args": {
    "card": {
      "number": "4000056655665556",
      "expiration_month": 4,
      "expiration_year": 2026,
    },
    "card_owner_full_name": "John Smith"
  }, 
  "configuration": {...}
}
```

```shell--proxy
{
  "payment_method": {
    "credit_card": {
      "number": "4000056655665556",
      "month": "4",
      "year": "2026",
      "full_name": "John Smith"
    },
    "retained": true
  }
}
```

In this example, we will store our card data within a custom generic token that contains additional fields relevant to our application:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "9a48a051-972b-4569-8fd5-cbe17a604f96",
  "type": "token",
  "data": {
    "card": {
      "card_number": "4000056655665556",
      "exp_month": 4,
      "exp_year": 2026,
      "owner": {
        "first_name": "John",
        "middle_name": "Andrew",
        "last_name": "Smith"
      }
    },
    "billing_address": {
      "street_address": "175 5th Ave",
      "city": "New York",
      "state": "NY",
      "zip": "10010"
    }
  },
  "privacy": {
    "classification": "pci",
    "impact_level": "high"
  }
}
```

Notice that the card owner's full name is constructed by concatenating the `card.owner.first_name` and `card.owner.last_name`
properties into a single string value.

<div></div>

### Transforming Token Data

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": {
                "number": "{{67d76cd0-bc2a-4a73-be8c-6539c81db465 | json: '$.card_number'}}",
                "expiration_month": "{{67d76cd0-bc2a-4a73-be8c-6539c81db465 | json: '$.expiration_month' | pad_left: 2, '0'}}",
                "expiration_year": "{{67d76cd0-bc2a-4a73-be8c-6539c81db465 | json: '$.expiration_year' | slice: -2, 2}}",
              },
              "card_owner_full_name": "John Doe"
            }
        }'
```

```shell--proxy
curl "https://api.basistheory.com/proxy" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "BT-PROXY-URL: https://core.spreedly.com/v1/payment_methods.json" \
      -H "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "payment_method": {
              "credit_card": {
                "number": "{{67d76cd0-bc2a-4a73-be8c-6539c81db465 | json: '$.card_number'}}",
                "month": "{{67d76cd0-bc2a-4a73-be8c-6539c81db465 | json: '$.expiration_month' | pad_left: 2, '0'}}",
                "year": "{{67d76cd0-bc2a-4a73-be8c-6539c81db465 | json: '$.expiration_year' | slice: -2, 2}}",
                "full_name": "John Doe"
              },
              "retained": true
            }
          }'
```

> Detokenized Request

```shell--reactor
{
  "args": {
    "card": {
      "number": "4000056655665556",
      "expiration_month": "03",
      "expiration_year": "25"
    },
    "card_owner_full_name": "John Smith"
  }, 
  "configuration": {...}
}
```

```shell--proxy
{
  "payment_method": {
    "credit_card": {
      "number": "4000056655665556",
      "month": "03",
      "year": "25",
      "full_name": "John Doe"
    },
    "retained": true
  }
}
```

In this example, we will be using the `card` token:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "67d76cd0-bc2a-4a73-be8c-6539c81db465",
  "type": "card",
  "data": {
    "number": "4242424242424242", 
    "expiration_month": 3,
    "expiration_year": 2025,
    "cvc": "123"
  }
}
```

We will transform the `expiration_month` property within this token to be padded on the left with a `0` to two characters, 
and to only provide the last two digits of the expiration year.

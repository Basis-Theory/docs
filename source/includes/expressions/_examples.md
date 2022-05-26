# Examples

Based on your use cases, you may prefer to store your sensitive data with Basis Theory using one of our pre-defined [Token Types](/#token-types)
or even use your own custom data schema within a schemaless [generic token](/#token-types-token).
However you choose to tokenize your sensitive data, Basis Theory grants you the flexibility to use this data within
our serverless Reactor platform or the Proxy.

In this section, we will walk through several examples of how you can detokenize data within Reactors or Proxy requests 
regardless of how the data was tokenized.

## Prerequisites

If Reactors or Proxy are completely new to you, we recommend you first read our [Reactors](https://developers.basistheory.com/concepts/what-are-reactors) 
or [Proxy](https://developers.basistheory.com/concepts/what-is-the-proxy) concept pages.

### Reactor Prerequisites

For the examples below, we will be using a Reactor created using the `Spreedly - Card` Reactor Formula. 
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

Also in the examples below, we will be proxying requests to Spreedly using their [Payment Methods API](https://docs.spreedly.com/reference/api/v1/#create-credit-card).
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

## Use Complex Tokens

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
                "number": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.number}}",
                "month": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.expiration_month}}",
                "year": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.expiration_year}}",
                "verification_value": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.cvc}}",
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

Say you have created the Card token:

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

## Override a Field on a Token

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": {
                "number": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.number}}",
                "expiration_month": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.expiration_month}}",
                "expiration_year": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.expiration_year}}",
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
                "number": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.number}}"
                "month": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.expiration_month}}",
                "year": "{{815029c2-29ec-4fc2-8cd4-99feb3ee582c | $.expiration_year}}",
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

Here, we will be using the same Card token and card owner name from the previous [Use Complex Tokens](#examples-use-complex-tokens) example.

## Use Multiple Tokens

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

## Combine Multiple Tokens within a Single Argument

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
                "number": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | $.number}}",
                "month": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | $.expiration_month}}",
                "year": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | $.expiration_year}}",
                "verification_value": "{{b78b4bee-5499-42dd-8671-f1d23d32355b | $.cvc}}",
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

Also, we have the Card token:

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

## Using Custom Token Schemas

> Original Request

```shell--reactor
curl "https://api.basistheory.com/reactors/d08bc998-9301-495c-a2e5-04f8dc0916b4/react" \
      -H "BT-API-KEY: key_NS21v84n7epsSc5WzoFjM6" \
      -H "Content-Type: application/json" \
      -X "POST" \
      -d '{
            "args": {
              "card": {
                "number": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.card_number}}",
                "expiration_month": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.exp_month}}",
                "expiration_year": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.exp_year}}",
              },
              "card_owner_full_name": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.owner.first_name}} {{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.owner.last_name}}"
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
                "number": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.card_number}}",
                "month": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.exp_month}}",
                "year": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.exp_year}}",
                "full_name": "{{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.owner.first_name}} {{9a48a051-972b-4569-8fd5-cbe17a604f96 | $.card.owner.last_name}}"
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

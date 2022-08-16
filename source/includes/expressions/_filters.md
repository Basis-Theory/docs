# Filters

Oftentimes data may be tokenized in one format, but you wish to use this data in a different format within a request.
Several pieces of data may be stored together in a single token (e.g. a user record containing first and last names and contact information), 
but you wish to only use a single piece of that data within a Proxy or Reactor request, 
or you may wish to reformat the data before indexing it for search (e.g. use only the last name, but normalize by uppercasing it).

To allow you complete flexibility, transformation functions called **filters** can be applied within any expression. 
Generally, a variable's value can be transformed by specifying a filter after the `|` symbol:   
`{{ <variable> | <filter> }}`

You can effectively think of this as "piping" a variable into the filter in the same way you may be familiar with the "pipe" operator from Unix-like systems.
Multiple filters can be chained together by "piping" the result of each filter into the next, applying in order from left to right:  
`{{ <variable> | <filter1> | <filter2> | ... }}`

All standard [Liquid filters](https://shopify.github.io/liquid/filters/) are supported within expressions. 
For example, given a token containing a `name` object containing both first and last name properties:

<div class="center-column" style="clear: none;"></div>
```json
{
  "data": {
    "name": "John Doe"
  },
  ...
}
```

We can create an expression to return the upper-cased last name by splitting on the space character, grabbing the last element, and upper-casing:

<div class="center-column" style="clear: none;"></div>
```js
{{ data.name | split: ' ' | last | upcase }}
```

This expression would evaluate to the value `"DOE"`.

In addition to the standard Liquid filters, several custom filters are also available:


## alias_preserve_format

Randomly generates a unique alias that preserves the format of the input string, optionally revealing a specified 
number of characters from the beginning and end of the value. 

Alpha characters are replaced with randomized alpha characters, numeric characters are replaced with randomized numeric 
characters, and special characters and whitespace are preserved.

### Parameters

| Position | Name                | Type  | Required | Default Value | Description                                                        |
|----------|---------------------|-------|----------|---------------|--------------------------------------------------------------------|
| 0        | reveal_first_length | *int* | false    | `0`           | The number of characters to reveal from the beginning of the value |
| 1        | reveal_last_length  | *int* | false    | `0`           | The number of characters to reveal from the end of the value       |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "<expression>",
  "type": "token",
  "data": "ABC12345DEF67890"
}
```

| Expression                                                 | Example Result     |
|------------------------------------------------------------|--------------------|
| <code>{{ data &#124; alias_preserve_format }}</code>       | "xir83203hqn73599" |
| <code>{{ data &#124; alias_preserve_format: 3 }}</code>    | "ABC83203hqn73599" |
| <code>{{ data &#124; alias_preserve_format: 0, 5 }}</code> | "xir83203hqn67890" |
| <code>{{ data &#124; alias_preserve_format: 3, 5 }}</code> | "ABC83203hqn67890" |


## alias_preserve_length

Randomly generates a unique alias that preserves the length of the input string, optionally revealing a specified
number of characters from the beginning and end of the value.

All characters are replaced with randomized alphanumeric characters.
The type of the character in each position is not preserved, e.g. alpha characters may be replaced with numeric characters and vice versa.
Special characters and whitespace are not preserved and will be replaced with alphanumeric characters.

### Parameters

| Position | Name                | Type  | Required | Default Value | Description                                                        |
|----------|---------------------|-------|----------|---------------|--------------------------------------------------------------------|
| 0        | reveal_first_length | *int* | false    | `0`           | The number of characters to reveal from the beginning of the value |
| 1        | reveal_last_length  | *int* | false    | `0`           | The number of characters to reveal from the end of the value       |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "<expression>",
  "type": "token",
  "data": "ABC12345DEF67890"
}
```

| Expression                                                 | Example Result     |
|------------------------------------------------------------|--------------------|
| <code>{{ data &#124; alias_preserve_length }}</code>       | "v38anr9m2cx0giw7" |
| <code>{{ data &#124; alias_preserve_length: 3 }}</code>    | "ABCanr9m2cx0giw7" |
| <code>{{ data &#124; alias_preserve_length: 0, 5 }}</code> | "v38anr9m2cx67890" |
| <code>{{ data &#124; alias_preserve_length: 3, 5 }}</code> | "ABCanr9m2cx67890" |


## json

Evaluates a [JSON Path](https://goessner.net/articles/JsonPath/) expression ([proposed spec](https://tools.ietf.org/id/draft-goessner-dispatch-jsonpath-00.html)) on the input object.

All standard JSON Path syntax is supported, provided that the expression resolves to a single value.
If the expression resolves to multiple values, the request will result in a 400 error.

While Liquid supports a very similar syntax to JSON path when selecting properties within a JSON object (e.g. `{{ data.bicycle.color }}`),
it does not support more complex JSON Path expressions (e.g. array filter expressions like `$.books[?(@.price < 10)].title`).
The `json` filter provides further flexibility for evaluating complex JSON Path expressions.

### Parameters

| Position | Name                 | Type     | Required | Description            |
|----------|----------------------|----------|----------|------------------------|
| 0        | json_path_expression | *string* | true     | A JSON Path expression |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": { 
    "books": [
      { 
        "category": "fiction",
        "author": "Herman Melville",
        "title": "Moby Dick",
        "isbn": "0-553-21311-3",
        "price": 8.99
      },
      { 
        "category": "fantasy",
        "author": "J. R. R. Tolkien",
        "title": "The Lord of the Rings",
        "isbn": "0-395-19395-8",
        "price": 22.99
      }
    ],
    "bicycle": {
      "color": "red",
      "price": 19.95
    }
  }
}
```

| Expression                                                            | Result                             |
|-----------------------------------------------------------------------|------------------------------------|
| <code>{{ data.bicycle.color }}</code>                                 | "red"                              |
| <code>{{ data &#124; json: '$.bicycle.color' }}</code>                | "red"                              |
| <code>{{ data.bicycle }}</code>                                       | { "color": "red", "price": 19.95 } |
| <code>{{ data &#124; json: '$.books[0].author' }}</code>              | "Herman Melville"                  |
| <code>{{ data &#124; json: '$.books[?(@.price < 10)].title' }}</code> | "Moby Dick"                        |
| <code>{{ data.nonexistent }}</code>                                   | `null`                             |
| <code>{{ data &#124; json: '$.book..author' }}</code>                 | <400 Error>                        |


## last4

Returns the last 4 characters of a string. If the string's length is less than 4, the whole value is returned.

### Parameters

None

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "36227206271667"
}
```

| Expression                                               | Result |
|----------------------------------------------------------|--------|
| <code>{{ data &#124; last4 }}</code>                     | "1667" |
| <code>{{ data &#124; slice: 12, 2 &#124; last4 }}</code> | "67"   |

## reveal

Returns a masked version of the string revealing characters at the start and end whilst preserving others. If the string's
length is less than or equal to `reveal_first` + `reveal_last`, or the resulting masked string equals the original unmasked value,
the whole value is masked.

### Parameters

| Position | Name           | Type     | Required | Default Value | Description                                     |
|----------|----------------|----------|----------|---------------|-------------------------------------------------|
| 0        | reveal_first   | *int*    | false    | `0`           | The number of characters to reveal at the start |
| 1        | reveal_last    | *int*    | false    | `0`           | The number of characters to reveal at the end   |
| 2        | mask_char      | *char*   | false    | `X`           | A masking character                             |
| 3        | preserve_chars | *string* | false    | ``            | The characters to preserve                      |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "3622-7206-2716-5567"
}
```

| Expression                                            | Result                |
|-------------------------------------------------------|-----------------------|
| <code>{{ data &#124; reveal: 6 }}</code>              | "3622-7XXXXXXXXXXXXX" |
| <code>{{ data &#124; reveal: 7, 5 }}</code>           | "3622-72XXXXXXX-5567" |
| <code>{{ data &#124; reveal: 7, 5, '#' }}</code>      | "3622-72#######-5567" |
| <code>{{ data &#124; reveal: 7, 4, '#', "-" }}</code> | "3622-72##-####-5567" |
| <code>{{ data &#124; reveal: 10, 9 }}</code>          | "XXXXXXXXXXXXXXXXXXX" |

## pad_left

Returns a new string of the desired length by padding the input string on the left with the specified `padChar`.

Returns null when provided a null input value.

### Parameters

| Position | Name     | Type   | Required | Description                                      |
|----------|----------|--------|----------|--------------------------------------------------|
| 0        | length   | *int*  | true     | The number of characters in the resulting string |
| 1        | pad_char | *char* | true     | A padding character                              |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "1234"
}
```

| Expression                                      | Result   |
|-------------------------------------------------|----------|
| <code>{{ data &#124; pad_left: 6, '0' }}</code> | "001234" |
| <code>{{ data &#124; pad_left: 6, 'X' }}</code> | "XX1234" |
| <code>{{ data &#124; pad_left: 4, '0' }}</code> | "1234"   |
| <code>{{ data &#124; pad_left: 2, '0' }}</code> | "1234"   |


## pad_right

Returns a new string of the desired length by padding the input string on the right with the specified `padChar`.

Returns null when provided a null input value.

### Parameters

| Position | Name     | Type   | Required | Description                                      |
|----------|----------|--------|----------|--------------------------------------------------|
| 0        | length   | *int*  | true     | The number of characters in the resulting string |
| 1        | pad_char | *char* | true     | A padding character                              |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "1234"
}
```

| Expression                                       | Result   |
|--------------------------------------------------|----------|
| <code>{{ data &#124; pad_right: 6, '0' }}</code> | "123400" |
| <code>{{ data &#124; pad_right: 6, 'X' }}</code> | "1234XX" |
| <code>{{ data &#124; pad_right: 4, '0' }}</code> | "1234"   |
| <code>{{ data &#124; pad_right: 2, '0' }}</code> | "1234"   |


## reveal_last

Returns the last `length` characters of a string. If the string's length is less than or equal to `length`, the whole value is returned.

### Parameters

| Position | Name      | Type   | Required | Default Value | Description                        |
|----------|-----------|--------|----------|---------------|------------------------------------|
| 0        | length    | *int*  | true     | `null`        | The number of characters to reveal |
| 1        | mask_char | *char* | false    | `X`           | A masking character                |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "36227206271667"
}
```

| Expression                                               | Result                    |
|----------------------------------------------------------|---------------------------|
| <code>{{ data &#124; reveal_last: 6 }}</code>            | "XXXXXXXX271667"          |
| <code>{{ data &#124; reveal_last: 3, '#' }}</code>       | "###########667"          |


## stringify

Returns a JSON serialized string of the input object.

Returns null when provided a null input value.

### Parameters

None

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": { 
    "books": [
      { 
        "category": "fiction",
        "author": "Herman Melville",
        "title": "Moby Dick",
        "isbn": "0-553-21311-3",
        "price": 8.99
      },
      { 
        "category": "fantasy",
        "author": "J. R. R. Tolkien",
        "title": "The Lord of the Rings",
        "isbn": "0-395-19395-8",
        "price": 22.99
      }
    ],
    "bicycles": [{
      "color": "red",
      "price": 19.95
    }, {
      "color": "blue",
      "price": 24.95
    }]
  }
}
```

| Expression                                              | Result                                                                       |
|---------------------------------------------------------|------------------------------------------------------------------------------|
| <code>{{ data.books[0].price &#124; stringify }}</code> | "8.99"                                                                       |
| <code>{{ data.books[1].title &#124; stringify }}</code> | "The Lord of the Rings"                                                      |
| <code>{{ data.bicycles[1] &#124; stringify }}</code>    | "{\"color\":\"red\",\"price\":19.95}"                                        |
| <code>{{ data.bicycles &#124; stringify }}</code>       | "[{\"color\":\"red\",\"price\":19.95},{\"color\":\"blue\",\"price\":24.95}]" |

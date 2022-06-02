# Language

The expression language used within the Basis Theory API is based on the [Liquid template language](https://shopify.github.io/liquid).
While all valid Liquid syntax is supported, Basis Theory expressions are typically formed from a combination of 
[objects](#language-objects) and [filters](#filters).

## Objects

[Objects](https://shopify.github.io/liquid/basics/introduction/#objects) contain content that will be
rendered when the expression is evaluated, and they are formed by wrapping a statement within double curly braces. For example,
`{{ data.card_number }}` would be evaluated by rendering the `card_number` property within the `data` object.

The variables that are available for reference within an object expression depends on the context in which the expression is used.
When including expressions during token creation (e.g. within `search_indexes` or `fingerprint_expression`), 
the `data` variable is automatically bound to the token's `data` value.

When including expressions within Reactor or Proxy requests, token ids may be specified within object expressions, 
and each token id will be bound to the corresponding token's data value. 
See [detokenization](#detokenization) for further details about this process. 

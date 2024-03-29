# Introduction
<aside class="header-intro-box">
    <span>
        <h4>Expressions</h4>
        <p class="header-intro-body2-font">
          Explore the expression language used throughout the Basis Theory API.
        </p>
        <h6>QUICK LINKS</h6>
        <span class="intro-quick-links">
            <a href="#language">Language</a>
            <a href="#filters">Filters</a>
            <a href="#detokenization">Detokenization</a>
            <a href="#aliasing">Aliasing</a>
            <a href="#fingerprints">Fingerprints</a>
            <a href="#masks">Masks</a>
            <a href="#search-indexes">Search Indexes</a>
        </span>
    </span>
    <img src="/images/expressions-intro.svg"/>
</aside>

Expressions provide a flexible templating language that can be used to apply custom transformations to token data.

Expressions can be used within many API endpoints, including:

- [Reactor](https://developers.basistheory.com/concepts/what-are-reactors) args, to [detokenize](#detokenization) and transform tokens
- [Proxy](https://developers.basistheory.com/concepts/what-is-the-proxy) requests, to [detokenize](#detokenization) and transform tokens
- [Aliasing](#aliasing) when [creating a token](/api-reference/#tokens-create-token) or [tokenizing](/api-reference/#tokenize), to specify the id of the created token 
- [fingerprint_expression](#fingerprints) when [creating a token](/api-reference/#tokens-create-token) or [tokenizing](/api-reference/#tokenize), to define a value used to generate a token fingerprint
- [mask](#masks) when [creating a token](/api-reference/#tokens-create-token) or [tokenizing](/api-reference/#tokenize), to define the mask applied to the token's data when the actor has restricted permissions
- [search_indexes](#search-indexes) when [creating a token](/api-reference/#tokens-create-token) or [tokenizing](/api-reference/#tokenize), to define indexes to enable [searching tokens](/api-reference/#tokens-search-tokens)

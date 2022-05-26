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
            <a href="#search-indexes">Search Indexes</a>
            <a href="#fingerprints">Fingerprints</a>
        </span>
    </span>
    <img src="/images/expressions-intro.svg"/>
</aside>

Expressions provide a flexible templating language that can be used to apply custom transformations to token data.

Expressions can be used within many API endpoints, including:

- [Reactor](/#reactors) args, to detokenize and transform tokens
- [Proxy](/#proxy) requests, to detokenize and transform tokens
- `search_indexes` when [creating a token](#tokens-create-token) or [tokenizing](#tokenize), to define indexes to enable [searching tokens](#tokens-search-tokens)
- `fingerprint_expression` when [creating a token](#tokens-create-token) or [tokenizing](#tokenize), to define a value used to generate a token fingerprint

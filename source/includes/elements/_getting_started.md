# Getting started
## Before You Begin
### If you don't have an account

To begin taking advantage of the Basis Theory platform, you’ll need to create an account and Tenant through our <a href="https://portal.basistheory.com/register" target="_blank">Portal</a>.

### If you have an account

Check out our API Reference documentation below, or go to our Getting Started section if you’re unsure of where to go next.

## Install SDK

> NPM

```shell
npm install --save @basis-theory/basis-theory-js
```

> Yarn

```shell
yarn add @basis-theory/basis-theory-js
```

> CDN

```jsx
<!-- Including this tag will export a global/window "BasisTheory" variable -->
<script src="https://js.basistheory.com"></script> 
```

You don't have to install **Elements** as a separate module or include additional script tags besides **BasisTheory.js**. It will dynamically load them from our secure domain, which enables us to keep the highest compliance standards (e.g. PCI compliance).

To install **BasisTheory.js** you can choose either our NPM module or CDN hosted bundle through a `script` tag.

## Content Security Policy

> CSP

```jsx
<head>
  <meta
    http-equiv="Content-Security-Policy"
    content="frame-src https://elements.basistheory.com; script-src https://js.basistheory.com"
  />
</head>

```

> Trusted Types

```jsx

trustedTypes.createPolicy("default", {
  createScriptURL: (input) => {
    if (new URL(input).origin === "https://js.basistheory.com") {
      return input;
    }
    return undefined;
  }
});
```

If you have a <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP" target="_blank">CSP</a> deployed in your website, you must include the following directives:

- `script-src` - _https://js.basistheory.com_
- `frame-src` - _https://elements.basistheory.com_ 


If you are using <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/require-trusted-types-for" target="_blank">Trusted Types</a>, you must allow dynamic script loading from the _https://js.basistheory.com_ origin. This should be done **BEFORE** [initialization](#initialize).

### Common CSP Errors

The setup above is recommended to avoid errors similar to these:

<aside class="warning">
  <span><em>Refused to load the script '&lt;URL&gt;' because it violates the following Content Security Policy directive: (...).</em></span>
</aside>

<aside class="warning">
  <span><em>Refused to frame 'https://elements.basistheory.com/' because it violates the following Content Security Policy directive: (...). Note that 'frame-src' was not explicitly set, so (...) is used as a fallback.</em></span>
</aside>

<aside class="warning">
  <span><em>Failed to set the 'src' property on 'HTMLScriptElement': This document requires 'TrustedScriptURL' assignment.</em></span>
</aside>

## Usage with TypeScript

Starting at `1.14.0`, [BasisTheory.js](https://www.npmjs.com/package/@basis-theory/basis-theory-js) bundles all TypeScript definitions for Elements features. You don't have to take any extra steps in order to use it.

If you can't upgrade past `1.13.1`, [Basis Theory Elements](https://www.npmjs.com/package/@basis-theory/basis-theory-elements) offers unmaintained definitions for deprecated Elements features.

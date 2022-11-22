# Introduction
<aside class="header-intro-box">
    <span>
        <h4>Elements</h4>
        <p class="header-intro-body2-font">Explore how to securely collect or reveal sensitive data within your applications.</p>
        <h6>QUICK LINKS</h6>
        <span class="intro-quick-links">
            <a href="#getting-started">Before You Begin</a>
            <a href="#element-options-style">Styling Elements</a>
            <a href="#element-types-card-element">Create an Element</a>
            <a href="#store-credit-card">Store Credit Card</a>
        </span>
    </span>
    <img src="/images/elements_intro.svg"/>
</aside>

**Basis Theory Elements** are secure inputs that empower developers to easily collect or reveal sensitive data within 
web or mobile applications. 

Think about it as an isolated sandbox within your frontend application that your end users are able to seamlessly 
interact with, and which securely communicates with the Basis Theory Vault. Sensitive data is not directly exposed to
your application code, which keeps your frontend systems out of compliance scope.

Here's how we make this possible:

- Integrate our web and mobile SDKs into your frontend applications
- Build forms using our **Element** input components
- Interact with the Basis Theory API using **Element** references, not plaintext data
- Own your UI/UX by fully customizing how **Elements** are styled

**Collect Sensitive Data**

Data entered by your end users into **Elements** is tokenized and secured within Basis Theory's certified Vault.

Our SDKs provide several types of inputs to collect various types of data, such as the [CardElement](/elements#cardelement)
for collecting credit card data and [TextElement](/elements#textelement) for collecting arbitrary textual data.

Elements can be configured to support custom input masking, validation, and transformation rules to satisfy your use cases.

**Reveal Sensitive Data**

Tokens stored within the Basis Theory Vault can be securely revealed to end users without accessing the plaintext
data directly within your application code.

Using one of our SDKs, sensitive data can be securely retrieved and applied to one or more Elements within your UI.
See the section below on [detokenization](/elements#detokenization) for more information.

<aside class="notice">
  <span>
    Revealing sensitive data is only currently supported within the JavaScript and React SDKs. We are working to fully 
    support this functionality within our native <a href="#android">Android</a> and <a href="#ios">iOS</a> SDKs. Interested?
    Please email us at <a href="mailto:info@basistheory.com?subject=Mobile Elements SDK - Reveal">info@basistheory.com</a> 
    to join our early access program.
  </span>
</aside>

**SDKs**

Our SDKs provide UI components and services that enable your app to
securely [tokenize](/elements#tokenization) and [detokenize](/elements#detokenization) sensitive data without needing
to interact directly with the plaintext data.

The following SDKs are available to integrate into your web or mobile applications to collect or reveal sensitive data,
while keeping your app out of compliance scope:

- [JavaScript](https://github.com/Basis-Theory/basis-theory-js/)
- [React](https://github.com/Basis-Theory/basis-theory-react/)
- [Android](https://github.com/Basis-Theory/basistheory-android/)
- [iOS](https://github.com/Basis-Theory/basistheory-ios/)

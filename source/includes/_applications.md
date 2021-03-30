# Applications

Your ability to authenticate to the API is granted by creating Applications, each application type has differnet usages to create the most fine-grained control over your tokens and infrastructure possible. Below, we describe each application type and their usages.  


## Server to Server

A `server-to-server` application is intended to be used with your backend services where you can keep and protect the `api key` to the fullest level of security. You are able to grant any tokenization scope to a `server-to-server` application, which will enable you the finest grain control over your token data.

## Client-side

A `client-side` application is intended to be used when you need to tokenize or display tokenized data directly from your mobile or browser application. Keep in mind, these api token swill be exposed to the world and you'll want to limit their access to only what you'll need.   

## Hosted Elements

A `hosted elements` application will be used to publish a hosted collection form on your website, enabling you to collect senstiive data (e.g. Credit Cards) without taking on the full compliance required to handle the data directly. This application will only have the ability to create tokens, and can be locked down further with origin policies and other advanced security features.  

## Management 

<aside class="notice">
Coming Soon!
</aside>

A `management` application can be used to fully manage your token infrastructure. You'll be able to use our apis (and terraform modules eventually) to full manage and configure how you expect your system to interact and work. Anything from create new applications to configuring the token exchanges you wish to connect to, you'll be able to do it all as code and be confident in your configuration between your environments.

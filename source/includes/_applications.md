# Applications

Your ability to authenticate to the API is granted by creating Applications, which contain both a Public key and a Private key. You will use these keys to [Authenticate](#authentication) to the Basis Theory API. 

Each endpoint will denote which key you should use with [`private key`](#private-key) or [`public key`](#public-key).

## Public Key
This `public key` has a limited scope of access, which will only allow the consumer the ability to create Tokens or Payments, yet not have access to retrieve this information. 

These keys are perfect for using with your frontend web application (or mobile application), and pair perfectly with our Javascript Modules and Hosted Fields.

## Private Key
The `private key` to be used by your backend application, giving it authorization to a greater scope of access. You will be able to use these keys to take additional actions within our API. 

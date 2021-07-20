# Permissions

Permissions are fine-grained control over your application's access to different aspects of your token infrastructure. We suggest limiting the scope of your application to the least amount possible, and to not share them across your internal applications.

Permissions are associated with every application and can be configured when you [create an application](#create-application) or [update an application](#update-application). 

Elements only allows _create_ permissions, removing any risk that your API keys are stolen and used to access data.

<aside class="notice">
  <span>Dependent permission types are automatically assigned when an application is created or updated. For example, if an application is created with <code>card:read</code>, then the permission of <code>token:read</code> will automatically be assigned.</span>
</aside>

## Permission Types

Permission | Description | Application Types | Dependencies
---------  | ----------- | ----------------- | ------------
`token:create` | Create tokens in the vault | `elements` | *N/A*
`card:create` | Create atomic card tokens | `elements` | `token:create`
`bank:create` | Create atomic bank tokens | `elements` | `token:create`

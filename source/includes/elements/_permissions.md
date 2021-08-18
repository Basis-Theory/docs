# Permissions

Permissions offer fine-grained control over your application's access to different aspects of your token infrastructure. We suggest limiting the scope of your application to the least amount possible, and to not share them across your internal applications.

Permissions are associated with every application and can be configured when you [create an application](/api-reference#create-application) or [update an application](/api-reference#update-application). 

**Elements** applications only allows _create_ permissions, removing any risk that your API keys are stolen and used to access data.

<aside class="notice">
  <span>Dependent permission types are automatically assigned when an application is created or updated. For example, if an application is created with <code>card:create</code>, then the permission of <code>token:create</code> will automatically be assigned.</span>
</aside>

## Permission Types

Permission | Description | Dependencies
---------  | ----------- | ------------
`token:create` | Create tokens in the vault | *N/A*
`card:create` | Create atomic card tokens | `token:create`
`bank:create` | Create atomic bank tokens | `token:create`

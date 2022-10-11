# Permissions

Permissions offer fine-grained control over your Application's access to different resources within your Tenant. 
We suggest limiting the scope of your Application to the least amount possible, and to not share them across your internal services.

Permissions are associated with every Application and can be configured when you [create an Application](/api-reference#applications-create-application) 
or [update an Application](/api-reference#applications-update-application). 

Elements require the use of an API Key associated with a **Public** Application, which only allows the use of
`token:create` and `token:update` permissions, removing any risk that your API keys are stolen and used to access data.

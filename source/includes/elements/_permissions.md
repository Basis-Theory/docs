# Permissions

Permissions offer fine-grained control over your Application's access to different aspects of your token infrastructure. We suggest limiting the scope of your Application to the least amount possible, and to not share them across your internal services.

Permissions are associated with every Application and can be configured when you [create an Application](/api-reference#applications-create-application) or [update an Application](/api-reference#applications-update-application). 

**Elements** Applications only allow _create_ permissions, removing any risk that your API keys are stolen and used to access data.

## Permission Types

| Permission             | Description                |
|------------------------|----------------------------|
| `token:general:create` | Create tokens in the vault |
| `token:pci:create`     | Create Atomic Card tokens  |
| `token:bank:create`    | Create Atomic Bank tokens  |

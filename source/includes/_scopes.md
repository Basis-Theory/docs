# Scopes

Scopes are fine-grained control over your application's access to different aspects of your token infrastructure. We suggest limiting the scope of your application to the least amount possible, and to not share them across your internal applications.

## Vault

- `vault:write` - allows you to create a token
- `vault:read` - allows you to read a token
- `vault:update` - allows you to update an existing token
- `vault:delete` - allows you to delete existing token

## Atomic Cards

- `card:write` - allows you to create new atomic cards 
- `card:read` - allows you to read non-pci (masked) data from your atomic cards 
- `card:update` - allows you to update an existing atomic card
- `card:delete` - allows you to delete existing atomic cards

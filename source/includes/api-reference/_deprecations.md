# Deprecations

## Deprecated Endpoints

The following table lists deprecated API endpoints and their respective shutdown date.

| Endpoint                     | HTTP Method(s) | Deprecated      | Shutdown Date | Details                                                                                                                                                                                                                                  |
|------------------------------|----------------|-----------------|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/tokens/decrypt`            | `GET`          | January 3, 2022 | TBD           | `GET /tokens/decrypt` endpoint will be removed in an upcoming release. Token data will now be returned based on the requester's read access. For more information, see [List Tokens](#tokens-list-tokens).                               | 
| `/tokens/{id}/decrypt`       | `GET`          | January 3, 2022 | TBD           | `GET /tokens/{id}/decrypt` endpoint will be removed in an upcoming release. Token data will now be returned based on the requester's read access. For more information, see [Get a Token](#tokens-get-a-token).                          | 
| `/atomic/banks/{id}/decrypt` | `GET`          | January 3, 2022 | TBD           | `GET /atomic/banks/{id}/decrypt` endpoint will be removed in an upcoming release. Bank data will now be returned based on the requester's read access. For more information, see [Get an Atomic Bank](#atomic-banks-get-an-atomic-bank). | 


## Deprecated Features

The following table lists deprecated features and their respective shutdown date.

| Feature                                      | Deprecated      | Shutdown Date   | Details                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|----------------------------------------------|-----------------|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `token:*`, `bank:*` and `card:*` permissions | January 3, 2022 | January 3, 2022 | The following permissions have been removed as of January 3, 2022 (see table for removed permissions and their replacement). New token permissions provide more granular access control based on [Data Classification](#tokens-token-classifications) and [Impact Level](#tokens-token-impact-levels). For more information, see [Token Permissions](#permissions-permission-types-token-permissions). <table><thead><tr><th>Legacy Permission</th><th>Migrated To</th></tr></thead><tbody><tr><td>`token:create`</td><td>`token:general:create`</td></tr><tr><td>`token:read`</td><td>`token:general:read:low`</td></tr><tr><td>`token:decrypt`</td><td>`token:general:read:high`</td></tr><tr><td>`token:update`</td><td>`token:general:update`</td></tr><tr><td>`token:delete`</td><td>`token:general:delete`</td></tr><tr><td>`token:use`</td><td>`token:general:use:proxy`</td></tr><tr><td>`bank:create`</td><td>`token:bank:create`</td></tr><tr><td>`bank:read`</td><td>`token:bank:read:low`</td></tr><tr><td>`bank:decrypt`</td><td>`token:bank:read:high`</td></tr><tr><td>`bank:update`</td><td>`token:bank:update`</td></tr><tr><td>`bank:delete`</td><td>`token:bank:delete`</td></tr><tr><td>`bank:use`</td><td>`token:bank:use:proxy`</td></tr><tr><td>`card:create`</td><td>`token:pci:create`</td></tr><tr><td>`card:read`</td><td>`token:pci:read:low`</td></tr><tr><td>`card:update`</td><td>`token:pci:update`</td></tr><tr><td>`card:delete`</td><td>`token:pci:delete`</td></tr><tr><td>`card:use`</td><td>`token:pci:use:proxy`</td></tr></tbody></table> |
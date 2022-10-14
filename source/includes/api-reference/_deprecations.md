# Deprecations

## Deprecated Endpoints

The following table lists deprecated API endpoints and their respective shutdown date.

| Endpoint                     | HTTP Method(s) | Deprecated      | Shutdown Date  | Details                                                                                                                                                                                                                                  |
|------------------------------|----------------|-----------------|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/atomic/banks/{id}/react`   | `POST`         | March 17, 2022  | June 17, 2022  | `POST /atomic/banks/{id}/react` endpoint will be removed in an upcoming release. Instead, please use [Invoke a Reactor](#reactors-invoke-a-reactor).                                                                                     | 
| `/atomic/cards/{id}/react`   | `POST`         | March 17, 2022  | June 17, 2022  | `POST /atomic/cards/{id}/react` endpoint will be removed in an upcoming release. Instead, please use [Invoke a Reactor](#reactors-invoke-a-reactor).                                                                                     | 
| `/tokens/decrypt`            | `GET`          | January 3, 2022 | April 15, 2022 | `GET /tokens/decrypt` endpoint will be removed in an upcoming release. Token data will now be returned based on the requester's read access. For more information, see [List Tokens](#tokens-list-tokens).                               | 
| `/tokens/{id}/decrypt`       | `GET`          | January 3, 2022 | April 15, 2022 | `GET /tokens/{id}/decrypt` endpoint will be removed in an upcoming release. Token data will now be returned based on the requester's read access. For more information, see [Get a Token](#tokens-get-a-token).                          | 
| `/atomic/banks/{id}/decrypt` | `GET`          | January 3, 2022 | April 15, 2022 | `GET /atomic/banks/{id}/decrypt` endpoint will be removed in an upcoming release. Bank data will now be returned based on the requester's read access. For more information, see [Get an Atomic Bank](#atomic-banks-get-an-atomic-bank). | 
| `/atomic/banks`              | `GET`          | April 3, 2022   | July 8, 2022   | `GET /atomic/banks` endpoint will be removed in an upcoming release. Instead, please use [List Tokens](#tokens-list-tokens).                                                                                                             |
| `/atomic/banks`              | `POST`         | April 3, 2022   | July 8, 2022   | `POST /atomic/banks` endpoint will be removed in an upcoming release. Instead, please use [Create Tokens](#tokens-create-token).                                                                                                         |
| `/atomic/banks/{id}`         | `GET`          | April 3, 2022   | July 8, 2022   | `GET /atomic/banks/{id}` endpoint will be removed in an upcoming release. Instead, please use [Get a Token](#tokens-get-a-token).                                                                                                        |
| `/atomic/banks/{id}`         | `PATCH`        | April 3, 2022   | July 8, 2022   | `PATCH /atomic/banks/{id}` endpoint will be removed in an upcoming release.                                                                                                                                                              |
| `/atomic/banks/{id}`         | `DELETE`       | April 3, 2022   | July 8, 2022   | `DELETE /atomic/banks/{id}` endpoint will be removed in an upcoming release. Instead, please use [Delete Token](#tokens-delete-token).                                                                                                   |
| `/atomic/cards`              | `GET`          | April 3, 2022   | July 8, 2022   | `GET /atomic/cards` endpoint will be removed in an upcoming release. Instead, please use [List Tokens](#tokens-list-tokens).                                                                                                             |
| `/atomic/cards`              | `POST`         | April 3, 2022   | July 8, 2022   | `POST /atomic/cards` endpoint will be removed in an upcoming release. Instead, please use [Create Tokens](#tokens-create-token).                                                                                                         |
| `/atomic/cards/{id}`         | `GET`          | April 3, 2022   | July 8, 2022   | `GET /atomic/cards/{id}` endpoint will be removed in an upcoming release. Instead, please use [Get a Token](#tokens-get-a-token).                                                                                                        |
| `/atomic/cards/{id}`         | `PATCH`        | April 3, 2022   | July 8, 2022   | `PATCH /atomic/cards/{id}` endpoint will be removed in an upcoming release.                                                                                                                                                              |
| `/atomic/cards/{id}`         | `DELETE`       | April 3, 2022   | July 8, 2022   | `DELETE /atomic/cards/{id}` endpoint will be removed in an upcoming release. Instead, please use [Delete Token](#tokens-delete-token).                                                                                                   |


## Deprecated Features

The following table lists deprecated features and their respective shutdown dates.

| Feature                                           | Deprecated Date  | Shutdown Date    | Details                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|---------------------------------------------------|------------------|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Token Privacy Settings                            | October 13, 2022 | February 1, 2023 | Privacy settings (i.e. classification, impact level, and restriction policy) have been deprecated and replaced by a more flexible authorization model based upon [Containers](https://developers.basistheory.com/concepts/what-are-token-containers) and [Access Rules](https://developers.basistheory.com/concepts/access-controls/#what-are-access-rules). For more information, see the section below on [Migrating from Privacy Settings](/#deprecations-migrating-from-privacy-settings). |
| `token:<classification>:*` permissions            | October 13, 2022 | October 13, 2022 | Classification and impact level based permissions have been migrated to [Access Rules](https://developers.basistheory.com/concepts/access-controls/#what-are-access-rules) to provide a more flexible model for scoping access to a subset of Tokens via [Containers](https://developers.basistheory.com/concepts/what-are-token-containers). For more information, see the [table below](/#deprecations-migrating-permissions-to-access-rules).                                               |
| `source_token_type` removed from Reactor Formulas | March 17, 2022   | March 17, 2022   | In order to support the creation of more flexible reactors that accept more than one token argument, Reactor Formulas no longer have a single `source_token_type` and this property has been removed.                                                                                                                                                                                                                                                                                          |
| `X-API-KEY` has been replaced with `BT-API-KEY`   | January 9, 2022  | March 9, 2022    | In order to prevent potential conflicts with the `X-API-KEY` header while using the [Proxy](#proxy) feature, the authentication header for the Basis Theory API has been replaced with `BT-API-KEY`.                                                                                                                                                                                                                                                                                           |

## Migrating From Privacy Settings

Privacy settings were previously used to scope access to Tokens based on their data classification and impact levels. 
In order to provide a more flexible access control model that can be customized per Application, we have introduced 
Token [Containers](https://developers.basistheory.com/concepts/what-are-token-containers) 
to logically group Tokens according to any data governance requirements. A Token may be explicitly added to a container
when creating the Token, or if unspecified, a Token will be placed within the container `/<classification>/<impact_level>/` 
by default. If you were previously customizing a Token's classification or impact level, please update your systems to 
directly set the `containers` attribute instead.

Restriction policies were previously used in conjunction with impact level based read 
permissions (e.g. `token:general:read:low`) to define how Token data should be transformed when reading Tokens with 
a higher impact level than your permission allows. This model proved to be too inflexible as it was a global setting
applied at the Token level and could not be customized per actor. Restriction policies no longer have any functional 
impact, and were replaced by transforms applied via [Access Rules](https://developers.basistheory.com/concepts/access-controls/#what-are-access-rules).  

If your systems are using the `privacy` attribute of the [Token Object](#tokens-token-object) in API responses, please
update your integration to ignore this attribute as it will be removed on February 1, 2023.

If you were previously using classification-based Token permissions (e.g. `token:general:create`), your permissions
have automatically been migrated to equivalent [Access Rules](https://developers.basistheory.com/concepts/access-controls/#what-are-access-rules).
Refer to [Migrating Permissions to Access Rules](/#deprecations-migrating-permissions-to-access-rules) below for further details.

## Migrating Permissions to Access Rules

Permissions on existing Applications have been automatically migrated to equivalent [Access Rules](https://developers.basistheory.com/concepts/access-controls/#what-are-access-rules),
and no action is required. The table below details how each permission was migrated, with each row representing 
an Access Rule (i.e. Container, Transform, Permissions). If your authorization requirements have changed, new 
rules can be added, or existing rules can be removed or customized through the Portal or the API.

| Legacy Permission             | Container            | Transform | Permission(s)               |
|-------------------------------|----------------------|-----------|-----------------------------|
| `token:general:create`        | `/general/`          | `mask`    | `token:create`              |
| `token:general:update`        | `/general/`          | `mask`    | `token:update`              |
| `token:general:read:low`      | `/general/low/`      | `reveal`  | `token:read` `token:search` |
|                               | `/general/`          | `mask`    | `token:read`                |
| `token:general:read:moderate` | `/general/low/`      | `reveal`  | `token:read` `token:search` |
|                               | `/general/moderate/` | `reveal`  | `token:read` `token:search` |
|                               | `/general/high/`     | `mask`    | `token:read`                |
| `token:general:read:high`     | `/general/`          | `reveal`  | `token:read` `token:search` |
| `token:general:delete`        | `/general/`          | `mask`    | `token:delete`              |
| `token:general:use:proxy`     | `/general/`          | `reveal`  | `token:use`                 |
| `token:general:use:reactor`   | `/general/`          | `reveal`  | `token:use`                 |
| `token:bank:create`           | `/bank/`             | `mask`    | `token:create`              |
| `token:bank:update`           | `/bank/`             | `mask`    | `token:update`              |
| `token:bank:read:low`         | `/bank/low/`         | `reveal`  | `token:read` `token:search` |
|                               | `/bank/`             | `mask`    | `token:read`                |
| `token:bank:read:moderate`    | `/bank/low/`         | `reveal`  | `token:read` `token:search` |
|                               | `/bank/moderate/`    | `reveal`  | `token:read` `token:search` |
|                               | `/bank/high/`        | `mask`    | `token:read`                |
| `token:bank:read:high`        | `/bank/`             | `reveal`  | `token:read` `token:search` |
| `token:bank:delete`           | `/bank/`             | `mask`    | `token:delete`              |
| `token:bank:use:proxy`        | `/bank/`             | `reveal`  | `token:use`                 |
| `token:bank:use:reactor`      | `/bank/`             | `reveal`  | `token:use`                 |
| `token:pci:create`            | `/pci/`              | `mask`    | `token:create`              |
| `token:pci:update`            | `/pci/`              | `mask`    | `token:update`              |
| `token:pci:read:low`          | `/pci/low/`          | `reveal`  | `token:read` `token:search` |
|                               | `/pci/`              | `mask`    | `token:read`                |
| `token:pci:read:moderate`     | `/pci/low/`          | `reveal`  | `token:read` `token:search` |
|                               | `/pci/moderate/`     | `reveal`  | `token:read` `token:search` |
|                               | `/pci/high/`         | `mask`    | `token:read`                |
| `token:pci:read:high`         | `/pci/`              | `reveal`  | `token:read` `token:search` |
| `token:pci:delete`            | `/pci/`              | `mask`    | `token:delete`              |
| `token:pci:use:proxy`         | `/pci/`              | `reveal`  | `token:use`                 |
| `token:pci:use:reactor`       | `/pci/`              | `reveal`  | `token:use`                 |
| `token:pii:create`            | `/pii/`              | `mask`    | `token:create`              |
| `token:pii:update`            | `/pii/`              | `mask`    | `token:update`              |
| `token:pii:read:low`          | `/pii/low/`          | `reveal`  | `token:read` `token:search` |
|                               | `/pii/`              | `mask`    | `token:read`                |
| `token:pii:read:moderate`     | `/pii/low/`          | `reveal`  | `token:read` `token:search` |
|                               | `/pii/moderate/`     | `reveal`  | `token:read` `token:search` |
|                               | `/pii/high/`         | `mask`    | `token:read`                |
| `token:pii:read:high`         | `/pii/`              | `reveal`  | `token:read` `token:search` |
| `token:pii:delete`            | `/pii/`              | `mask`    | `token:delete`              |
| `token:pii:use:proxy`         | `/pii/`              | `reveal`  | `token:use`                 |
| `token:pii:use:reactor`       | `/pii/`              | `reveal`  | `token:use`                 |

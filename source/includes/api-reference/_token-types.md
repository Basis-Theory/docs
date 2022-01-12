# Token Types

Basis Theory offers several pre-configured token types for various use-cases and compliance requirements.
Token Types define the rules around a data type such as validation requirements, data classification and data impact level.

- [Token](#token-types-token)
- [Atomic Card](#token-types-atomic-card)
- [Atomic Bank](#token-types-atomic-bank)
- [Card Number](#token-types-card-number)
- [US Bank Account Number](#token-types-us-bank-account-number)
- [US Bank Routing Number](#token-types-us-bank-routing-number)
- [Social Security Number](#token-types-social-security-number)

## Token

The `token` type is used for general data types that don't require input validation or formatting restrictions.

| Token Attribute                | Value     |
|--------------------------------|-----------|
| **Type**                       | `token`   |
| **Default Classification**     | `general` |
| **Default Impact Level**       | `high`    |
| **Minimum Impact Level**       | `low`     |
| **Default Restriction Policy** | `redact`  |
| **Input Validation**           | None      |
| **Input Length**               | Any       |
| **Fingerprinted**              | No        |


## Atomic Card

| Token Attribute                | Value                                                                    |
|--------------------------------|--------------------------------------------------------------------------|
| **Type**                       | `card`                                                                   |
| **Default Classification**     | `pci`                                                                    |
| **Default Impact Level**       | `high`                                                                   |
| **Minimum Impact Level**       | `high`                                                                   |
| **Default Restriction Policy** | `mask`                                                                   |
| **Input Validation**           | See [Card Object](#atomic-cards-card-object) for validation requirements |
| **Fingerprinted**              | Yes                                                                      |


## Atomic Bank

| Token Attribute                | Value                                                                                 |
|--------------------------------|---------------------------------------------------------------------------------------|
| **Type**                       | `bank`                                                                                |
| **Default Classification**     | `bank`                                                                                |
| **Default Impact Level**       | `high`                                                                                |
| **Minimum Impact Level**       | `high`                                                                                |
| **Default Restriction Policy** | `mask`                                                                                |
| **Input Validation**           | See [Bank Object](#atomic-banks-bank-object) for validation requirements              |
| **Fingerprinted**              | Yes                                                                                   |


## Card Number

| Token Attribute                | Value               |
|--------------------------------|---------------------|
| **Type**                       | `card_number`       |
| **Default Classification**     | `pci`               |
| **Default Impact Level**       | `high`              |
| **Minimum Impact Level**       | `high`              |
| **Default Restriction Policy** | `mask`              |
| **Input Validation**           | Luhn-valid, numeric |
| **Input Length**               | 13 - 19             |
| **Fingerprinted**              | Yes                 |

Examples:

| Input Data       | Masked Value     |
|------------------|------------------|
| 4242424242424242 | XXXXXXXXXXXX4242 |
| 36227206271667   | XXXXXXXXXX1667   |


## US Bank Account Number

| Token Attribute                | Value                    |
|--------------------------------|--------------------------|
| **Type**                       | `us_bank_account_number` |
| **Default Classification**     | `bank`                   |
| **Default Impact Level**       | `high`                   |
| **Minimum Impact Level**       | `high`                   |
| **Default Restriction Policy** | `mask`                   |
| **Input Validation**           | Numeric                  |
| **Input Length**               | 3 - 17                   |
| **Fingerprinted**              | Yes                      |

Examples: 

| Input Data          | Masked Value        |
|---------------------|---------------------|
| 1234567890          | XXXXXX7890          |


## US Bank Routing Number

| Token Attribute                | Value                        |
|--------------------------------|------------------------------|
| **Type**                       | `us_bank_routing_number`     |
| **Default Classification**     | `bank`                       |
| **Default Impact Level**       | `low`                        |
| **Minimum Impact Level**       | `low`                        |
| **Default Restriction Policy** | `redact`                     |
| **Input Validation**           | Numeric, ABA-valid           |
| **Input Length**               | 9                            |
| **Fingerprinted**              | Yes                          |


## Social Security Number

| Token Attribute                | Value                                    |
|--------------------------------|------------------------------------------|
| **Type**                       | `social_security_number`                 |
| **Default Classification**     | `pii`                                    |
| **Default Impact Level**       | `high`                                   |
| **Minimum Impact Level**       | `high`                                   |
| **Default Restriction Policy** | `mask`                                   |
| **Input Validation**           | Numeric with optional delimiter of `"-"` |
| **Input Length**               | 9 or 11 with delimiter                   |
| **Fingerprinted**              | Yes                                      |

Examples:

| Input Data  | Masked Value |
|-------------|--------------|
| 123456789   | XXXXX6789    |
| 123-45-6789 | XXX-XX-6789  |

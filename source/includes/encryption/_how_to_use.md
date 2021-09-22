# How to use
## Encryption / Decryption

```javascript
import { v4 as uuid } from 'uuid';
import { BasisTheoryEncryption } from '@basis-theory/basis-theory-js-encryption';

// Given provider(s) will register it's factories for the encryption service.
const btEncryption = await new BasisTheoryEncryption().init(new EncryptionProvider());

// Provider Key which was generated from the ProviderKeyService
let providerEncryptionKey: ProviderEncryptionKey = {
  keyId: uuid(),
  providerKeyId: 'https://custom-kms.vault.azure.net/keys/encryption-key/809b10a3cedb83e83bbaeb5e8c762fab',
  algorithm: 'RSA',
  provider: 'AZURE'
};

// Encrypt string to get back a wrapped encryptedData with a reference to the providerEncryptionKey
const encryptedData = await btEncryption.encryptionService.encrypt('My Super Secret', providerEncryptionKey);

// Use Encrypted Data and Provider Encryption Key to decrypt the the value and get back the original plainText
const plainText = await btEncryption.encryptionService.decrypt(encryptedData, providerEncryptionKey);
```

```csharp
using BasisTheory.net.Encryption;

// Encryption Factory which has a provider and algorithm implementation for the ProviderEncryptionKey
var rsaEncryptionFactory = new RSAKeyVaultEncryptionFactory();
var encryptionService = new EncryptionService(new List<IEncryptionFactory> { 
  rsaEncryptionFactory 
});

// Provider Encryption Key which was generated from the ProviderKeyService
var providerEncryptionKey = new ProviderEncryptionKey {
  KeyId = Guid.NewGuid().ToString(),
  ProviderKeyId = "https://custom-kms.vault.azure.net/keys/encryption-key/809b10a3cedb83e83bbaeb5e8c762fab",
  Algorithm = "RSA",
  Provider = "AZURE"
};

// Encrypt string to get back a wrapped EncryptedData with a reference to the ProvderEncryptionKey
var encryptedData = encryptionService.Encrypt("My Super Secret", providerEncryptionKey);

// Use Encrypted Data and Provider Encryption Key to decrypt the the value and get back the original plaintext
var plaintext = encryptionService.Decrypt(encryptedData, providerEncryptionKey);
```

Data can be encrypted and decrypted using the Encryption Service provided by our language specific SDKs. In either SDK, the Encryption Service requires a Provider Key in order to Encrypt/Decrypt data, which can either be constructed by you or generated using the Provider Key Service available in our SDKs.

See the sidebar for examples of how to instantiate and use the service for each language specific SDK.
More information can be found in the available [guide](https://guides.basistheory.com/guides/own-your-encryption-keys/#encrypt-your-data).

## Key Management

```javascript
import { BasisTheoryEncryption } from '@basis-theory/basis-theory-js-encryption';

// Given provider(s) will register it's factories for the provider key service
const btEncryption = await new BasisTheoryEncryption().init([new EncryptionProvider()]);

// Retrieves or creates a key by name with a registered ProviderKeyFactory for the provided provider and algorithm
let providerEncryptionKey = await btEncryption.providerKeyService.getOrCreateKey('encryption-key', 'AZURE', 'RSA');

providerEncryptionKey = await btEncryption.providerKeyService.getKeyByKeyId(providerEncryptionKey.keyId);
```

```csharp
using BasisTheory.net.Encryption;

var rsaProviderKeyFactory = new RSAKeyVaultProviderKeyFactory();

var providerKeyService = new ProviderKeyService(new CachingService(), 
  new List<IProviderKeyFactory> { 
    rsaProviderKeyFactory 
  });

// Retrieves or creates a key by name with a registered IProviderKeyFactory for the provided provider and algorithm
var providerEncryptionKey = providerKeyService.GetOrCreateKeyAsync("encryption-key", "AZURE", "RSA");

providerEncryptionKey = providerKeyService.GetKeyByKeyIdAsync(providerEncryptionKey.KeyId);
```

Key creation and management is available using the Provider Key Service available in our language specific SDKs. The service can accept multiple key management solutions (providers) which can be used interchangeably in your application.

See the sidebar for examples of how to instantiate and use the service for each language specific SDK.
More information can be found in the available [guide](https://guides.basistheory.com/guides/own-your-encryption-keys/#set-up-your-encryption-key).

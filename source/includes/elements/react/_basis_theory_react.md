# BasisTheoryReact

`BasisTheoryReact` adds React-specific capabilities on top of the `BasisTheory` class. All [API features](/api-reference) and [Tokenization Features](#tokenization) are still available, plus the methods below.

## getElement

```tsx
import { 
  BasisTheoryApiError,
  BasisTheoryValidationError,
  TextElement, 
  useBasisTheory, 
} from '@basis-theory/basis-theory-react';

const ssnMask = [/\d/, /\d/, /\d/, "-", /\d/, /\d/, "-", /\d/, /\d/, /\d/, /\d/];

const MyForm = () => {
  const { bt } = useBasisTheory('test_1234567890', { elements: true });

  const submit = async () => {
    const fullName = bt.getElement('fullName');
    const ssn = bt.getElement('ssn');

    try {
      const tokens = await bt.tokenize({
        fullName,
        ssn,
      });
    } catch (error) {
      if (error instanceof BasisTheoryValidationError) {
        // check error details
      } else if (error instanceof BasisTheoryApiError) {
        // check error data or status
      }
    }
  }

  return <BasisTheoryProvider bt={bt}>
    <TextElement id="fullName" placeholder="Full name" aria-label="Full name" />
    <TextElement id="ssn" placeholder="SSN" aria-label="Social Security Number" mask={ssnMask} transform={/[-]/} />
    <div>
      <button type="submit" onClick={submit} disabled={!bt}>Submit</button>
    </div>
  </BasisTheoryProvider>;
}
```

> Typescript

```tsx
import type { 
  CardExpirationDateElement as ICardExpirationDateElement 
} from '@basis-theory/basis-theory-react/types';


bt.getElement('expDate').month(); // Error TS2551: property doesn't exist 

(bt.getElement('expDate') as ICardExpirationDateElement).month(); // no error

bt.getElement<ICardExpirationDateElement>('expDate').month() // no error
```

Gets the underlying Element instance. Given the declarative nature of React, this method enables referencing the Element value for tokenization.

The targeted Element must be present in your component tree (virtual DOM) when invoking this method.

| Parameter | Required | Type     | Description                      |
|-----------|----------|----------|----------------------------------|
| `id`      | true     | *string* | The `id` of the Element instance |

<aside class="warning">
  <span>Passing an unknown `id` to the <code>getElement</code> will throw an error at runtime.</span>
</aside>

<aside class="warning">
  <span>When using React, it is not recommended to directly call lifecycle methods from the Element instance returned by the <code>getElement</code> method.</span>
</aside>

You can type-cast `getElement` method to safely call specific Elements methods.

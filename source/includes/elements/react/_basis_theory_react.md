# BasisTheoryReact

`BasisTheoryReact` adds React-specific capabilities on top of the `BasisTheory` class. All [API features](/api-reference) and [Tokenization Features](#tokenization) are still available, plus the methods below.

## Using Refs

```tsx
import { useRef } from 'react';
import { 
  BasisTheoryApiError,
  BasisTheoryValidationError,
  TextElement, 
  useBasisTheory, 
} from '@basis-theory/basis-theory-react';

const ssnMask = [/\d/, /\d/, /\d/, "-", /\d/, /\d/, "-", /\d/, /\d/, /\d/, /\d/];

const MyForm = () => {
  const { bt } = useBasisTheory('test_1234567890', { elements: true });
  const fullNameRef = useRef(null);
  const ssnRef = useRef(null);

  const submit = async () => {
    const fullName = fullNameRef.current;
    const ssn = ssnRef.current;

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
    <TextElement id="fullName" ref={fullNameRef} placeholder="Full name" aria-label="Full name" />
    <TextElement id="ssn" ref={ssnRef} placeholder="SSN" aria-label="Social Security Number" mask={ssnMask} transform={/[-]/} />
    <div>
      <button type="submit" onClick={submit} disabled={!bt}>Submit</button>
    </div>
  </BasisTheoryProvider>;
}
```

> Typescript

```tsx
import { useRef } from 'react';
import type { 
  CardExpirationDateElement as ICardExpirationDateElement 
} from '@basis-theory/basis-theory-react/types';

const expirationDateRef = useRef(null);

expirationDateRef.current.month(); // Error TS2551: property doesn't exist 

const expirationDateRef = useRef<ICardExpirationDateElement>(null); 

expirationDateRef.current.month(); // no error
```

[Refs](https://reactjs.org/docs/refs-and-the-dom.html) are a way to access DOM nodes or React component instances.

In BasisTheoryReact, `refs` are utilized to store or receive (in the case of a [callback ref](https://reactjs.org/docs/refs-and-the-dom.html#callback-refs)) the underlying Element instance, to tokenize their value or call one of its methods.

When using Typescript, you can type-cast the element `ref` to safely call [specific](#tokenization-data-parsing) Elements methods.

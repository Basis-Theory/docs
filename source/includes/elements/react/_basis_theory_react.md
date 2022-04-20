# BasisTheoryReact

`BasisTheoryReact` adds React-specific capabilities on top of the `BasisTheory` class. All [API features](/api-reference) and [Elements Services](#elements-services) are still available, plus the methods below.

## getElement

```jsx
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
        }

        if (error instanceof BasisTheoryApiError) {
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

Gets the underlying Element instance to be used for tokenization. Returns `undefined` if an Element with the provided `id` does not exist.

Parameter | Required | Type      | Description
--------- | -------- | --------- | ------------
`id`      | true     | *string*  | The `id` of the Element instance

<aside class="warning">
  <span>When using React, it is not recommended to directly call lifecycle methods from the Element instance returned by the <code>getElement</code> method.</span>
</aside>

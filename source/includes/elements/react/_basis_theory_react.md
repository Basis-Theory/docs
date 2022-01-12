# BasisTheoryReact

`BasisTheoryReact` adds React-specific capabilities on top of `BasisTheory` class. All [API features](/api-reference) and [Elements Services](#elements-services) are still available, plus the methods below.

## getElement

```jsx
import { useBasisTheory } from '@basis-theory/basis-theory-react';
import { TextElement } from '@basis-theory/basis-theory-react/elements';

const ssnMask = [/\d/, /\d/, /\d/, "-", /\d/, /\d/, "-", /\d/, /\d/, /\d/, /\d/];

const MyForm = () => {
  const { bt } = useBasisTheory('test_1234567890', { elements: true });

  const submit = async () => {
    const fullName = bt.getElement('fullName');
    const ssn = bt.getElement('ssn');
    const tokens = await bt.tokenize({
      fullName,
      ssn,
    });
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

Gets the underlying Element instance to be used for tokenization. Returns `undefined` if can't match an Element with the provided `id`.

Parameter | Required | Type      | Description
--------- | -------- | --------- | ------------
`id`      | true     | *string*  | The Element's required `id` property

<aside class="warning">
  <span>When using React, it is not recommended to directly call lifecycle methods from the Element instance returned by the <code>getElement</code> method.</span>
</aside>

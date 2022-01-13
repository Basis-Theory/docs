# BasisTheoryProvider

```jsx
import { 
  useBasisTheory, 
  BasisTheoryProvider
} from '@basis-theory/basis-theory-react';
import { TextElement } from '@basis-theory/basis-theory-react/elements';

const App = () => {
  // creates a new instance of BasisTheory class
  const { bt } = useBasisTheory('test_1234567890', { elements: true });
  
  if (bt) {
    // able to call BasisTheory methods
  }
  
  return <BasisTheoryProvider bt={bt}>
      <MyComponent />
    </BasisTheoryProvider>;
}

const MyComponent = () => {
  // calling this hook with no attributes grabs the BasisTheory instance from Context  
  const { bt } = useBasisTheory();

  if (bt) {
    // able to call BasisTheory methods
  }
  
  return <TextElement /> ; // Element will also grab it from the Context
}
```

This <a href="https://reactjs.org/docs/context.html" target="_blank">Context Provider</a> shares a `BasisTheory` instance to your component tree, making it available for Basis Theory Elements or other custom components. 

Property   | Required | Type                | Description
---------- | -------- | ------------------- | -----------
`bt`       | false    | *BasisTheoryReact*  | [Instance](#basistheoryreact) to be provided in the context. <br><i>Note: this is not required because initialization happens asynchronously. See [`useBasisTheory`](#usebasistheory).</i>

<aside class="notice">
  <span>Elements will prioritize the <code>BasisTheory</code> instance passed to it's own <code>bt</code> property over an instance passed in to a parent <code>BasisTheoryProvider</code>.</span>
</aside>

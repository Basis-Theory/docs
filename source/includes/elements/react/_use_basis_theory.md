# useBasisTheory

```jsx
import { 
  useBasisTheory
} from '@basis-theory/basis-theory-react';

const App = () => {
  // creates a new instance of BasisTheory class
  const { bt, error } = useBasisTheory('test_1234567890', { elements: true });
  
  if (bt) {
    // able to call BasisTheory methods
  }
  
  if (error) {
    // initialization error
  }
  
  return <MyComponent />;
}
```

The `useBasisTheory` <a href="https://reactjs.org/docs/hooks-intro.html" target="_blank">hook</a> makes it easy to initialize the SDK. There are two ways of calling it:

- Passing [init parameters](#initialize) creates a new instance of `BasisTheory` class and initializes it automatically.
- Passing no parameters will try to grab the `BasisTheory` instance from the `Context`. See [BasisTheoryProvider](#basistheoryprovider).

It returns an object containing:

Attribute  | Type                                  | Description
---------- | ------------------------------------- | -----------
`bt`       | *BasisTheoryReact* &#124; *undefined* | [Enhanced `BasisTheory` instance](#basistheoryreact) to be provided in the context. <br><i>Note: this stays `undefined` during `BasisTheory` initialization, so you don't have to deal with `Promise` handling in your components code.</i>
`error`    | *any* &#124; *undefined*              | Holds any initialization errors, i.e.: bad API key.

<aside class="notice">
  <span>Make sure your API key refers to the correct <a href="/api-reference#applications-application-types">Application Type</a> for the intended use.</span>
</aside>

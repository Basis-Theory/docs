# useBasisTheory

The `useBasisTheory` <a href="https://reactjs.org/docs/hooks-intro.html" target="_blank">hook</a> makes it easy to initialize the SDK or retrieve a previously initialized instance of it.

It returns an object containing:

Attribute  | Type                                  | Description
---------- | ------------------------------------- | -----------
`bt`       | *BasisTheoryReact* &#124; *undefined* | [`BasisTheoryReact`](#basistheoryreact) instance. <br><i>Note: this stays `undefined` during `BasisTheory` initialization, so you don't have to deal with `Promise` handling in your components code.</i>
`error`    | *any* &#124; *undefined*              | Holds any initialization errors (e.g. bad API key).

## Initialize

```tsx
import { 
  useBasisTheory
} from '@basis-theory/basis-theory-react';

const App = () => {
  // creates a new instance of BasisTheory class
  const { bt, error } = useBasisTheory('test_1234567890', { elements: true });
  
  // instance stays undefined during initialization
  if (bt) {
    // able to call BasisTheory methods
  }
  
  if (error) {
    // initialization error
  }
  
  return <MyComponent />;
}
```

Calling the `useBasisTheory` hook with parameters creates a new instance of [`BasisTheoryReact`](#basistheoryreact) class and initializes it automatically.

Parameter | Required | Type                     | Description
--------- | -------- | ------------------------ | -----------
`apiKey`  | true     | *string*                 | The API Key used to identify an [Application](/api-reference#applications).
`options` | false    | *BasisTheoryInitOptions* | [Options](#initialize-permission-types-basis-theory-init-options) for initializing the `BasisTheoryReact` instance.
<!-- Options link above looks weird because of how Slate generates them -->

<aside class="notice">
  <span>Make sure your API key has an <code>Elements</code> or <code>Client-side Application</code> <a href="/api-reference#applications-application-types">Application Type</a>.</span>
</aside>

## Retrieve from Context

Calling the `useBasisTheory` hook with no parameters will retrieve the  [`BasisTheoryReact`](#basistheoryreact) instance from the `Context`. See [BasisTheoryProvider](#basistheoryprovider).



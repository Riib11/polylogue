## Module Partial.Unsafe

Utilities for working with partial functions.
See the README for more documentation.

#### `unsafePartial`

``` purescript
unsafePartial :: forall a. (Partial => a) -> a
```

Discharge a partiality constraint, unsafely.

#### `unsafeCrashWith`

``` purescript
unsafeCrashWith :: forall a. String -> a
```

A function which crashes with the specified error message.



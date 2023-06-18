## Module Dotenv.Internal.Resolve

This module encapsulates the logic for resolving `.env` values.

#### `resolve`

``` purescript
resolve :: forall r. Array (Setting UnresolvedValue) -> List Name -> UnresolvedValue -> Run (CHILD_PROCESS + ENVIRONMENT + r) ResolvedValue
```

Resolves a value according to its expression.



## Module Dotenv.Internal.Apply

This module encapsulates the logic for applying settings to the environment.

#### `apply`

``` purescript
apply :: forall r. Array (Setting UnresolvedValue) -> Run (CHILD_PROCESS + ENVIRONMENT + r) Unit
```

Applies the specified settings to the environment.



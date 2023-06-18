## Module Foreign.Keys

This module provides functions for working with object properties
of Javascript objects.

#### `keys`

``` purescript
keys :: forall m. Monad m => Foreign -> ExceptT (NonEmptyList ForeignError) m (Array String)
```

Get an array of the properties defined on a foreign value



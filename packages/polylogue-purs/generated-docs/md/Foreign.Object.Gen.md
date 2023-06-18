## Module Foreign.Object.Gen

#### `genForeignObject`

``` purescript
genForeignObject :: forall m a. MonadRec m => MonadGen m => m String -> m a -> m (Object a)
```

Generates a `Object` using the specified key and value generators.



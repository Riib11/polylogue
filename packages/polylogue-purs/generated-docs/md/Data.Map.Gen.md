## Module Data.Map.Gen

#### `genMap`

``` purescript
genMap :: forall m a b. MonadRec m => MonadGen m => Ord a => m a -> m b -> m (Map a b)
```

Generates a `Map` using the specified key and value generators.



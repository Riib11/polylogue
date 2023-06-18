## Module Control.Monad.Gen.Class

#### `MonadGen`

``` purescript
class (Monad m) <= MonadGen m  where
  chooseInt :: Int -> Int -> m Int
  chooseFloat :: Number -> Number -> m Number
  chooseBool :: m Boolean
  resize :: forall a. (Size -> Size) -> m a -> m a
  sized :: forall a. (Size -> m a) -> m a
```

A class for random generator implementations.

Instances should provide implementations for the generation functions
that return choices with uniform probability.

See also `Gen` in `purescript-quickcheck`, which implements this
type class.

#### `Size`

``` purescript
type Size = Int
```



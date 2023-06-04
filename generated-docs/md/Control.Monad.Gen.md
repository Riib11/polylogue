## Module Control.Monad.Gen

#### `choose`

``` purescript
choose :: forall m a. MonadGen m => m a -> m a -> m a
```

Creates a generator that outputs a value chosen from one of two existing
existing generators with even probability.

#### `oneOf`

``` purescript
oneOf :: forall m f a. MonadGen m => Foldable1 f => f (m a) -> m a
```

Creates a generator that outputs a value chosen from a selection of
existing generators with uniform probability.

#### `frequency`

``` purescript
frequency :: forall m f a. MonadGen m => Foldable1 f => f (Tuple Number (m a)) -> m a
```

Creates a generator that outputs a value chosen from a selection of
existing generators, where the selection has weight values for the
probability of choice for each generator. The probability values will be
normalised.

#### `elements`

``` purescript
elements :: forall m f a. MonadGen m => Foldable1 f => f a -> m a
```

Creates a generator that outputs a value chosen from a selection with
uniform probability.

#### `unfoldable`

``` purescript
unfoldable :: forall m f a. MonadRec m => MonadGen m => Unfoldable f => m a -> m (f a)
```

Creates a generator that produces unfoldable structures based on an
existing generator for the elements.

The size of the unfoldable will be determined by the current size state
for the generator. To generate an unfoldable structure of a particular
size, use the `resize` function from the `MonadGen` class first.

#### `suchThat`

``` purescript
suchThat :: forall m a. MonadRec m => MonadGen m => m a -> (a -> Boolean) -> m a
```

Creates a generator that repeatedly run another generator until its output
matches a given predicate. This will never halt if the predicate always
fails.

#### `filtered`

``` purescript
filtered :: forall m a. MonadRec m => MonadGen m => m (Maybe a) -> m a
```

Creates a generator that repeatedly run another generator until it produces
`Just` node. This will never halt if the input generator always produces `Nothing`.


### Re-exported from Control.Monad.Gen.Class:

#### `Size`

``` purescript
type Size = Int
```

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


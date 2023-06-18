## Module Control.Monad.Gen.Common

#### `genEither`

``` purescript
genEither :: forall m a b. MonadGen m => m a -> m b -> m (Either a b)
```

Creates a generator that outputs `Either` values, choosing a value from a
`Left` or the `Right` with even probability.

#### `genEither'`

``` purescript
genEither' :: forall m a b. MonadGen m => Number -> m a -> m b -> m (Either a b)
```

Creates a generator that outputs `Either` values, choosing a value from a
`Left` or the `Right` with adjustable bias. As the bias value increases,
the chance of returning a `Left` value rises. A bias ≤ 0.0 will always
return `Right`, a bias ≥ 1.0 will always return `Left`.

#### `genIdentity`

``` purescript
genIdentity :: forall m a. Functor m => m a -> m (Identity a)
```

Creates a generator that outputs `Identity` values, choosing a value from
another generator for the inner value.

#### `genMaybe`

``` purescript
genMaybe :: forall m a. MonadGen m => m a -> m (Maybe a)
```

Creates a generator that outputs `Maybe` values, choosing a value from
another generator for the inner value. The generator has a 75% chance of
returning a `Just` over a `Nothing`.

#### `genMaybe'`

``` purescript
genMaybe' :: forall m a. MonadGen m => Number -> m a -> m (Maybe a)
```

Creates a generator that outputs `Maybe` values, choosing a value from
another generator for the inner value, with an adjustable bias for how
often `Just` is returned vs `Nothing`. A bias ≤ 0.0 will always
return `Nothing`, a bias ≥ 1.0 will always return `Just`.

#### `genTuple`

``` purescript
genTuple :: forall m a b. Apply m => m a -> m b -> m (Tuple a b)
```

Creates a generator that outputs `Tuple` values, choosing values from a
pair of generators for each slot in the tuple.

#### `genNonEmpty`

``` purescript
genNonEmpty :: forall m a f. MonadRec m => MonadGen m => Unfoldable f => m a -> m (NonEmpty f a)
```

Creates a generator that outputs `NonEmpty` values, choosing values from a
generator for each of the items.

The size of the value will be determined by the current size state
for the generator. To generate a value of a particular size, use the
`resize` function from the `MonadGen` class first.



## Module Data.FoldableWithIndex

#### `FoldableWithIndex`

``` purescript
class (Foldable f) <= FoldableWithIndex i f | f -> i where
  foldrWithIndex :: forall a b. (i -> a -> b -> b) -> b -> f a -> b
  foldlWithIndex :: forall a b. (i -> b -> a -> b) -> b -> f a -> b
  foldMapWithIndex :: forall a m. Monoid m => (i -> a -> m) -> f a -> m
```

A `Foldable` with an additional index.
A `FoldableWithIndex` instance must be compatible with its `Foldable`
instance
```purescript
foldr f = foldrWithIndex (const f)
foldl f = foldlWithIndex (const f)
foldMap f = foldMapWithIndex (const f)
```

Default implementations are provided by the following functions:

- `foldrWithIndexDefault`
- `foldlWithIndexDefault`
- `foldMapWithIndexDefaultR`
- `foldMapWithIndexDefaultL`

Note: some combinations of the default implementations are unsafe to
use together - causing a non-terminating mutually recursive cycle.
These combinations are documented per function.

##### Instances
``` purescript
FoldableWithIndex Int Array
FoldableWithIndex Unit Maybe
FoldableWithIndex Unit First
FoldableWithIndex Unit Last
FoldableWithIndex Unit Additive
FoldableWithIndex Unit Dual
FoldableWithIndex Unit Disj
FoldableWithIndex Unit Conj
FoldableWithIndex Unit Multiplicative
FoldableWithIndex Unit (Either a)
FoldableWithIndex Unit (Tuple a)
FoldableWithIndex Unit Identity
FoldableWithIndex Void (Const a)
(FoldableWithIndex a f, FoldableWithIndex b g) => FoldableWithIndex (Either a b) (Product f g)
(FoldableWithIndex a f, FoldableWithIndex b g) => FoldableWithIndex (Either a b) (Coproduct f g)
(FoldableWithIndex a f, FoldableWithIndex b g) => FoldableWithIndex (Tuple a b) (Compose f g)
(FoldableWithIndex a f) => FoldableWithIndex a (App f)
```

#### `foldrWithIndexDefault`

``` purescript
foldrWithIndexDefault :: forall i f a b. FoldableWithIndex i f => (i -> a -> b -> b) -> b -> f a -> b
```

A default implementation of `foldrWithIndex` using `foldMapWithIndex`.

Note: when defining a `FoldableWithIndex` instance, this function is
unsafe to use in combination with `foldMapWithIndexDefaultR`.

#### `foldlWithIndexDefault`

``` purescript
foldlWithIndexDefault :: forall i f a b. FoldableWithIndex i f => (i -> b -> a -> b) -> b -> f a -> b
```

A default implementation of `foldlWithIndex` using `foldMapWithIndex`.

Note: when defining a `FoldableWithIndex` instance, this function is
unsafe to use in combination with `foldMapWithIndexDefaultL`.

#### `foldMapWithIndexDefaultR`

``` purescript
foldMapWithIndexDefaultR :: forall i f a m. FoldableWithIndex i f => Monoid m => (i -> a -> m) -> f a -> m
```

A default implementation of `foldMapWithIndex` using `foldrWithIndex`.

Note: when defining a `FoldableWithIndex` instance, this function is
unsafe to use in combination with `foldrWithIndexDefault`.

#### `foldMapWithIndexDefaultL`

``` purescript
foldMapWithIndexDefaultL :: forall i f a m. FoldableWithIndex i f => Monoid m => (i -> a -> m) -> f a -> m
```

A default implementation of `foldMapWithIndex` using `foldlWithIndex`.

Note: when defining a `FoldableWithIndex` instance, this function is
unsafe to use in combination with `foldlWithIndexDefault`.

#### `foldWithIndexM`

``` purescript
foldWithIndexM :: forall i f m a b. FoldableWithIndex i f => Monad m => (i -> a -> b -> m a) -> a -> f b -> m a
```

Similar to 'foldlWithIndex', but the result is encapsulated in a monad.

Note: this function is not generally stack-safe, e.g., for monads which
build up thunks a la `Eff`.

#### `traverseWithIndex_`

``` purescript
traverseWithIndex_ :: forall i a b f m. Applicative m => FoldableWithIndex i f => (i -> a -> m b) -> f a -> m Unit
```

Traverse a data structure with access to the index, performing some
effects encoded by an `Applicative` functor at each value, ignoring the
final result.

For example:

```purescript
> traverseWithIndex_ (curry logShow) ["a", "b", "c"]
(Tuple 0 "a")
(Tuple 1 "b")
(Tuple 2 "c")
```

#### `forWithIndex_`

``` purescript
forWithIndex_ :: forall i a b f m. Applicative m => FoldableWithIndex i f => f a -> (i -> a -> m b) -> m Unit
```

A version of `traverseWithIndex_` with its arguments flipped.

This can be useful when running an action written using do notation
for every element in a data structure:

For example:

```purescript
forWithIndex_ ["a", "b", "c"] \i x -> do
  logShow i
  log x
```

#### `surroundMapWithIndex`

``` purescript
surroundMapWithIndex :: forall i f a m. FoldableWithIndex i f => Semigroup m => m -> (i -> a -> m) -> f a -> m
```

`foldMapWithIndex` but with each element surrounded by some fixed value.

For example:

```purescript
> surroundMapWithIndex "*" (\i x -> show i <> x) []
= "*"

> surroundMapWithIndex "*" (\i x -> show i <> x) ["a"]
= "*0a*"

> surroundMapWithIndex "*" (\i x -> show i <> x) ["a", "b"]
= "*0a*1b*"

> surroundMapWithIndex "*" (\i x -> show i <> x) ["a", "b", "c"]
= "*0a*1b*2c*"
```

#### `allWithIndex`

``` purescript
allWithIndex :: forall i a b f. FoldableWithIndex i f => HeytingAlgebra b => (i -> a -> b) -> f a -> b
```

`allWithIndex f` is the same as `and <<< mapWithIndex f`; map a function over the
structure, and then get the conjunction of the results.

#### `anyWithIndex`

``` purescript
anyWithIndex :: forall i a b f. FoldableWithIndex i f => HeytingAlgebra b => (i -> a -> b) -> f a -> b
```

`anyWithIndex f` is the same as `or <<< mapWithIndex f`; map a function over the
structure, and then get the disjunction of the results.

#### `findWithIndex`

``` purescript
findWithIndex :: forall i a f. FoldableWithIndex i f => (i -> a -> Boolean) -> f a -> Maybe { index :: i, value :: a }
```

Try to find an element in a data structure which satisfies a predicate
with access to the index.

#### `findMapWithIndex`

``` purescript
findMapWithIndex :: forall i a b f. FoldableWithIndex i f => (i -> a -> Maybe b) -> f a -> Maybe b
```

Try to find an element in a data structure which satisfies a predicate mapping
with access to the index.

#### `foldrDefault`

``` purescript
foldrDefault :: forall i f a b. FoldableWithIndex i f => (a -> b -> b) -> b -> f a -> b
```

A default implementation of `foldr` using `foldrWithIndex`

#### `foldlDefault`

``` purescript
foldlDefault :: forall i f a b. FoldableWithIndex i f => (b -> a -> b) -> b -> f a -> b
```

A default implementation of `foldl` using `foldlWithIndex`

#### `foldMapDefault`

``` purescript
foldMapDefault :: forall i f a m. FoldableWithIndex i f => Monoid m => (a -> m) -> f a -> m
```

A default implementation of `foldMap` using `foldMapWithIndex`



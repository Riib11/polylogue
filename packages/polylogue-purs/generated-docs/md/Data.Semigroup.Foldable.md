## Module Data.Semigroup.Foldable

#### `Foldable1`

``` purescript
class (Foldable t) <= Foldable1 t  where
  foldr1 :: forall a. (a -> a -> a) -> t a -> a
  foldl1 :: forall a. (a -> a -> a) -> t a -> a
  foldMap1 :: forall a m. Semigroup m => (a -> m) -> t a -> m
```

`Foldable1` represents data structures with a minimum of one element that can be _folded_.

- `foldr1` folds a structure from the right
- `foldl1` folds a structure from the left
- `foldMap1` folds a structure by accumulating values in a `Semigroup`

Default implementations are provided by the following functions:

- `foldr1Default`
- `foldl1Default`
- `foldMap1DefaultR`
- `foldMap1DefaultL`

Note: some combinations of the default implementations are unsafe to
use together - causing a non-terminating mutually recursive cycle.
These combinations are documented per function.

##### Instances
``` purescript
Foldable1 Dual
Foldable1 Multiplicative
Foldable1 (Tuple a)
Foldable1 Identity
```

#### `fold1`

``` purescript
fold1 :: forall t m. Foldable1 t => Semigroup m => t m -> m
```

Fold a data structure, accumulating values in some `Semigroup`.

#### `traverse1_`

``` purescript
traverse1_ :: forall t f a b. Foldable1 t => Apply f => (a -> f b) -> t a -> f Unit
```

Traverse a data structure, performing some effects encoded by an
`Apply` instance at each value, ignoring the final result.

#### `for1_`

``` purescript
for1_ :: forall t f a b. Foldable1 t => Apply f => t a -> (a -> f b) -> f Unit
```

A version of `traverse1_` with its arguments flipped.

This can be useful when running an action written using do notation
for every element in a data structure:

#### `sequence1_`

``` purescript
sequence1_ :: forall t f a. Foldable1 t => Apply f => t (f a) -> f Unit
```

Perform all of the effects in some data structure in the order
given by the `Foldable1` instance, ignoring the final result.

#### `foldr1Default`

``` purescript
foldr1Default :: forall t a. Foldable1 t => (a -> a -> a) -> t a -> a
```

A default implementation of `foldr1` using `foldMap1`.

Note: when defining a `Foldable1` instance, this function is unsafe to use
in combination with `foldMap1DefaultR`.

#### `foldl1Default`

``` purescript
foldl1Default :: forall t a. Foldable1 t => (a -> a -> a) -> t a -> a
```

A default implementation of `foldl1` using `foldMap1`.

Note: when defining a `Foldable1` instance, this function is unsafe to use
in combination with `foldMap1DefaultL`.

#### `foldMap1DefaultR`

``` purescript
foldMap1DefaultR :: forall t m a. Foldable1 t => Functor t => Semigroup m => (a -> m) -> t a -> m
```

A default implementation of `foldMap1` using `foldr1`.

Note: when defining a `Foldable1` instance, this function is unsafe to use
in combination with `foldr1Default`.

#### `foldMap1DefaultL`

``` purescript
foldMap1DefaultL :: forall t m a. Foldable1 t => Functor t => Semigroup m => (a -> m) -> t a -> m
```

A default implementation of `foldMap1` using `foldl1`.

Note: when defining a `Foldable1` instance, this function is unsafe to use
in combination with `foldl1Default`.

#### `intercalate`

``` purescript
intercalate :: forall f m. Foldable1 f => Semigroup m => m -> f m -> m
```

Fold a data structure using a `Semigroup` instance,
combining adjacent elements using the specified separator.

#### `intercalateMap`

``` purescript
intercalateMap :: forall f m a. Foldable1 f => Semigroup m => m -> (a -> m) -> f a -> m
```

Fold a data structure, accumulating values in some `Semigroup`,
combining adjacent elements using the specified separator.

#### `maximum`

``` purescript
maximum :: forall f a. Ord a => Foldable1 f => f a -> a
```

#### `maximumBy`

``` purescript
maximumBy :: forall f a. Foldable1 f => (a -> a -> Ordering) -> f a -> a
```

#### `minimum`

``` purescript
minimum :: forall f a. Ord a => Foldable1 f => f a -> a
```

#### `minimumBy`

``` purescript
minimumBy :: forall f a. Foldable1 f => (a -> a -> Ordering) -> f a -> a
```



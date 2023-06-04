## Module Data.TraversableWithIndex

#### `TraversableWithIndex`

``` purescript
class (FunctorWithIndex i t, FoldableWithIndex i t, Traversable t) <= TraversableWithIndex i t | t -> i where
  traverseWithIndex :: forall a b m. Applicative m => (i -> a -> m b) -> t a -> m (t b)
```

A `Traversable` with an additional index.  
A `TraversableWithIndex` instance must be compatible with its
`Traversable` instance
```purescript
traverse f = traverseWithIndex (const f)
```
with its `FoldableWithIndex` instance
```
foldMapWithIndex f = unwrap <<< traverseWithIndex (\i -> Const <<< f i)
```
and with its `FunctorWithIndex` instance
```
mapWithIndex f = unwrap <<< traverseWithIndex (\i -> Identity <<< f i)
```

A default implementation is provided by `traverseWithIndexDefault`.

##### Instances
``` purescript
TraversableWithIndex Int Array
TraversableWithIndex Unit Maybe
TraversableWithIndex Unit First
TraversableWithIndex Unit Last
TraversableWithIndex Unit Additive
TraversableWithIndex Unit Dual
TraversableWithIndex Unit Conj
TraversableWithIndex Unit Disj
TraversableWithIndex Unit Multiplicative
TraversableWithIndex Unit (Either a)
TraversableWithIndex Unit (Tuple a)
TraversableWithIndex Unit Identity
TraversableWithIndex Void (Const a)
(TraversableWithIndex a f, TraversableWithIndex b g) => TraversableWithIndex (Either a b) (Product f g)
(TraversableWithIndex a f, TraversableWithIndex b g) => TraversableWithIndex (Either a b) (Coproduct f g)
(TraversableWithIndex a f, TraversableWithIndex b g) => TraversableWithIndex (Tuple a b) (Compose f g)
(TraversableWithIndex a f) => TraversableWithIndex a (App f)
```

#### `traverseWithIndexDefault`

``` purescript
traverseWithIndexDefault :: forall i t a b m. TraversableWithIndex i t => Applicative m => (i -> a -> m b) -> t a -> m (t b)
```

A default implementation of `traverseWithIndex` using `sequence` and `mapWithIndex`.

#### `forWithIndex`

``` purescript
forWithIndex :: forall i a b m t. Applicative m => TraversableWithIndex i t => t a -> (i -> a -> m b) -> m (t b)
```

A version of `traverseWithIndex` with its arguments flipped.


This can be useful when running an action written using do notation
for every element in a data structure:

For example:

```purescript
for [1, 2, 3] \i x -> do
  logShow i
  pure (x * x)
```

#### `scanlWithIndex`

``` purescript
scanlWithIndex :: forall i a b f. TraversableWithIndex i f => (i -> b -> a -> b) -> b -> f a -> f b
```

Fold a data structure from the left with access to the indices, keeping
all intermediate results instead of only the final result. Note that the
initial value does not appear in the result (unlike Haskell's
`Prelude.scanl`).

```purescript
scanlWithIndex (\i y x -> i + y + x) 0 [1, 2, 3] = [1, 4, 9]
```

#### `mapAccumLWithIndex`

``` purescript
mapAccumLWithIndex :: forall i a b s f. TraversableWithIndex i f => (i -> s -> a -> Accum s b) -> s -> f a -> Accum s (f b)
```

Fold a data structure from the left with access to the indices, keeping
all intermediate results instead of only the final result.

Unlike `scanlWithIndex`, `mapAccumLWithIndex` allows the type of accumulator to differ
from the element type of the final data structure.

#### `scanrWithIndex`

``` purescript
scanrWithIndex :: forall i a b f. TraversableWithIndex i f => (i -> a -> b -> b) -> b -> f a -> f b
```

Fold a data structure from the right with access to the indices, keeping
all intermediate results instead of only the final result. Note that the
initial value does not appear in the result (unlike Haskell's `Prelude.scanr`).

```purescript
scanrWithIndex (\i x y -> i + x + y) 0 [1, 2, 3] = [9, 8, 5]
```

#### `mapAccumRWithIndex`

``` purescript
mapAccumRWithIndex :: forall i a b s f. TraversableWithIndex i f => (i -> s -> a -> Accum s b) -> s -> f a -> Accum s (f b)
```

Fold a data structure from the right with access to the indices, keeping
all intermediate results instead of only the final result.

Unlike `scanrWithIndex`, `imapAccumRWithIndex` allows the type of accumulator to differ
from the element type of the final data structure.

#### `traverseDefault`

``` purescript
traverseDefault :: forall i t a b m. TraversableWithIndex i t => Applicative m => (a -> m b) -> t a -> m (t b)
```

A default implementation of `traverse` in terms of `traverseWithIndex`


### Re-exported from Data.Traversable.Accum:

#### `Accum`

``` purescript
type Accum s a = { accum :: s, value :: a }
```


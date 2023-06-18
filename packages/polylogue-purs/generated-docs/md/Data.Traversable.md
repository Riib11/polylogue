## Module Data.Traversable

#### `Traversable`

``` purescript
class (Functor t, Foldable t) <= Traversable t  where
  traverse :: forall a b m. Applicative m => (a -> m b) -> t a -> m (t b)
  sequence :: forall a m. Applicative m => t (m a) -> m (t a)
```

`Traversable` represents data structures which can be _traversed_,
accumulating results and effects in some `Applicative` functor.

- `traverse` runs an action for every element in a data structure,
  and accumulates the results.
- `sequence` runs the actions _contained_ in a data structure,
  and accumulates the results.

```purescript
import Data.Traversable
import Data.Maybe
import Data.Int (fromNumber)

sequence [Just 1, Just 2, Just 3] == Just [1,2,3]
sequence [Nothing, Just 2, Just 3] == Nothing

traverse fromNumber [1.0, 2.0, 3.0] == Just [1,2,3]
traverse fromNumber [1.5, 2.0, 3.0] == Nothing

traverse logShow [1,2,3]
-- prints:
   1
   2
   3

traverse (\x -> [x, 0]) [1,2,3] == [[1,2,3],[1,2,0],[1,0,3],[1,0,0],[0,2,3],[0,2,0],[0,0,3],[0,0,0]]
```

The `traverse` and `sequence` functions should be compatible in the
following sense:

- `traverse f xs = sequence (f <$> xs)`
- `sequence = traverse identity`

`Traversable` instances should also be compatible with the corresponding
`Foldable` instances, in the following sense:

- `foldMap f = runConst <<< traverse (Const <<< f)`

Default implementations are provided by the following functions:

- `traverseDefault`
- `sequenceDefault`

##### Instances
``` purescript
Traversable Array
Traversable Maybe
Traversable First
Traversable Last
Traversable Additive
Traversable Dual
Traversable Conj
Traversable Disj
Traversable Multiplicative
Traversable (Either a)
Traversable (Tuple a)
Traversable Identity
Traversable (Const a)
(Traversable f, Traversable g) => Traversable (Product f g)
(Traversable f, Traversable g) => Traversable (Coproduct f g)
(Traversable f, Traversable g) => Traversable (Compose f g)
(Traversable f) => Traversable (App f)
```

#### `traverseDefault`

``` purescript
traverseDefault :: forall t a b m. Traversable t => Applicative m => (a -> m b) -> t a -> m (t b)
```

A default implementation of `traverse` using `sequence` and `map`.

#### `sequenceDefault`

``` purescript
sequenceDefault :: forall t a m. Traversable t => Applicative m => t (m a) -> m (t a)
```

A default implementation of `sequence` using `traverse`.

#### `for`

``` purescript
for :: forall a b m t. Applicative m => Traversable t => t a -> (a -> m b) -> m (t b)
```

A version of `traverse` with its arguments flipped.


This can be useful when running an action written using do notation
for every element in a data structure:

For example:

```purescript
for [1, 2, 3] \n -> do
  print n
  return (n * n)
```

#### `scanl`

``` purescript
scanl :: forall a b f. Traversable f => (b -> a -> b) -> b -> f a -> f b
```

Fold a data structure from the left, keeping all intermediate results
instead of only the final result. Note that the initial value does not
appear in the result (unlike Haskell's `Prelude.scanl`).

```purescript
scanl (+) 0  [1,2,3] = [1,3,6]
scanl (-) 10 [1,2,3] = [9,7,4]
```

#### `scanr`

``` purescript
scanr :: forall a b f. Traversable f => (a -> b -> b) -> b -> f a -> f b
```

Fold a data structure from the right, keeping all intermediate results
instead of only the final result. Note that the initial value does not
appear in the result (unlike Haskell's `Prelude.scanr`).

```purescript
scanr (+) 0 [1,2,3] = [6,5,3]
scanr (flip (-)) 10 [1,2,3] = [4,5,7]
```

#### `mapAccumL`

``` purescript
mapAccumL :: forall a b s f. Traversable f => (s -> a -> Accum s b) -> s -> f a -> Accum s (f b)
```

Fold a data structure from the left, keeping all intermediate results
instead of only the final result.

Unlike `scanl`, `mapAccumL` allows the type of accumulator to differ
from the element type of the final data structure.

#### `mapAccumR`

``` purescript
mapAccumR :: forall a b s f. Traversable f => (s -> a -> Accum s b) -> s -> f a -> Accum s (f b)
```

Fold a data structure from the right, keeping all intermediate results
instead of only the final result.

Unlike `scanr`, `mapAccumR` allows the type of accumulator to differ
from the element type of the final data structure.


### Re-exported from Data.Foldable:

#### `Foldable`

``` purescript
class Foldable f  where
  foldr :: forall a b. (a -> b -> b) -> b -> f a -> b
  foldl :: forall a b. (b -> a -> b) -> b -> f a -> b
  foldMap :: forall a m. Monoid m => (a -> m) -> f a -> m
```

`Foldable` represents data structures which can be _folded_.

- `foldr` folds a structure from the right
- `foldl` folds a structure from the left
- `foldMap` folds a structure by accumulating values in a `Monoid`

Default implementations are provided by the following functions:

- `foldrDefault`
- `foldlDefault`
- `foldMapDefaultR`
- `foldMapDefaultL`

Note: some combinations of the default implementations are unsafe to
use together - causing a non-terminating mutually recursive cycle.
These combinations are documented per function.

##### Instances
``` purescript
Foldable Array
Foldable Maybe
Foldable First
Foldable Last
Foldable Additive
Foldable Dual
Foldable Disj
Foldable Conj
Foldable Multiplicative
Foldable (Either a)
Foldable (Tuple a)
Foldable Identity
Foldable (Const a)
(Foldable f, Foldable g) => Foldable (Product f g)
(Foldable f, Foldable g) => Foldable (Coproduct f g)
(Foldable f, Foldable g) => Foldable (Compose f g)
(Foldable f) => Foldable (App f)
```

#### `traverse_`

``` purescript
traverse_ :: forall a b f m. Applicative m => Foldable f => (a -> m b) -> f a -> m Unit
```

Traverse a data structure, performing some effects encoded by an
`Applicative` functor at each value, ignoring the final result.

For example:

```purescript
traverse_ print [1, 2, 3]
```

#### `sum`

``` purescript
sum :: forall a f. Foldable f => Semiring a => f a -> a
```

Find the sum of the numeric values in a data structure.

#### `sequence_`

``` purescript
sequence_ :: forall a f m. Applicative m => Foldable f => f (m a) -> m Unit
```

Perform all of the effects in some data structure in the order
given by the `Foldable` instance, ignoring the final result.

For example:

```purescript
sequence_ [ trace "Hello, ", trace " world!" ]
```

#### `or`

``` purescript
or :: forall a f. Foldable f => HeytingAlgebra a => f a -> a
```

The disjunction of all the values in a data structure. When specialized
to `Boolean`, this function will test whether any of the values in a data
structure is `true`.

#### `oneOf`

``` purescript
oneOf :: forall f g a. Foldable f => Plus g => f (g a) -> g a
```

Combines a collection of elements using the `Alt` operation.

#### `notElem`

``` purescript
notElem :: forall a f. Foldable f => Eq a => a -> f a -> Boolean
```

Test whether a value is not an element of a data structure.

#### `minimumBy`

``` purescript
minimumBy :: forall a f. Foldable f => (a -> a -> Ordering) -> f a -> Maybe a
```

Find the smallest element of a structure, according to a given comparison
function. The comparison function should represent a total ordering (see
the `Ord` type class laws); if it does not, the behaviour is undefined.

#### `minimum`

``` purescript
minimum :: forall a f. Ord a => Foldable f => f a -> Maybe a
```

Find the smallest element of a structure, according to its `Ord` instance.

#### `maximumBy`

``` purescript
maximumBy :: forall a f. Foldable f => (a -> a -> Ordering) -> f a -> Maybe a
```

Find the largest element of a structure, according to a given comparison
function. The comparison function should represent a total ordering (see
the `Ord` type class laws); if it does not, the behaviour is undefined.

#### `maximum`

``` purescript
maximum :: forall a f. Ord a => Foldable f => f a -> Maybe a
```

Find the largest element of a structure, according to its `Ord` instance.

#### `intercalate`

``` purescript
intercalate :: forall f m. Foldable f => Monoid m => m -> f m -> m
```

Fold a data structure, accumulating values in some `Monoid`,
combining adjacent elements using the specified separator.

For example:

```purescript
> intercalate ", " ["Lorem", "ipsum", "dolor"]
= "Lorem, ipsum, dolor"

> intercalate "*" ["a", "b", "c"]
= "a*b*c"

> intercalate [1] [[2, 3], [4, 5], [6, 7]]
= [2, 3, 1, 4, 5, 1, 6, 7]
```

#### `for_`

``` purescript
for_ :: forall a b f m. Applicative m => Foldable f => f a -> (a -> m b) -> m Unit
```

A version of `traverse_` with its arguments flipped.

This can be useful when running an action written using do notation
for every element in a data structure:

For example:

```purescript
for_ [1, 2, 3] \n -> do
  print n
  trace "squared is"
  print (n * n)
```

#### `foldrDefault`

``` purescript
foldrDefault :: forall f a b. Foldable f => (a -> b -> b) -> b -> f a -> b
```

A default implementation of `foldr` using `foldMap`.

Note: when defining a `Foldable` instance, this function is unsafe to use
in combination with `foldMapDefaultR`.

#### `foldlDefault`

``` purescript
foldlDefault :: forall f a b. Foldable f => (b -> a -> b) -> b -> f a -> b
```

A default implementation of `foldl` using `foldMap`.

Note: when defining a `Foldable` instance, this function is unsafe to use
in combination with `foldMapDefaultL`.

#### `foldMapDefaultR`

``` purescript
foldMapDefaultR :: forall f a m. Foldable f => Monoid m => (a -> m) -> f a -> m
```

A default implementation of `foldMap` using `foldr`.

Note: when defining a `Foldable` instance, this function is unsafe to use
in combination with `foldrDefault`.

#### `foldMapDefaultL`

``` purescript
foldMapDefaultL :: forall f a m. Foldable f => Monoid m => (a -> m) -> f a -> m
```

A default implementation of `foldMap` using `foldl`.

Note: when defining a `Foldable` instance, this function is unsafe to use
in combination with `foldlDefault`.

#### `fold`

``` purescript
fold :: forall f m. Foldable f => Monoid m => f m -> m
```

Fold a data structure, accumulating values in some `Monoid`.

#### `find`

``` purescript
find :: forall a f. Foldable f => (a -> Boolean) -> f a -> Maybe a
```

Try to find an element in a data structure which satisfies a predicate.

#### `elem`

``` purescript
elem :: forall a f. Foldable f => Eq a => a -> f a -> Boolean
```

Test whether a value is an element of a data structure.

#### `any`

``` purescript
any :: forall a b f. Foldable f => HeytingAlgebra b => (a -> b) -> f a -> b
```

`any f` is the same as `or <<< map f`; map a function over the structure,
and then get the disjunction of the results.

#### `and`

``` purescript
and :: forall a f. Foldable f => HeytingAlgebra a => f a -> a
```

The conjunction of all the values in a data structure. When specialized
to `Boolean`, this function will test whether all of the values in a data
structure are `true`.

#### `all`

``` purescript
all :: forall a b f. Foldable f => HeytingAlgebra b => (a -> b) -> f a -> b
```

`all f` is the same as `and <<< map f`; map a function over the structure,
and then get the conjunction of the results.

### Re-exported from Data.Traversable.Accum:

#### `Accum`

``` purescript
type Accum s a = { accum :: s, value :: a }
```


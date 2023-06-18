## Module Data.NonEmpty

This module defines a generic non-empty data structure, which adds an
additional element to any container type.

#### `NonEmpty`

``` purescript
data NonEmpty f a
  = NonEmpty a (f a)
```

A non-empty container of elements of type a.

```purescript
import Data.NonEmpty

nonEmptyArray :: NonEmpty Array Int
nonEmptyArray = NonEmpty 1 [2,3]

import Data.List(List(..), (:))

nonEmptyList :: NonEmpty List Int
nonEmptyList = NonEmpty 1 (2 : 3 : Nil)
```

##### Instances
``` purescript
(Show a, Show (f a)) => Show (NonEmpty f a)
(Eq1 f, Eq a) => Eq (NonEmpty f a)
(Eq1 f) => Eq1 (NonEmpty f)
(Ord1 f, Ord a) => Ord (NonEmpty f a)
(Ord1 f) => Ord1 (NonEmpty f)
(Functor f) => Functor (NonEmpty f)
(FunctorWithIndex i f) => FunctorWithIndex (Maybe i) (NonEmpty f)
(Foldable f) => Foldable (NonEmpty f)
(FoldableWithIndex i f) => FoldableWithIndex (Maybe i) (NonEmpty f)
(Traversable f) => Traversable (NonEmpty f)
(TraversableWithIndex i f) => TraversableWithIndex (Maybe i) (NonEmpty f)
(Foldable f) => Foldable1 (NonEmpty f)
(Unfoldable f) => Unfoldable1 (NonEmpty f)
(Applicative f, Semigroup (f a)) => Semigroup (NonEmpty f a)
```

#### `singleton`

``` purescript
singleton :: forall f a. Plus f => a -> NonEmpty f a
```

Create a non-empty structure with a single value.

```purescript
import Prelude

singleton 1 == 1 :| []
singleton 1 == 1 :| Nil
```

#### `(:|)`

``` purescript
infixr 5 NonEmpty as :|
```

An infix synonym for `NonEmpty`.

```purescript
nonEmptyArray :: NonEmpty Array Int
nonEmptyArray = 1 :| [2,3]

nonEmptyList :: NonEmpty List Int
nonEmptyList = 1 :| 2 : 3 : Nil
```

#### `foldl1`

``` purescript
foldl1 :: forall f a. Foldable f => (a -> a -> a) -> NonEmpty f a -> a
```

Fold a non-empty structure, collecting results using a binary operation.

```purescript
foldl1 (+) (1 :| [2, 3]) == 6
```

#### `fromNonEmpty`

``` purescript
fromNonEmpty :: forall f a r. (a -> f a -> r) -> NonEmpty f a -> r
```

Apply a function that takes the `first` element and remaining elements
as arguments to a non-empty container.

For example, return the remaining elements multiplied by the first element:

```purescript
fromNonEmpty (\x xs -> map (_ * x) xs) (3 :| [2, 1]) == [6, 3]
```

#### `oneOf`

``` purescript
oneOf :: forall f a. Alternative f => NonEmpty f a -> f a
```

Returns the `alt` (`<|>`) result of:
- The first element lifted to the container of the remaining elements.
- The remaining elements.

```purescript
import Data.Maybe(Maybe(..))

oneOf (1 :| Nothing) == Just 1
oneOf (1 :| Just 2) == Just 1

oneOf (1 :| [2, 3]) == [1,2,3]
```

#### `head`

``` purescript
head :: forall f a. NonEmpty f a -> a
```

Get the 'first' element of a non-empty container.

```purescript
head (1 :| [2, 3]) == 1
```

#### `tail`

``` purescript
tail :: forall f a. NonEmpty f a -> f a
```

Get everything but the 'first' element of a non-empty container.

```purescript
tail (1 :| [2, 3]) == [2, 3]
```



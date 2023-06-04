## Module Data.Array.NonEmpty.Internal

This module exports the `NonEmptyArray` constructor.

It is **NOT** intended for public use and is **NOT** versioned.

Its content may change **in any way**, **at any time** and
**without notice**.

#### `NonEmptyArray`

``` purescript
newtype NonEmptyArray a
  = NonEmptyArray (Array a)
```

An array that is known not to be empty.

You can use the constructor to create a `NonEmptyArray` that isn't
non-empty, breaking the guarantee behind this newtype. It is
provided as an escape hatch mainly for the `Data.Array.NonEmpty`
and `Data.Array` modules. Use this at your own risk when you know
what you are doing.

##### Instances
``` purescript
(Show a) => Show (NonEmptyArray a)
(Eq a) => Eq (NonEmptyArray a)
Eq1 NonEmptyArray
(Ord a) => Ord (NonEmptyArray a)
Ord1 NonEmptyArray
Semigroup (NonEmptyArray a)
Functor NonEmptyArray
FunctorWithIndex Int NonEmptyArray
Foldable NonEmptyArray
FoldableWithIndex Int NonEmptyArray
Foldable1 NonEmptyArray
Unfoldable1 NonEmptyArray
Traversable NonEmptyArray
TraversableWithIndex Int NonEmptyArray
Traversable1 NonEmptyArray
Apply NonEmptyArray
Applicative NonEmptyArray
Bind NonEmptyArray
Monad NonEmptyArray
Alt NonEmptyArray
```



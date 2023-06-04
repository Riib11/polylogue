## Module Data.List.Lazy.Types

#### `List`

``` purescript
newtype List a
  = List (Lazy (Step a))
```

A lazy linked list.

##### Instances
``` purescript
Newtype (List a) _
(Show a) => Show (List a)
(Eq a) => Eq (List a)
Eq1 List
(Ord a) => Ord (List a)
Ord1 List
Lazy (List a)
Semigroup (List a)
Monoid (List a)
Functor List
FunctorWithIndex Int List
Foldable List
FoldableWithIndex Int List
Unfoldable1 List
Unfoldable List
Traversable List
TraversableWithIndex Int List
Apply List
Applicative List
Bind List
Monad List
Alt List
Plus List
Alternative List
MonadPlus List
Extend List
```

#### `Step`

``` purescript
data Step a
  = Nil
  | Cons a (List a)
```

A list is either empty (represented by the `Nil` constructor) or non-empty, in
which case it consists of a head element, and another list (represented by the
`Cons` constructor).

##### Instances
``` purescript
(Show a) => Show (Step a)
```

#### `step`

``` purescript
step :: forall a. List a -> Step a
```

Unwrap a lazy linked list

#### `nil`

``` purescript
nil :: forall a. List a
```

The empty list.

Running time: `O(1)`

#### `cons`

``` purescript
cons :: forall a. a -> List a -> List a
```

Attach an element to the front of a lazy list.

Running time: `O(1)`

#### `(:)`

``` purescript
infixr 6 cons as :
```

An infix alias for `cons`; attaches an element to the front of
a list.

Running time: `O(1)`

#### `NonEmptyList`

``` purescript
newtype NonEmptyList a
  = NonEmptyList (Lazy (NonEmpty List a))
```

##### Instances
``` purescript
Newtype (NonEmptyList a) _
(Eq a) => Eq (NonEmptyList a)
(Ord a) => Ord (NonEmptyList a)
Eq1 NonEmptyList
Ord1 NonEmptyList
(Show a) => Show (NonEmptyList a)
Functor NonEmptyList
Apply NonEmptyList
Applicative NonEmptyList
Bind NonEmptyList
Monad NonEmptyList
Alt NonEmptyList
Extend NonEmptyList
Comonad NonEmptyList
Semigroup (NonEmptyList a)
Foldable NonEmptyList
Traversable NonEmptyList
Unfoldable1 NonEmptyList
FunctorWithIndex Int NonEmptyList
FoldableWithIndex Int NonEmptyList
TraversableWithIndex Int NonEmptyList
```

#### `toList`

``` purescript
toList :: NonEmptyList ~> List
```



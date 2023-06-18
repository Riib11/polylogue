## Module Data.List.Types

#### `List`

``` purescript
data List a
  = Nil
  | Cons a (List a)
```

##### Instances
``` purescript
(Show a) => Show (List a)
(Eq a) => Eq (List a)
Eq1 List
(Ord a) => Ord (List a)
Ord1 List
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

#### `(:)`

``` purescript
infixr 6 Cons as :
```

#### `NonEmptyList`

``` purescript
newtype NonEmptyList a
  = NonEmptyList (NonEmpty List a)
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
Foldable1 NonEmptyList
Unfoldable1 NonEmptyList
FunctorWithIndex Int NonEmptyList
FoldableWithIndex Int NonEmptyList
TraversableWithIndex Int NonEmptyList
Traversable1 NonEmptyList
```

#### `toList`

``` purescript
toList :: NonEmptyList ~> List
```

#### `nelCons`

``` purescript
nelCons :: forall a. a -> NonEmptyList a -> NonEmptyList a
```



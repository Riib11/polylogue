## Module Data.List.Lazy.NonEmpty

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f. Unfoldable f => NonEmptyList ~> f
```

#### `fromFoldable`

``` purescript
fromFoldable :: forall f a. Foldable f => f a -> Maybe (NonEmptyList a)
```

#### `fromList`

``` purescript
fromList :: forall a. List a -> Maybe (NonEmptyList a)
```

#### `toList`

``` purescript
toList :: NonEmptyList ~> List
```

#### `singleton`

``` purescript
singleton :: forall a. a -> NonEmptyList a
```

#### `repeat`

``` purescript
repeat :: forall a. a -> NonEmptyList a
```

#### `iterate`

``` purescript
iterate :: forall a. (a -> a) -> a -> NonEmptyList a
```

#### `head`

``` purescript
head :: forall a. NonEmptyList a -> a
```

#### `last`

``` purescript
last :: forall a. NonEmptyList a -> a
```

#### `tail`

``` purescript
tail :: NonEmptyList ~> List
```

#### `init`

``` purescript
init :: NonEmptyList ~> List
```

#### `cons`

``` purescript
cons :: forall a. a -> NonEmptyList a -> NonEmptyList a
```

#### `uncons`

``` purescript
uncons :: forall a. NonEmptyList a -> { head :: a, tail :: List a }
```

#### `length`

``` purescript
length :: forall a. NonEmptyList a -> Int
```

#### `concatMap`

``` purescript
concatMap :: forall a b. (a -> NonEmptyList b) -> NonEmptyList a -> NonEmptyList b
```

#### `appendFoldable`

``` purescript
appendFoldable :: forall t a. Foldable t => NonEmptyList a -> t a -> NonEmptyList a
```


### Re-exported from Data.List.Lazy.Types:

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


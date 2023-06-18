## Module Data.List.NonEmpty

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

#### `length`

``` purescript
length :: forall a. NonEmptyList a -> Int
```

#### `cons`

``` purescript
cons :: forall a. a -> NonEmptyList a -> NonEmptyList a
```

#### `cons'`

``` purescript
cons' :: forall a. a -> List a -> NonEmptyList a
```

#### `snoc`

``` purescript
snoc :: forall a. NonEmptyList a -> a -> NonEmptyList a
```

#### `snoc'`

``` purescript
snoc' :: forall a. List a -> a -> NonEmptyList a
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

#### `uncons`

``` purescript
uncons :: forall a. NonEmptyList a -> { head :: a, tail :: List a }
```

#### `unsnoc`

``` purescript
unsnoc :: forall a. NonEmptyList a -> { init :: List a, last :: a }
```

#### `(!!)`

``` purescript
infixl 8 index as !!
```

#### `index`

``` purescript
index :: forall a. NonEmptyList a -> Int -> Maybe a
```

#### `elemIndex`

``` purescript
elemIndex :: forall a. Eq a => a -> NonEmptyList a -> Maybe Int
```

#### `elemLastIndex`

``` purescript
elemLastIndex :: forall a. Eq a => a -> NonEmptyList a -> Maybe Int
```

#### `findIndex`

``` purescript
findIndex :: forall a. (a -> Boolean) -> NonEmptyList a -> Maybe Int
```

#### `findLastIndex`

``` purescript
findLastIndex :: forall a. (a -> Boolean) -> NonEmptyList a -> Maybe Int
```

#### `insertAt`

``` purescript
insertAt :: forall a. Int -> a -> NonEmptyList a -> Maybe (NonEmptyList a)
```

#### `updateAt`

``` purescript
updateAt :: forall a. Int -> a -> NonEmptyList a -> Maybe (NonEmptyList a)
```

#### `modifyAt`

``` purescript
modifyAt :: forall a. Int -> (a -> a) -> NonEmptyList a -> Maybe (NonEmptyList a)
```

#### `reverse`

``` purescript
reverse :: forall a. NonEmptyList a -> NonEmptyList a
```

#### `concat`

``` purescript
concat :: forall a. NonEmptyList (NonEmptyList a) -> NonEmptyList a
```

#### `concatMap`

``` purescript
concatMap :: forall a b. (a -> NonEmptyList b) -> NonEmptyList a -> NonEmptyList b
```

#### `filter`

``` purescript
filter :: forall a. (a -> Boolean) -> NonEmptyList a -> List a
```

#### `filterM`

``` purescript
filterM :: forall m a. Monad m => (a -> m Boolean) -> NonEmptyList a -> m (List a)
```

#### `mapMaybe`

``` purescript
mapMaybe :: forall a b. (a -> Maybe b) -> NonEmptyList a -> List b
```

#### `catMaybes`

``` purescript
catMaybes :: forall a. NonEmptyList (Maybe a) -> List a
```

#### `appendFoldable`

``` purescript
appendFoldable :: forall t a. Foldable t => NonEmptyList a -> t a -> NonEmptyList a
```

#### `sort`

``` purescript
sort :: forall a. Ord a => NonEmptyList a -> NonEmptyList a
```

#### `sortBy`

``` purescript
sortBy :: forall a. (a -> a -> Ordering) -> NonEmptyList a -> NonEmptyList a
```

#### `take`

``` purescript
take :: forall a. Int -> NonEmptyList a -> List a
```

#### `takeWhile`

``` purescript
takeWhile :: forall a. (a -> Boolean) -> NonEmptyList a -> List a
```

#### `drop`

``` purescript
drop :: forall a. Int -> NonEmptyList a -> List a
```

#### `dropWhile`

``` purescript
dropWhile :: forall a. (a -> Boolean) -> NonEmptyList a -> List a
```

#### `span`

``` purescript
span :: forall a. (a -> Boolean) -> NonEmptyList a -> { init :: List a, rest :: List a }
```

#### `group`

``` purescript
group :: forall a. Eq a => NonEmptyList a -> NonEmptyList (NonEmptyList a)
```

#### `groupAll`

``` purescript
groupAll :: forall a. Ord a => NonEmptyList a -> NonEmptyList (NonEmptyList a)
```

#### `groupBy`

``` purescript
groupBy :: forall a. (a -> a -> Boolean) -> NonEmptyList a -> NonEmptyList (NonEmptyList a)
```

#### `groupAllBy`

``` purescript
groupAllBy :: forall a. (a -> a -> Ordering) -> NonEmptyList a -> NonEmptyList (NonEmptyList a)
```

#### `partition`

``` purescript
partition :: forall a. (a -> Boolean) -> NonEmptyList a -> { no :: List a, yes :: List a }
```

#### `nub`

``` purescript
nub :: forall a. Ord a => NonEmptyList a -> NonEmptyList a
```

#### `nubBy`

``` purescript
nubBy :: forall a. (a -> a -> Ordering) -> NonEmptyList a -> NonEmptyList a
```

#### `nubEq`

``` purescript
nubEq :: forall a. Eq a => NonEmptyList a -> NonEmptyList a
```

#### `nubByEq`

``` purescript
nubByEq :: forall a. (a -> a -> Boolean) -> NonEmptyList a -> NonEmptyList a
```

#### `union`

``` purescript
union :: forall a. Eq a => NonEmptyList a -> NonEmptyList a -> NonEmptyList a
```

#### `unionBy`

``` purescript
unionBy :: forall a. (a -> a -> Boolean) -> NonEmptyList a -> NonEmptyList a -> NonEmptyList a
```

#### `intersect`

``` purescript
intersect :: forall a. Eq a => NonEmptyList a -> NonEmptyList a -> NonEmptyList a
```

#### `intersectBy`

``` purescript
intersectBy :: forall a. (a -> a -> Boolean) -> NonEmptyList a -> NonEmptyList a -> NonEmptyList a
```

#### `zipWith`

``` purescript
zipWith :: forall a b c. (a -> b -> c) -> NonEmptyList a -> NonEmptyList b -> NonEmptyList c
```

#### `zipWithA`

``` purescript
zipWithA :: forall m a b c. Applicative m => (a -> b -> m c) -> NonEmptyList a -> NonEmptyList b -> m (NonEmptyList c)
```

#### `zip`

``` purescript
zip :: forall a b. NonEmptyList a -> NonEmptyList b -> NonEmptyList (Tuple a b)
```

#### `unzip`

``` purescript
unzip :: forall a b. NonEmptyList (Tuple a b) -> Tuple (NonEmptyList a) (NonEmptyList b)
```

#### `foldM`

``` purescript
foldM :: forall m a b. Monad m => (b -> a -> m b) -> b -> NonEmptyList a -> m b
```


### Re-exported from Data.Foldable:

#### `foldMap`

``` purescript
foldMap :: forall f a m. Foldable f => Monoid m => (a -> m) -> f a -> m
```

#### `foldl`

``` purescript
foldl :: forall f a b. Foldable f => (b -> a -> b) -> b -> f a -> b
```

#### `foldr`

``` purescript
foldr :: forall f a b. Foldable f => (a -> b -> b) -> b -> f a -> b
```

#### `notElem`

``` purescript
notElem :: forall a f. Foldable f => Eq a => a -> f a -> Boolean
```

Test whether a value is not an element of a data structure.

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

#### `fold`

``` purescript
fold :: forall f m. Foldable f => Monoid m => f m -> m
```

Fold a data structure, accumulating values in some `Monoid`.

#### `findMap`

``` purescript
findMap :: forall a b f. Foldable f => (a -> Maybe b) -> f a -> Maybe b
```

Try to find an element in a data structure which satisfies a predicate mapping.

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

#### `all`

``` purescript
all :: forall a b f. Foldable f => HeytingAlgebra b => (a -> b) -> f a -> b
```

`all f` is the same as `and <<< map f`; map a function over the structure,
and then get the conjunction of the results.

### Re-exported from Data.List.Types:

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

### Re-exported from Data.Semigroup.Foldable:

#### `foldMap1`

``` purescript
foldMap1 :: forall t a m. Foldable1 t => Semigroup m => (a -> m) -> t a -> m
```

#### `traverse1_`

``` purescript
traverse1_ :: forall t f a b. Foldable1 t => Apply f => (a -> f b) -> t a -> f Unit
```

Traverse a data structure, performing some effects encoded by an
`Apply` instance at each value, ignoring the final result.

#### `sequence1_`

``` purescript
sequence1_ :: forall t f a. Foldable1 t => Apply f => t (f a) -> f Unit
```

Perform all of the effects in some data structure in the order
given by the `Foldable1` instance, ignoring the final result.

#### `for1_`

``` purescript
for1_ :: forall t f a b. Foldable1 t => Apply f => t a -> (a -> f b) -> f Unit
```

A version of `traverse1_` with its arguments flipped.

This can be useful when running an action written using do notation
for every element in a data structure:

#### `fold1`

``` purescript
fold1 :: forall t m. Foldable1 t => Semigroup m => t m -> m
```

Fold a data structure, accumulating values in some `Semigroup`.

### Re-exported from Data.Semigroup.Traversable:

#### `sequence1`

``` purescript
sequence1 :: forall t b f. Traversable1 t => Apply f => t (f b) -> f (t b)
```

#### `traverse1`

``` purescript
traverse1 :: forall t a b f. Traversable1 t => Apply f => (a -> f b) -> t a -> f (t b)
```

#### `traverse1Default`

``` purescript
traverse1Default :: forall t a b m. Traversable1 t => Apply m => (a -> m b) -> t a -> m (t b)
```

A default implementation of `traverse1` using `sequence1`.

### Re-exported from Data.Traversable:

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


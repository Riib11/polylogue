## Module Data.Array.NonEmpty

#### `fromArray`

``` purescript
fromArray :: forall a. Array a -> Maybe (NonEmptyArray a)
```

#### `fromNonEmpty`

``` purescript
fromNonEmpty :: forall a. NonEmpty Array a -> NonEmptyArray a
```

#### `toArray`

``` purescript
toArray :: forall a. NonEmptyArray a -> Array a
```

#### `toNonEmpty`

``` purescript
toNonEmpty :: forall a. NonEmptyArray a -> NonEmpty Array a
```

#### `fromFoldable`

``` purescript
fromFoldable :: forall f a. Foldable f => f a -> Maybe (NonEmptyArray a)
```

#### `fromFoldable1`

``` purescript
fromFoldable1 :: forall f a. Foldable1 f => f a -> NonEmptyArray a
```

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f a. Unfoldable f => NonEmptyArray a -> f a
```

#### `toUnfoldable1`

``` purescript
toUnfoldable1 :: forall f a. Unfoldable1 f => NonEmptyArray a -> f a
```

#### `singleton`

``` purescript
singleton :: forall a. a -> NonEmptyArray a
```

#### `(..)`

``` purescript
infix 8 range as ..
```

#### `range`

``` purescript
range :: Int -> Int -> NonEmptyArray Int
```

#### `replicate`

``` purescript
replicate :: forall a. Int -> a -> NonEmptyArray a
```

Replicate an item at least once

#### `some`

``` purescript
some :: forall f a. Alternative f => Lazy (f (Array a)) => f a -> f (NonEmptyArray a)
```

#### `length`

``` purescript
length :: forall a. NonEmptyArray a -> Int
```

#### `(:)`

``` purescript
infixr 6 cons as :
```

#### `cons`

``` purescript
cons :: forall a. a -> NonEmptyArray a -> NonEmptyArray a
```

#### `cons'`

``` purescript
cons' :: forall a. a -> Array a -> NonEmptyArray a
```

#### `snoc`

``` purescript
snoc :: forall a. NonEmptyArray a -> a -> NonEmptyArray a
```

#### `snoc'`

``` purescript
snoc' :: forall a. Array a -> a -> NonEmptyArray a
```

#### `appendArray`

``` purescript
appendArray :: forall a. NonEmptyArray a -> Array a -> NonEmptyArray a
```

#### `prependArray`

``` purescript
prependArray :: forall a. Array a -> NonEmptyArray a -> NonEmptyArray a
```

#### `insert`

``` purescript
insert :: forall a. Ord a => a -> NonEmptyArray a -> NonEmptyArray a
```

#### `insertBy`

``` purescript
insertBy :: forall a. (a -> a -> Ordering) -> a -> NonEmptyArray a -> NonEmptyArray a
```

#### `head`

``` purescript
head :: forall a. NonEmptyArray a -> a
```

#### `last`

``` purescript
last :: forall a. NonEmptyArray a -> a
```

#### `tail`

``` purescript
tail :: forall a. NonEmptyArray a -> Array a
```

#### `init`

``` purescript
init :: forall a. NonEmptyArray a -> Array a
```

#### `uncons`

``` purescript
uncons :: forall a. NonEmptyArray a -> { head :: a, tail :: Array a }
```

#### `unsnoc`

``` purescript
unsnoc :: forall a. NonEmptyArray a -> { init :: Array a, last :: a }
```

#### `(!!)`

``` purescript
infixl 8 index as !!
```

#### `index`

``` purescript
index :: forall a. NonEmptyArray a -> Int -> Maybe a
```

#### `elem`

``` purescript
elem :: forall a. Eq a => a -> NonEmptyArray a -> Boolean
```

#### `notElem`

``` purescript
notElem :: forall a. Eq a => a -> NonEmptyArray a -> Boolean
```

#### `elemIndex`

``` purescript
elemIndex :: forall a. Eq a => a -> NonEmptyArray a -> Maybe Int
```

#### `elemLastIndex`

``` purescript
elemLastIndex :: forall a. Eq a => a -> NonEmptyArray a -> Maybe Int
```

#### `find`

``` purescript
find :: forall a. (a -> Boolean) -> NonEmptyArray a -> Maybe a
```

#### `findMap`

``` purescript
findMap :: forall a b. (a -> Maybe b) -> NonEmptyArray a -> Maybe b
```

#### `findIndex`

``` purescript
findIndex :: forall a. (a -> Boolean) -> NonEmptyArray a -> Maybe Int
```

#### `findLastIndex`

``` purescript
findLastIndex :: forall a. (a -> Boolean) -> NonEmptyArray a -> Maybe Int
```

#### `insertAt`

``` purescript
insertAt :: forall a. Int -> a -> NonEmptyArray a -> Maybe (NonEmptyArray a)
```

#### `deleteAt`

``` purescript
deleteAt :: forall a. Int -> NonEmptyArray a -> Maybe (Array a)
```

#### `updateAt`

``` purescript
updateAt :: forall a. Int -> a -> NonEmptyArray a -> Maybe (NonEmptyArray a)
```

#### `updateAtIndices`

``` purescript
updateAtIndices :: forall t a. Foldable t => t (Tuple Int a) -> NonEmptyArray a -> NonEmptyArray a
```

#### `modifyAt`

``` purescript
modifyAt :: forall a. Int -> (a -> a) -> NonEmptyArray a -> Maybe (NonEmptyArray a)
```

#### `modifyAtIndices`

``` purescript
modifyAtIndices :: forall t a. Foldable t => t Int -> (a -> a) -> NonEmptyArray a -> NonEmptyArray a
```

#### `alterAt`

``` purescript
alterAt :: forall a. Int -> (a -> Maybe a) -> NonEmptyArray a -> Maybe (Array a)
```

#### `intersperse`

``` purescript
intersperse :: forall a. a -> NonEmptyArray a -> NonEmptyArray a
```

#### `reverse`

``` purescript
reverse :: forall a. NonEmptyArray a -> NonEmptyArray a
```

#### `concat`

``` purescript
concat :: forall a. NonEmptyArray (NonEmptyArray a) -> NonEmptyArray a
```

#### `concatMap`

``` purescript
concatMap :: forall a b. (a -> NonEmptyArray b) -> NonEmptyArray a -> NonEmptyArray b
```

#### `filter`

``` purescript
filter :: forall a. (a -> Boolean) -> NonEmptyArray a -> Array a
```

#### `partition`

``` purescript
partition :: forall a. (a -> Boolean) -> NonEmptyArray a -> { no :: Array a, yes :: Array a }
```

#### `splitAt`

``` purescript
splitAt :: forall a. Int -> NonEmptyArray a -> { after :: Array a, before :: Array a }
```

#### `filterA`

``` purescript
filterA :: forall a f. Applicative f => (a -> f Boolean) -> NonEmptyArray a -> f (Array a)
```

#### `mapMaybe`

``` purescript
mapMaybe :: forall a b. (a -> Maybe b) -> NonEmptyArray a -> Array b
```

#### `catMaybes`

``` purescript
catMaybes :: forall a. NonEmptyArray (Maybe a) -> Array a
```

#### `mapWithIndex`

``` purescript
mapWithIndex :: forall a b. (Int -> a -> b) -> NonEmptyArray a -> NonEmptyArray b
```

#### `foldl1`

``` purescript
foldl1 :: forall a. (a -> a -> a) -> NonEmptyArray a -> a
```

#### `foldr1`

``` purescript
foldr1 :: forall a. (a -> a -> a) -> NonEmptyArray a -> a
```

#### `foldMap1`

``` purescript
foldMap1 :: forall a m. Semigroup m => (a -> m) -> NonEmptyArray a -> m
```

#### `fold1`

``` purescript
fold1 :: forall m. Semigroup m => NonEmptyArray m -> m
```

#### `intercalate`

``` purescript
intercalate :: forall a. Semigroup a => a -> NonEmptyArray a -> a
```

#### `transpose`

``` purescript
transpose :: forall a. NonEmptyArray (NonEmptyArray a) -> NonEmptyArray (NonEmptyArray a)
```

The 'transpose' function transposes the rows and columns of its argument.
For example,

```purescript
transpose 
  (NonEmptyArray [ NonEmptyArray [1, 2, 3]
                 , NonEmptyArray [4, 5, 6]
                 ]) == 
  (NonEmptyArray [ NonEmptyArray [1, 4]
                 , NonEmptyArray [2, 5]
                 , NonEmptyArray [3, 6]
                 ])
```

If some of the rows are shorter than the following rows, their elements are skipped:

```purescript
transpose 
  (NonEmptyArray [ NonEmptyArray [10, 11]
                 , NonEmptyArray [20]
                 , NonEmptyArray [30, 31, 32]
                 ]) == 
  (NomEmptyArray [ NonEmptyArray [10, 20, 30]
                 , NonEmptyArray [11, 31]
                 , NonEmptyArray [32]
                 ])
```

#### `transpose'`

``` purescript
transpose' :: forall a. NonEmptyArray (Array a) -> Maybe (NonEmptyArray (Array a))
```

`transpose`' is identical to `transpose` other than that the inner arrays are each
a standard `Array` and not a `NonEmptyArray`. However, the result is wrapped in a 
`Maybe` to cater for the case where the inner `Array` is empty and must return `Nothing`.

#### `scanl`

``` purescript
scanl :: forall a b. (b -> a -> b) -> b -> NonEmptyArray a -> NonEmptyArray b
```

#### `scanr`

``` purescript
scanr :: forall a b. (a -> b -> b) -> b -> NonEmptyArray a -> NonEmptyArray b
```

#### `sort`

``` purescript
sort :: forall a. Ord a => NonEmptyArray a -> NonEmptyArray a
```

#### `sortBy`

``` purescript
sortBy :: forall a. (a -> a -> Ordering) -> NonEmptyArray a -> NonEmptyArray a
```

#### `sortWith`

``` purescript
sortWith :: forall a b. Ord b => (a -> b) -> NonEmptyArray a -> NonEmptyArray a
```

#### `slice`

``` purescript
slice :: forall a. Int -> Int -> NonEmptyArray a -> Array a
```

#### `take`

``` purescript
take :: forall a. Int -> NonEmptyArray a -> Array a
```

#### `takeEnd`

``` purescript
takeEnd :: forall a. Int -> NonEmptyArray a -> Array a
```

#### `takeWhile`

``` purescript
takeWhile :: forall a. (a -> Boolean) -> NonEmptyArray a -> Array a
```

#### `drop`

``` purescript
drop :: forall a. Int -> NonEmptyArray a -> Array a
```

#### `dropEnd`

``` purescript
dropEnd :: forall a. Int -> NonEmptyArray a -> Array a
```

#### `dropWhile`

``` purescript
dropWhile :: forall a. (a -> Boolean) -> NonEmptyArray a -> Array a
```

#### `span`

``` purescript
span :: forall a. (a -> Boolean) -> NonEmptyArray a -> { init :: Array a, rest :: Array a }
```

#### `group`

``` purescript
group :: forall a. Eq a => NonEmptyArray a -> NonEmptyArray (NonEmptyArray a)
```

Group equal, consecutive elements of an array into arrays.

```purescript
group (NonEmptyArray [1, 1, 2, 2, 1]) ==
  NonEmptyArray [NonEmptyArray [1, 1], NonEmptyArray [2, 2], NonEmptyArray [1]]
```

#### `groupAll`

``` purescript
groupAll :: forall a. Ord a => NonEmptyArray a -> NonEmptyArray (NonEmptyArray a)
```

Group equal elements of an array into arrays.

```purescript
groupAll (NonEmptyArray [1, 1, 2, 2, 1]) ==
  NonEmptyArray [NonEmptyArray [1, 1, 1], NonEmptyArray [2, 2]]
`

#### `groupBy`

``` purescript
groupBy :: forall a. (a -> a -> Boolean) -> NonEmptyArray a -> NonEmptyArray (NonEmptyArray a)
```

Group equal, consecutive elements of an array into arrays, using the
specified equivalence relation to determine equality.

```purescript
groupBy (\a b -> odd a && odd b) (NonEmptyArray [1, 3, 2, 4, 3, 3])
   = NonEmptyArray [NonEmptyArray [1, 3], NonEmptyArray [2], NonEmptyArray [4], NonEmptyArray [3, 3]]
```


#### `groupAllBy`

``` purescript
groupAllBy :: forall a. (a -> a -> Ordering) -> NonEmptyArray a -> NonEmptyArray (NonEmptyArray a)
```

Group equal elements of an array into arrays, using the specified
comparison function to determine equality.

```purescript
groupAllBy (comparing Down) (NonEmptyArray [1, 3, 2, 4, 3, 3])
   = NonEmptyArray [NonEmptyArray [4], NonEmptyArray [3, 3, 3], NonEmptyArray [2], NonEmptyArray [1]]
```

#### `nub`

``` purescript
nub :: forall a. Ord a => NonEmptyArray a -> NonEmptyArray a
```

#### `nubBy`

``` purescript
nubBy :: forall a. (a -> a -> Ordering) -> NonEmptyArray a -> NonEmptyArray a
```

#### `nubEq`

``` purescript
nubEq :: forall a. Eq a => NonEmptyArray a -> NonEmptyArray a
```

#### `nubByEq`

``` purescript
nubByEq :: forall a. (a -> a -> Boolean) -> NonEmptyArray a -> NonEmptyArray a
```

#### `union`

``` purescript
union :: forall a. Eq a => NonEmptyArray a -> NonEmptyArray a -> NonEmptyArray a
```

#### `union'`

``` purescript
union' :: forall a. Eq a => NonEmptyArray a -> Array a -> NonEmptyArray a
```

#### `unionBy`

``` purescript
unionBy :: forall a. (a -> a -> Boolean) -> NonEmptyArray a -> NonEmptyArray a -> NonEmptyArray a
```

#### `unionBy'`

``` purescript
unionBy' :: forall a. (a -> a -> Boolean) -> NonEmptyArray a -> Array a -> NonEmptyArray a
```

#### `delete`

``` purescript
delete :: forall a. Eq a => a -> NonEmptyArray a -> Array a
```

#### `deleteBy`

``` purescript
deleteBy :: forall a. (a -> a -> Boolean) -> a -> NonEmptyArray a -> Array a
```

#### `(\\)`

``` purescript
infix 5 difference as \\
```

#### `difference`

``` purescript
difference :: forall a. Eq a => NonEmptyArray a -> NonEmptyArray a -> Array a
```

#### `difference'`

``` purescript
difference' :: forall a. Eq a => NonEmptyArray a -> Array a -> Array a
```

#### `intersect`

``` purescript
intersect :: forall a. Eq a => NonEmptyArray a -> NonEmptyArray a -> Array a
```

#### `intersect'`

``` purescript
intersect' :: forall a. Eq a => NonEmptyArray a -> Array a -> Array a
```

#### `intersectBy`

``` purescript
intersectBy :: forall a. (a -> a -> Boolean) -> NonEmptyArray a -> NonEmptyArray a -> Array a
```

#### `intersectBy'`

``` purescript
intersectBy' :: forall a. (a -> a -> Boolean) -> NonEmptyArray a -> Array a -> Array a
```

#### `zipWith`

``` purescript
zipWith :: forall a b c. (a -> b -> c) -> NonEmptyArray a -> NonEmptyArray b -> NonEmptyArray c
```

#### `zipWithA`

``` purescript
zipWithA :: forall m a b c. Applicative m => (a -> b -> m c) -> NonEmptyArray a -> NonEmptyArray b -> m (NonEmptyArray c)
```

#### `zip`

``` purescript
zip :: forall a b. NonEmptyArray a -> NonEmptyArray b -> NonEmptyArray (Tuple a b)
```

#### `unzip`

``` purescript
unzip :: forall a b. NonEmptyArray (Tuple a b) -> Tuple (NonEmptyArray a) (NonEmptyArray b)
```

#### `any`

``` purescript
any :: forall a. (a -> Boolean) -> NonEmptyArray a -> Boolean
```

#### `all`

``` purescript
all :: forall a. (a -> Boolean) -> NonEmptyArray a -> Boolean
```

#### `foldM`

``` purescript
foldM :: forall m a b. Monad m => (b -> a -> m b) -> b -> NonEmptyArray a -> m b
```

#### `foldRecM`

``` purescript
foldRecM :: forall m a b. MonadRec m => (b -> a -> m b) -> b -> NonEmptyArray a -> m b
```

#### `unsafeIndex`

``` purescript
unsafeIndex :: forall a. Partial => NonEmptyArray a -> Int -> a
```


### Re-exported from Data.Array.NonEmpty.Internal:

#### `NonEmptyArray`

``` purescript
newtype NonEmptyArray a
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


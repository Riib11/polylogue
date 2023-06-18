## Module Data.List

This module defines a type of _strict_ linked lists, and associated helper
functions and type class instances.

_Note_: Depending on your use-case, you may prefer to use
`Data.Sequence` instead, which might give better performance for certain
use cases. This module is an improvement over `Data.Array` when working with
immutable lists of data in a purely-functional setting, but does not have
good random-access performance.

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f. Unfoldable f => List ~> f
```

Convert a list into any unfoldable structure.

Running time: `O(n)`

#### `fromFoldable`

``` purescript
fromFoldable :: forall f. Foldable f => f ~> List
```

Construct a list from a foldable structure.

Running time: `O(n)`

#### `singleton`

``` purescript
singleton :: forall a. a -> List a
```

Create a list with a single element.

Running time: `O(1)`

#### `(..)`

``` purescript
infix 8 range as ..
```

An infix synonym for `range`.

#### `range`

``` purescript
range :: Int -> Int -> List Int
```

Create a list containing a range of integers, including both endpoints.

#### `some`

``` purescript
some :: forall f a. Alternative f => Lazy (f (List a)) => f a -> f (List a)
```

Attempt a computation multiple times, requiring at least one success.

The `Lazy` constraint is used to generate the result lazily, to ensure
termination.

#### `someRec`

``` purescript
someRec :: forall f a. MonadRec f => Alternative f => f a -> f (List a)
```

A stack-safe version of `some`, at the cost of a `MonadRec` constraint.

#### `many`

``` purescript
many :: forall f a. Alternative f => Lazy (f (List a)) => f a -> f (List a)
```

Attempt a computation multiple times, returning as many successful results
as possible (possibly zero).

The `Lazy` constraint is used to generate the result lazily, to ensure
termination.

#### `manyRec`

``` purescript
manyRec :: forall f a. MonadRec f => Alternative f => f a -> f (List a)
```

A stack-safe version of `many`, at the cost of a `MonadRec` constraint.

#### `null`

``` purescript
null :: forall a. List a -> Boolean
```

Test whether a list is empty.

Running time: `O(1)`

#### `length`

``` purescript
length :: forall a. List a -> Int
```

Get the length of a list

Running time: `O(n)`

#### `snoc`

``` purescript
snoc :: forall a. List a -> a -> List a
```

Append an element to the end of a list, creating a new list.

Running time: `O(n)`

#### `insert`

``` purescript
insert :: forall a. Ord a => a -> List a -> List a
```

Insert an element into a sorted list.

Running time: `O(n)`

#### `insertBy`

``` purescript
insertBy :: forall a. (a -> a -> Ordering) -> a -> List a -> List a
```

Insert an element into a sorted list, using the specified function to
determine the ordering of elements.

Running time: `O(n)`

#### `head`

``` purescript
head :: List ~> Maybe
```

Get the first element in a list, or `Nothing` if the list is empty.

Running time: `O(1)`.

#### `last`

``` purescript
last :: List ~> Maybe
```

Get the last element in a list, or `Nothing` if the list is empty.

Running time: `O(n)`.

#### `tail`

``` purescript
tail :: forall a. List a -> Maybe (List a)
```

Get all but the first element of a list, or `Nothing` if the list is empty.

Running time: `O(1)`

#### `init`

``` purescript
init :: forall a. List a -> Maybe (List a)
```

Get all but the last element of a list, or `Nothing` if the list is empty.

Running time: `O(n)`

#### `uncons`

``` purescript
uncons :: forall a. List a -> Maybe { head :: a, tail :: List a }
```

Break a list into its first element, and the remaining elements,
or `Nothing` if the list is empty.

Running time: `O(1)`

#### `unsnoc`

``` purescript
unsnoc :: forall a. List a -> Maybe { init :: List a, last :: a }
```

Break a list into its last element, and the preceding elements,
or `Nothing` if the list is empty.

Running time: `O(n)`

#### `(!!)`

``` purescript
infixl 8 index as !!
```

An infix synonym for `index`.

#### `index`

``` purescript
index :: forall a. List a -> Int -> Maybe a
```

Get the element at the specified index, or `Nothing` if the index is out-of-bounds.

Running time: `O(n)` where `n` is the required index.

#### `elemIndex`

``` purescript
elemIndex :: forall a. Eq a => a -> List a -> Maybe Int
```

Find the index of the first element equal to the specified element.

#### `elemLastIndex`

``` purescript
elemLastIndex :: forall a. Eq a => a -> List a -> Maybe Int
```

Find the index of the last element equal to the specified element.

#### `findIndex`

``` purescript
findIndex :: forall a. (a -> Boolean) -> List a -> Maybe Int
```

Find the first index for which a predicate holds.

#### `findLastIndex`

``` purescript
findLastIndex :: forall a. (a -> Boolean) -> List a -> Maybe Int
```

Find the last index for which a predicate holds.

#### `insertAt`

``` purescript
insertAt :: forall a. Int -> a -> List a -> Maybe (List a)
```

Insert an element into a list at the specified index, returning a new
list or `Nothing` if the index is out-of-bounds.

Running time: `O(n)`

#### `deleteAt`

``` purescript
deleteAt :: forall a. Int -> List a -> Maybe (List a)
```

Delete an element from a list at the specified index, returning a new
list or `Nothing` if the index is out-of-bounds.

Running time: `O(n)`

#### `updateAt`

``` purescript
updateAt :: forall a. Int -> a -> List a -> Maybe (List a)
```

Update the element at the specified index, returning a new
list or `Nothing` if the index is out-of-bounds.

Running time: `O(n)`

#### `modifyAt`

``` purescript
modifyAt :: forall a. Int -> (a -> a) -> List a -> Maybe (List a)
```

Update the element at the specified index by applying a function to
the current value, returning a new list or `Nothing` if the index is
out-of-bounds.

Running time: `O(n)`

#### `alterAt`

``` purescript
alterAt :: forall a. Int -> (a -> Maybe a) -> List a -> Maybe (List a)
```

Update or delete the element at the specified index by applying a
function to the current value, returning a new list or `Nothing` if the
index is out-of-bounds.

Running time: `O(n)`

#### `reverse`

``` purescript
reverse :: List ~> List
```

Reverse a list.

Running time: `O(n)`

#### `concat`

``` purescript
concat :: forall a. List (List a) -> List a
```

Flatten a list of lists.

Running time: `O(n)`, where `n` is the total number of elements.

#### `concatMap`

``` purescript
concatMap :: forall a b. (a -> List b) -> List a -> List b
```

Apply a function to each element in a list, and flatten the results
into a single, new list.

Running time: `O(n)`, where `n` is the total number of elements.

#### `filter`

``` purescript
filter :: forall a. (a -> Boolean) -> List a -> List a
```

Filter a list, keeping the elements which satisfy a predicate function.

Running time: `O(n)`

#### `filterM`

``` purescript
filterM :: forall a m. Monad m => (a -> m Boolean) -> List a -> m (List a)
```

Filter where the predicate returns a monadic `Boolean`.

For example:

```purescript
powerSet :: forall a. [a] -> [[a]]
powerSet = filterM (const [true, false])
```

#### `mapMaybe`

``` purescript
mapMaybe :: forall a b. (a -> Maybe b) -> List a -> List b
```

Apply a function to each element in a list, keeping only the results which
contain a value.

Running time: `O(n)`

#### `catMaybes`

``` purescript
catMaybes :: forall a. List (Maybe a) -> List a
```

Filter a list of optional values, keeping only the elements which contain
a value.

#### `sort`

``` purescript
sort :: forall a. Ord a => List a -> List a
```

Sort the elements of an list in increasing order.

#### `sortBy`

``` purescript
sortBy :: forall a. (a -> a -> Ordering) -> List a -> List a
```

Sort the elements of a list in increasing order, where elements are
compared using the specified ordering.

#### `Pattern`

``` purescript
newtype Pattern a
  = Pattern (List a)
```

A newtype used in cases where there is a list to be matched.

##### Instances
``` purescript
(Eq a) => Eq (Pattern a)
(Ord a) => Ord (Pattern a)
Newtype (Pattern a) _
(Show a) => Show (Pattern a)
```

#### `stripPrefix`

``` purescript
stripPrefix :: forall a. Eq a => Pattern a -> List a -> Maybe (List a)
```

If the list starts with the given prefix, return the portion of the
list left after removing it, as a Just value. Otherwise, return Nothing.
* `stripPrefix (Pattern (1:Nil)) (1:2:Nil) == Just (2:Nil)`
* `stripPrefix (Pattern Nil) (1:Nil) == Just (1:Nil)`
* `stripPrefix (Pattern (2:Nil)) (1:Nil) == Nothing`

Running time: `O(n)` where `n` is the number of elements to strip.

#### `slice`

``` purescript
slice :: Int -> Int -> List ~> List
```

Extract a sublist by a start and end index.

#### `take`

``` purescript
take :: forall a. Int -> List a -> List a
```

Take the specified number of elements from the front of a list.

Running time: `O(n)` where `n` is the number of elements to take.

#### `takeEnd`

``` purescript
takeEnd :: forall a. Int -> List a -> List a
```

Take the specified number of elements from the end of a list.

Running time: `O(2n - m)` where `n` is the number of elements in list
and `m` is number of elements to take.

#### `takeWhile`

``` purescript
takeWhile :: forall a. (a -> Boolean) -> List a -> List a
```

Take those elements from the front of a list which match a predicate.

Running time (worst case): `O(n)`

#### `drop`

``` purescript
drop :: forall a. Int -> List a -> List a
```

Drop the specified number of elements from the front of a list.

Running time: `O(n)` where `n` is the number of elements to drop.

#### `dropEnd`

``` purescript
dropEnd :: forall a. Int -> List a -> List a
```

Drop the specified number of elements from the end of a list.

Running time: `O(2n - m)` where `n` is the number of elements in list
and `m` is number of elements to drop.

#### `dropWhile`

``` purescript
dropWhile :: forall a. (a -> Boolean) -> List a -> List a
```

Drop those elements from the front of a list which match a predicate.

Running time (worst case): `O(n)`

#### `span`

``` purescript
span :: forall a. (a -> Boolean) -> List a -> { init :: List a, rest :: List a }
```

Split a list into two parts:

1. the longest initial segment for which all elements satisfy the specified predicate
2. the remaining elements

For example,

```purescript
span (\n -> n % 2 == 1) (1 : 3 : 2 : 4 : 5 : Nil) == { init: (1 : 3 : Nil), rest: (2 : 4 : 5 : Nil) }
```

Running time: `O(n)`

#### `group`

``` purescript
group :: forall a. Eq a => List a -> List (NonEmptyList a)
```

Group equal, consecutive elements of a list into lists.

For example,

```purescript
group (1 : 1 : 2 : 2 : 1 : Nil) ==
  (NonEmptyList (NonEmpty 1 (1 : Nil))) : (NonEmptyList (NonEmpty 2 (2 : Nil))) : (NonEmptyList (NonEmpty 1 Nil)) : Nil
```

Running time: `O(n)`

#### `groupAll`

``` purescript
groupAll :: forall a. Ord a => List a -> List (NonEmptyList a)
```

Group equal elements of a list into lists.

For example,

```purescript
groupAll (1 : 1 : 2 : 2 : 1 : Nil) ==
  (NonEmptyList (NonEmpty 1 (1 : 1 : Nil))) : (NonEmptyList (NonEmpty 2 (2 : Nil))) : Nil
```

#### `groupBy`

``` purescript
groupBy :: forall a. (a -> a -> Boolean) -> List a -> List (NonEmptyList a)
```

Group equal, consecutive elements of a list into lists, using the specified
equivalence relation to determine equality.

For example,

```purescript
groupBy (\a b -> odd a && odd b) (1 : 3 : 2 : 4 : 3 : 3 : Nil) ==
  (NonEmptyList (NonEmpty 1 (3 : Nil))) : (NonEmptyList (NonEmpty 2 Nil)) : (NonEmptyList (NonEmpty 4 Nil)) : (NonEmptyList (NonEmpty 3 (3 : Nil))) : Nil
```

Running time: `O(n)`

#### `groupAllBy`

``` purescript
groupAllBy :: forall a. (a -> a -> Ordering) -> List a -> List (NonEmptyList a)
```

Sort, then group equal elements of a list into lists, using the provided comparison function.

```purescript
groupAllBy (compare `on` (_ `div` 10)) (32 : 31 : 21 : 22 : 11 : 33 : Nil) ==
  NonEmptyList (11 :| Nil) : NonEmptyList (21 :| 22 : Nil) : NonEmptyList (32 :| 31 : 33) : Nil
```

Running time: `O(n log n)`

#### `partition`

``` purescript
partition :: forall a. (a -> Boolean) -> List a -> { no :: List a, yes :: List a }
```

Returns a lists of elements which do and do not satisfy a predicate.

Running time: `O(n)`

#### `nub`

``` purescript
nub :: forall a. Ord a => List a -> List a
```

Remove duplicate elements from a list.
Keeps the first occurrence of each element in the input list,
in the same order they appear in the input list.

```purescript
nub 1:2:1:3:3:Nil == 1:2:3:Nil
```

Running time: `O(n log n)`

#### `nubBy`

``` purescript
nubBy :: forall a. (a -> a -> Ordering) -> List a -> List a
```

Remove duplicate elements from a list based on the provided comparison function.
Keeps the first occurrence of each element in the input list,
in the same order they appear in the input list.

```purescript
nubBy (compare `on` Array.length) ([1]:[2]:[3,4]:Nil) == [1]:[3,4]:Nil
```

Running time: `O(n log n)`

#### `nubEq`

``` purescript
nubEq :: forall a. Eq a => List a -> List a
```

Remove duplicate elements from a list.
Keeps the first occurrence of each element in the input list,
in the same order they appear in the input list.
This less efficient version of `nub` only requires an `Eq` instance.

```purescript
nubEq 1:2:1:3:3:Nil == 1:2:3:Nil
```

Running time: `O(n^2)`

#### `nubByEq`

``` purescript
nubByEq :: forall a. (a -> a -> Boolean) -> List a -> List a
```

Remove duplicate elements from a list, using the provided equivalence function.
Keeps the first occurrence of each element in the input list,
in the same order they appear in the input list.
This less efficient version of `nubBy` only requires an equivalence
function, rather than an ordering function.

```purescript
mod3eq = eq `on` \n -> mod n 3
nubByEq mod3eq 1:3:4:5:6:Nil == 1:3:5:Nil
```

Running time: `O(n^2)`

#### `union`

``` purescript
union :: forall a. Eq a => List a -> List a -> List a
```

Calculate the union of two lists.

Running time: `O(n^2)`

#### `unionBy`

``` purescript
unionBy :: forall a. (a -> a -> Boolean) -> List a -> List a -> List a
```

Calculate the union of two lists, using the specified
function to determine equality of elements.

Running time: `O(n^2)`

#### `delete`

``` purescript
delete :: forall a. Eq a => a -> List a -> List a
```

Delete the first occurrence of an element from a list.

Running time: `O(n)`

#### `deleteBy`

``` purescript
deleteBy :: forall a. (a -> a -> Boolean) -> a -> List a -> List a
```

Delete the first occurrence of an element from a list, using the specified
function to determine equality of elements.

Running time: `O(n)`

#### `(\\)`

``` purescript
infix 5 difference as \\
```

#### `difference`

``` purescript
difference :: forall a. Eq a => List a -> List a -> List a
```

Delete the first occurrence of each element in the second list from the first list.

Running time: `O(n^2)`

#### `intersect`

``` purescript
intersect :: forall a. Eq a => List a -> List a -> List a
```

Calculate the intersection of two lists.

Running time: `O(n^2)`

#### `intersectBy`

``` purescript
intersectBy :: forall a. (a -> a -> Boolean) -> List a -> List a -> List a
```

Calculate the intersection of two lists, using the specified
function to determine equality of elements.

Running time: `O(n^2)`

#### `zipWith`

``` purescript
zipWith :: forall a b c. (a -> b -> c) -> List a -> List b -> List c
```

Apply a function to pairs of elements at the same positions in two lists,
collecting the results in a new list.

If one list is longer, elements will be discarded from the longer list.

For example

```purescript
zipWith (*) (1 : 2 : 3 : Nil) (4 : 5 : 6 : 7 Nil) == 4 : 10 : 18 : Nil
```

Running time: `O(min(m, n))`

#### `zipWithA`

``` purescript
zipWithA :: forall m a b c. Applicative m => (a -> b -> m c) -> List a -> List b -> m (List c)
```

A generalization of `zipWith` which accumulates results in some `Applicative`
functor.

#### `zip`

``` purescript
zip :: forall a b. List a -> List b -> List (Tuple a b)
```

Collect pairs of elements at the same positions in two lists.

Running time: `O(min(m, n))`

#### `unzip`

``` purescript
unzip :: forall a b. List (Tuple a b) -> Tuple (List a) (List b)
```

Transforms a list of pairs into a list of first components and a list of
second components.

#### `transpose`

``` purescript
transpose :: forall a. List (List a) -> List (List a)
```

The 'transpose' function transposes the rows and columns of its argument.
For example,

    transpose ((1:2:3:Nil) : (4:5:6:Nil) : Nil) ==
      ((1:4:Nil) : (2:5:Nil) : (3:6:Nil) : Nil)

If some of the rows are shorter than the following rows, their elements are skipped:

    transpose ((10:11:Nil) : (20:Nil) : Nil : (30:31:32:Nil) : Nil) ==
      ((10:20:30:Nil) : (11:31:Nil) : (32:Nil) : Nil)

#### `foldM`

``` purescript
foldM :: forall m a b. Monad m => (b -> a -> m b) -> b -> List a -> m b
```

Perform a fold using a monadic step function.


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


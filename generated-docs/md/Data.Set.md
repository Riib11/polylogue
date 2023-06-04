## Module Data.Set

This module defines a type of sets as balanced 2-3 trees, based on
<http://www.cs.princeton.edu/~dpw/courses/cos326-12/ass/2-3-trees.pdf>

Qualified import is encouraged, so as to avoid name clashes with other modules.

#### `Set`

``` purescript
newtype Set a
```

`Set a` represents a set of values of type `a`

##### Instances
``` purescript
(Eq a) => Eq (Set a)
Eq1 Set
(Show a) => Show (Set a)
(Ord a) => Ord (Set a)
Ord1 Set
(Ord a) => Monoid (Set a)
(Ord a) => Semigroup (Set a)
Foldable Set
```

#### `fromFoldable`

``` purescript
fromFoldable :: forall f a. Foldable f => Ord a => f a -> Set a
```

Create a set from a foldable structure.

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f a. Unfoldable f => Set a -> f a
```

Convert a set to an unfoldable structure.

#### `empty`

``` purescript
empty :: forall a. Set a
```

An empty set

#### `isEmpty`

``` purescript
isEmpty :: forall a. Set a -> Boolean
```

Test if a set is empty

#### `singleton`

``` purescript
singleton :: forall a. a -> Set a
```

Create a set with one element

#### `map`

``` purescript
map :: forall a b. Ord b => (a -> b) -> Set a -> Set b
```

Maps over the values in a set.

This operation is not structure-preserving for sets, so is not a valid
`Functor`. An example case: mapping `const x` over a set with `n > 0`
elements will result in a set with one element.

#### `checkValid`

``` purescript
checkValid :: forall a. Set a -> Boolean
```

Check whether the underlying tree satisfies the 2-3 invariant

This function is provided for internal use.

#### `insert`

``` purescript
insert :: forall a. Ord a => a -> Set a -> Set a
```

Insert a value into a set

#### `member`

``` purescript
member :: forall a. Ord a => a -> Set a -> Boolean
```

Test if a value is a member of a set

#### `delete`

``` purescript
delete :: forall a. Ord a => a -> Set a -> Set a
```

Delete a value from a set

#### `toggle`

``` purescript
toggle :: forall a. Ord a => a -> Set a -> Set a
```

Insert a value into a set if it is not already present, if it is present, delete it.

#### `size`

``` purescript
size :: forall a. Set a -> Int
```

Find the size of a set

#### `findMin`

``` purescript
findMin :: forall a. Set a -> Maybe a
```

#### `findMax`

``` purescript
findMax :: forall a. Set a -> Maybe a
```

#### `union`

``` purescript
union :: forall a. Ord a => Set a -> Set a -> Set a
```

Form the union of two sets

Running time: `O(n * log(m))`

#### `unions`

``` purescript
unions :: forall f a. Foldable f => Ord a => f (Set a) -> Set a
```

Form the union of a collection of sets

#### `difference`

``` purescript
difference :: forall a. Ord a => Set a -> Set a -> Set a
```

Form the set difference

#### `subset`

``` purescript
subset :: forall a. Ord a => Set a -> Set a -> Boolean
```

True if and only if every element in the first set
is an element of the second set

#### `properSubset`

``` purescript
properSubset :: forall a. Ord a => Set a -> Set a -> Boolean
```

True if and only if the first set is a subset of the second set
and the sets are not equal

#### `intersection`

``` purescript
intersection :: forall a. Ord a => Set a -> Set a -> Set a
```

The set of elements which are in both the first and second set

#### `filter`

``` purescript
filter :: forall a. Ord a => (a -> Boolean) -> Set a -> Set a
```

Filter out those values of a set for which a predicate on the value fails
to hold.

#### `mapMaybe`

``` purescript
mapMaybe :: forall a b. Ord b => (a -> Maybe b) -> Set a -> Set b
```

Applies a function to each value in a set, discarding entries where the
function returns `Nothing`.

#### `catMaybes`

``` purescript
catMaybes :: forall a. Ord a => Set (Maybe a) -> Set a
```

Filter a set of optional values, discarding values that contain `Nothing`

#### `toMap`

``` purescript
toMap :: forall a. Set a -> Map a Unit
```

A set is a map with no value attached to each key.

#### `fromMap`

``` purescript
fromMap :: forall a. Map a Unit -> Set a
```

A map with no value attached to each key is a set.
See also `Data.Map.keys`.



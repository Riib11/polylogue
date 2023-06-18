## Module Data.Map.Internal

This module defines a type of maps as balanced 2-3 trees, based on
<http://www.cs.princeton.edu/~dpw/courses/cos326-12/ass/2-3-trees.pdf>

#### `Map`

``` purescript
data Map k v
  = Leaf
  | Two (Map k v) k v (Map k v)
  | Three (Map k v) k v (Map k v) k v (Map k v)
```

`Map k v` represents maps from keys of type `k` to values of type `v`.

##### Instances
``` purescript
(Eq k) => Eq1 (Map k)
(Eq k, Eq v) => Eq (Map k v)
(Ord k) => Ord1 (Map k)
(Ord k, Ord v) => Ord (Map k v)
(Show k, Show v) => Show (Map k v)
(Warn (Text "Data.Map\'s `Semigroup` instance is now unbiased and differs from the left-biased instance defined in PureScript releases <= 0.13.x."), Ord k, Semigroup v) => Semigroup (Map k v)
(Warn (Text "Data.Map\'s `Semigroup` instance is now unbiased and differs from the left-biased instance defined in PureScript releases <= 0.13.x."), Ord k, Semigroup v) => Monoid (Map k v)
(Ord k) => Alt (Map k)
(Ord k) => Plus (Map k)
Functor (Map k)
FunctorWithIndex k (Map k)
(Ord k) => Apply (Map k)
(Ord k) => Bind (Map k)
Foldable (Map k)
FoldableWithIndex k (Map k)
Traversable (Map k)
TraversableWithIndex k (Map k)
```

#### `showTree`

``` purescript
showTree :: forall k v. Show k => Show v => Map k v -> String
```

Render a `Map` as a `String`

#### `empty`

``` purescript
empty :: forall k v. Map k v
```

An empty map

#### `isEmpty`

``` purescript
isEmpty :: forall k v. Map k v -> Boolean
```

Test if a map is empty

#### `singleton`

``` purescript
singleton :: forall k v. k -> v -> Map k v
```

Create a map with one key/value pair

#### `checkValid`

``` purescript
checkValid :: forall k v. Map k v -> Boolean
```

Check whether the underlying tree satisfies the 2-3 invariant

This function is provided for internal use.

#### `insert`

``` purescript
insert :: forall k v. Ord k => k -> v -> Map k v -> Map k v
```

Insert or replace a key/value pair in a map

#### `insertWith`

``` purescript
insertWith :: forall k v. Ord k => (v -> v -> v) -> k -> v -> Map k v -> Map k v
```

Inserts or updates a value with the given function.

The combining function is called with the existing value as the first
argument and the new value as the second argument.

#### `lookup`

``` purescript
lookup :: forall k v. Ord k => k -> Map k v -> Maybe v
```

Look up a value for the specified key

#### `lookupLE`

``` purescript
lookupLE :: forall k v. Ord k => k -> Map k v -> Maybe { key :: k, value :: v }
```

Look up a value for the specified key, or the greatest one less than it

#### `lookupLT`

``` purescript
lookupLT :: forall k v. Ord k => k -> Map k v -> Maybe { key :: k, value :: v }
```

Look up a value for the greatest key less than the specified key

#### `lookupGE`

``` purescript
lookupGE :: forall k v. Ord k => k -> Map k v -> Maybe { key :: k, value :: v }
```

Look up a value for the specified key, or the least one greater than it

#### `lookupGT`

``` purescript
lookupGT :: forall k v. Ord k => k -> Map k v -> Maybe { key :: k, value :: v }
```

Look up a value for the least key greater than the specified key

#### `findMin`

``` purescript
findMin :: forall k v. Map k v -> Maybe { key :: k, value :: v }
```

Returns the pair with the least key

#### `findMax`

``` purescript
findMax :: forall k v. Map k v -> Maybe { key :: k, value :: v }
```

Returns the pair with the greatest key

#### `foldSubmap`

``` purescript
foldSubmap :: forall k v m. Ord k => Monoid m => Maybe k -> Maybe k -> (k -> v -> m) -> Map k v -> m
```

Fold over the entries of a given map where the key is between a lower and
an upper bound. Passing `Nothing` as either the lower or upper bound
argument means that the fold has no lower or upper bound, i.e. the fold
starts from (or ends with) the smallest (or largest) key in the map.

```purescript
foldSubmap (Just 1) (Just 2) (\_ v -> [v])
 (fromFoldable [Tuple 0 "zero", Tuple 1 "one", Tuple 2 "two", Tuple 3 "three"])
 == ["one", "two"]

foldSubmap Nothing (Just 2) (\_ v -> [v])
 (fromFoldable [Tuple 0 "zero", Tuple 1 "one", Tuple 2 "two", Tuple 3 "three"])
 == ["zero", "one", "two"]
```

#### `submap`

``` purescript
submap :: forall k v. Ord k => Maybe k -> Maybe k -> Map k v -> Map k v
```

Returns a new map containing all entries of the given map which lie
between a given lower and upper bound, treating `Nothing` as no bound i.e.
including the smallest (or largest) key in the map, no matter how small
(or large) it is. For example:

```purescript
submap (Just 1) (Just 2)
  (fromFoldable [Tuple 0 "zero", Tuple 1 "one", Tuple 2 "two", Tuple 3 "three"])
  == fromFoldable [Tuple 1 "one", Tuple 2 "two"]

submap Nothing (Just 2)
  (fromFoldable [Tuple 0 "zero", Tuple 1 "one", Tuple 2 "two", Tuple 3 "three"])
  == fromFoldable [Tuple 0 "zero", Tuple 1 "one", Tuple 2 "two"]
```

The function is entirely specified by the following
property:

```purescript
Given any m :: Map k v, mmin :: Maybe k, mmax :: Maybe k, key :: k,
  let m' = submap mmin mmax m in
    if (maybe true (\min -> min <= key) mmin &&
        maybe true (\max -> max >= key) mmax)
      then lookup key m == lookup key m'
      else not (member key m')
```

#### `fromFoldable`

``` purescript
fromFoldable :: forall f k v. Ord k => Foldable f => f (Tuple k v) -> Map k v
```

Convert any foldable collection of key/value pairs to a map.
On key collision, later values take precedence over earlier ones.

#### `fromFoldableWith`

``` purescript
fromFoldableWith :: forall f k v. Ord k => Foldable f => (v -> v -> v) -> f (Tuple k v) -> Map k v
```

Convert any foldable collection of key/value pairs to a map.
On key collision, the values are configurably combined.

#### `fromFoldableWithIndex`

``` purescript
fromFoldableWithIndex :: forall f k v. Ord k => FoldableWithIndex k f => f v -> Map k v
```

Convert any indexed foldable collection into a map.

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f k v. Unfoldable f => Map k v -> f (Tuple k v)
```

Convert a map to an unfoldable structure of key/value pairs where the keys are in ascending order

#### `toUnfoldableUnordered`

``` purescript
toUnfoldableUnordered :: forall f k v. Unfoldable f => Map k v -> f (Tuple k v)
```

Convert a map to an unfoldable structure of key/value pairs

While this traversal is up to 10% faster in benchmarks than `toUnfoldable`,
it leaks the underlying map stucture, making it only suitable for applications
where order is irrelevant.

If you are unsure, use `toUnfoldable`

#### `delete`

``` purescript
delete :: forall k v. Ord k => k -> Map k v -> Map k v
```

Delete a key and its corresponding value from a map.

#### `pop`

``` purescript
pop :: forall k v. Ord k => k -> Map k v -> Maybe (Tuple v (Map k v))
```

Delete a key and its corresponding value from a map, returning the value
as well as the subsequent map.

#### `member`

``` purescript
member :: forall k v. Ord k => k -> Map k v -> Boolean
```

Test if a key is a member of a map

#### `alter`

``` purescript
alter :: forall k v. Ord k => (Maybe v -> Maybe v) -> k -> Map k v -> Map k v
```

Insert the value, delete a value, or update a value for a key in a map

#### `update`

``` purescript
update :: forall k v. Ord k => (v -> Maybe v) -> k -> Map k v -> Map k v
```

Update or delete the value for a key in a map

#### `keys`

``` purescript
keys :: forall k v. Map k v -> List k
```

Get a list of the keys contained in a map

#### `values`

``` purescript
values :: forall k v. Map k v -> List v
```

Get a list of the values contained in a map

#### `union`

``` purescript
union :: forall k v. Ord k => Map k v -> Map k v -> Map k v
```

Compute the union of two maps, preferring values from the first map in the case
of duplicate keys

#### `unionWith`

``` purescript
unionWith :: forall k v. Ord k => (v -> v -> v) -> Map k v -> Map k v -> Map k v
```

Compute the union of two maps, using the specified function
to combine values for duplicate keys.

#### `unions`

``` purescript
unions :: forall k v f. Ord k => Foldable f => f (Map k v) -> Map k v
```

Compute the union of a collection of maps

#### `intersection`

``` purescript
intersection :: forall k a b. Ord k => Map k a -> Map k b -> Map k a
```

Compute the intersection of two maps, preferring values from the first map in the case
of duplicate keys.

#### `intersectionWith`

``` purescript
intersectionWith :: forall k a b c. Ord k => (a -> b -> c) -> Map k a -> Map k b -> Map k c
```

Compute the intersection of two maps, using the specified function
to combine values for duplicate keys.

#### `difference`

``` purescript
difference :: forall k v w. Ord k => Map k v -> Map k w -> Map k v
```

Difference of two maps. Return elements of the first map where
the keys do not exist in the second map.

#### `isSubmap`

``` purescript
isSubmap :: forall k v. Ord k => Eq v => Map k v -> Map k v -> Boolean
```

Test whether one map contains all of the keys and values contained in another map

#### `size`

``` purescript
size :: forall k v. Map k v -> Int
```

Calculate the number of key/value pairs in a map

#### `filterWithKey`

``` purescript
filterWithKey :: forall k v. Ord k => (k -> v -> Boolean) -> Map k v -> Map k v
```

Filter out those key/value pairs of a map for which a predicate
fails to hold.

#### `filterKeys`

``` purescript
filterKeys :: forall k. Ord k => (k -> Boolean) -> (Map k) ~> (Map k)
```

Filter out those key/value pairs of a map for which a predicate
on the key fails to hold.

#### `filter`

``` purescript
filter :: forall k v. Ord k => (v -> Boolean) -> Map k v -> Map k v
```

Filter out those key/value pairs of a map for which a predicate
on the value fails to hold.

#### `mapMaybeWithKey`

``` purescript
mapMaybeWithKey :: forall k a b. Ord k => (k -> a -> Maybe b) -> Map k a -> Map k b
```

Applies a function to each key/value pair in a map, discarding entries
where the function returns `Nothing`.

#### `mapMaybe`

``` purescript
mapMaybe :: forall k a b. Ord k => (a -> Maybe b) -> Map k a -> Map k b
```

Applies a function to each value in a map, discarding entries where the
function returns `Nothing`.

#### `catMaybes`

``` purescript
catMaybes :: forall k v. Ord k => Map k (Maybe v) -> Map k v
```

Filter a map of optional values, keeping only the key/value pairs which
contain a value, creating a new map.



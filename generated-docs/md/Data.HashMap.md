## Module Data.HashMap

#### `HashMap`

``` purescript
data HashMap t0 t1
```

Immutable hash maps from keys `k` to values `v`.

Note that this is an *unordered* collection.

##### Instances
``` purescript
(Eq k, Eq v) => Eq (HashMap k v)
(Hashable k, Hashable v) => Hashable (HashMap k v)
(Hashable k, Semigroup v) => Monoid (HashMap k v)
(Hashable k, Semigroup v) => Semigroup (HashMap k v)
Functor (HashMap k)
FunctorWithIndex k (HashMap k)
(Hashable k) => Apply (HashMap k)
(Hashable k) => Bind (HashMap k)
Foldable (HashMap k)
FoldableWithIndex k (HashMap k)
Traversable (HashMap k)
TraversableWithIndex k (HashMap k)
(Show k, Show v) => Show (HashMap k v)
```

#### `empty`

``` purescript
empty :: forall k v. HashMap k v
```

The empty map.

#### `singleton`

``` purescript
singleton :: forall k v. Hashable k => k -> v -> HashMap k v
```

A map of one key and its associated value.

`singleton k v == insert k v empty`

#### `lookup`

``` purescript
lookup :: forall k v. Hashable k => k -> HashMap k v -> Maybe v
```

Get a value by key.

#### `insert`

``` purescript
insert :: forall k v. Hashable k => k -> v -> HashMap k v -> HashMap k v
```

Insert or replace a value.

`lookup k (insert k v m) == Just v`

#### `delete`

``` purescript
delete :: forall k v. Hashable k => k -> HashMap k v -> HashMap k v
```

Remove a key and its associated value from a map.

`lookup k (delete k m) == Nothing`

#### `size`

``` purescript
size :: forall k v. HashMap k v -> Int
```

Returns the number of key-value pairs in a map.

`size (singleton k v) == 1`

#### `isEmpty`

``` purescript
isEmpty :: forall k v. HashMap k v -> Boolean
```

Test whether a map is empty.

`isEmpty m  ==  (m == empty)`

#### `member`

``` purescript
member :: forall k v. Hashable k => k -> HashMap k v -> Boolean
```

Test whether a key is in a map.

#### `upsert`

``` purescript
upsert :: forall k v. Hashable k => (v -> v) -> k -> v -> HashMap k v -> HashMap k v
```

Insert a new value if it doesn't exist or update the existing
value by applying a function to it.

If you need to combine the new value with the existing value
consider using `insertWith` instead.

#### `insertWith`

``` purescript
insertWith :: forall k v. Hashable k => (v -> v -> v) -> k -> v -> HashMap k v -> HashMap k v
```

Insert the new value if the key doesn't exist, otherwise combine
the existing and new values.

The combining function is called with the existing value as the
first argument and the new value as the second argument.

```PureScript
insertWith (<>) 5 "b" (singleton 5 "a") == singleton 5 "ab"
```

If your update function does not use the existing value, consider
using `upsert` instead.

#### `update`

``` purescript
update :: forall k v. Hashable k => (v -> Maybe v) -> k -> HashMap k v -> HashMap k v
```

Update or delete the value for a key in a map.

#### `alter`

``` purescript
alter :: forall k v. Hashable k => (Maybe v -> Maybe v) -> k -> HashMap k v -> HashMap k v
```

Insert a value, delete a value, or update a value for a key in a map.

#### `filter`

``` purescript
filter :: forall k v. (v -> Boolean) -> HashMap k v -> HashMap k v
```

Remove key-value-pairs from a map for which the predicate does
not hold.

```PureScript
filter (const False) m == empty
filter (const True) m == m
```

#### `filterWithKey`

``` purescript
filterWithKey :: forall k v. (k -> v -> Boolean) -> HashMap k v -> HashMap k v
```

Remove key-value-pairs from a map for which the predicate does
not hold.

Like `filter`, but the predicate takes both key and value.

#### `filterKeys`

``` purescript
filterKeys :: forall k v. (k -> Boolean) -> HashMap k v -> HashMap k v
```

Remove all keys from the map for which the predicate does not
hold.

`difference m1 m2 == filterKeys (\k -> member k m2) m1`

#### `mapMaybe`

``` purescript
mapMaybe :: forall k v w. (v -> Maybe w) -> HashMap k v -> HashMap k w
```

Apply a function to all values in a hash map, discard the
`Nothing` results, and keep the value of the `Just` results.

#### `mapMaybeWithKey`

``` purescript
mapMaybeWithKey :: forall k v w. (k -> v -> Maybe w) -> HashMap k v -> HashMap k w
```

Apply a function to all key value pairs in a hash map, discard
the `Nothing` results, and keep the value of the `Just` results.

#### `fromArray`

``` purescript
fromArray :: forall k v. Hashable k => Array (Tuple k v) -> HashMap k v
```

Turn an array of pairs into a hash map.

This uses a mutable hash map internally and is faster than
`fromFoldable`.

If you have an array of something other than tuples, use
`fromArrayBy`.

#### `fromFoldable`

``` purescript
fromFoldable :: forall f k v. Foldable f => Hashable k => f (Tuple k v) -> HashMap k v
```

Turn a foldable functor of pairs into a hash map.

In the presence of duplicate keys, later (by `foldl`) mappings
overwrite earlier mappings.

If your input is an array, consider using `fromArray` instead.

#### `fromArrayBy`

``` purescript
fromArrayBy :: forall a k v. Hashable k => (a -> k) -> (a -> v) -> Array a -> HashMap k v
```

Turn an array into a hash map given extraction functions for keys
and values.

This uses a mutable hash map internally and is faster than
`fromFoldable` and `fromFoldableBy`.

#### `fromFoldableBy`

``` purescript
fromFoldableBy :: forall f a k v. Foldable f => Hashable k => (a -> k) -> (a -> v) -> f a -> HashMap k v
```

Turn a foldable functor into a hash map given extraction
functions for keys and values.

If your input is an array, consider using `fromArrayBy` instead.

`fromFoldableBy fst snd == fromFoldable`

#### `fromFoldableWithIndex`

``` purescript
fromFoldableWithIndex :: forall f k v. FoldableWithIndex k f => Hashable k => f v -> HashMap k v
```

Turn a foldable functor with index into a hash map.

This can be used to convert, for example, an ordered map into a
hash map with the same keys and values, or an array into a hash
map with values indexed by their position in the array.

```PureScript
fromFoldableWithIndex ["a", "b"] == fromArray [Tuple 0 "a", Tuple 1 "b"]
```

#### `toArrayBy`

``` purescript
toArrayBy :: forall a k v. (k -> v -> a) -> HashMap k v -> Array a
```

Convert a map to an array using the given function.

Note that no particular order is guaranteed.

```PureScript
toArrayBy Tuple (singleton 1 2) == [Tuple 1 2]
toArrayBy const        m == keys m
toArrayBy (flip const) m == values m
```

#### `keys`

``` purescript
keys :: forall k v. HashMap k v -> Array k
```

Returns the keys of the map in no particular order.

If you need both keys and values, use `toArrayBy` rather than
both `keys` and `values`.

#### `values`

``` purescript
values :: forall k v. HashMap k v -> Array v
```

Returns the values of the map in no particular order.

If you need both keys and values, use `toArrayBy` rather than
both `keys` and `values`.

#### `union`

``` purescript
union :: forall k v. Hashable k => HashMap k v -> HashMap k v -> HashMap k v
```

Union two maps.

For duplicate keys, we keep the value from the left map.

#### `unionWith`

``` purescript
unionWith :: forall k v. Hashable k => (v -> v -> v) -> HashMap k v -> HashMap k v -> HashMap k v
```

Union two maps, combining the values for keys that appear in both maps using the given function.

`unionWith (-) (singleton 0 3) (singleton 0 2) == singleton 0 1`

#### `intersection`

``` purescript
intersection :: forall k v. Hashable k => HashMap k v -> HashMap k v -> HashMap k v
```

Intersect two maps.

#### `intersectionWith`

``` purescript
intersectionWith :: forall k a b c. Hashable k => (a -> b -> c) -> HashMap k a -> HashMap k b -> HashMap k c
```

Intersect two maps, combining the values for keys that appear in both maps using the given function.

`intersectionWith (-) (singleton 0 3) (singleton 0 2) == singleton 0 1`

#### `difference`

``` purescript
difference :: forall k v w. Hashable k => HashMap k v -> HashMap k w -> HashMap k v
```

Compute the difference of two maps, that is a new map of all the
mappings in the left map that do not have a corresponding key in
the right map.

#### `SemigroupHashMap`

``` purescript
newtype SemigroupHashMap k v
  = SemigroupHashMap (HashMap k v)
```

This newtype provides a `Semigroup` instance for `HashMap k v`
which delegates to the `Semigroup v` instance of elements. This
newtype is deprecated and will be removed in the next major
version. Use `HashMap` instead.

We are currently in step 2 of the following migration process:
1. Add `SemigroupHashMap` with the new `Semigroup` instance and remove old instance from `HashMap`.

   The new instance uses `unionWith append` instead of `union`.
   You can recover the previous, left-biased behaviour by using
   `SemigroupHashMap k (First v)` in place of `HashMap k v`.

2. Add new `Semigroup` instance to `HashMap` and deprecate `SemigroupHashMap`.
3. Remove `SemigroupHashMap`.

##### Instances
``` purescript
Newtype (SemigroupHashMap k v) _
(Eq k, Eq v) => Eq (SemigroupHashMap k v)
(Hashable k, Hashable v) => Hashable (SemigroupHashMap k v)
Functor (SemigroupHashMap k)
FunctorWithIndex k (SemigroupHashMap k)
(Hashable k) => Apply (SemigroupHashMap k)
(Hashable k) => Bind (SemigroupHashMap k)
Foldable (SemigroupHashMap k)
FoldableWithIndex k (SemigroupHashMap k)
Traversable (SemigroupHashMap k)
TraversableWithIndex k (SemigroupHashMap k)
(Show k, Show v) => Show (SemigroupHashMap k v)
(Hashable k, Semigroup v) => Semigroup (SemigroupHashMap k v)
(Hashable k, Semigroup v) => Monoid (SemigroupHashMap k v)
```

#### `nubHash`

``` purescript
nubHash :: forall a. Hashable a => Array a -> Array a
```

Remove duplicates from an array.

Like `nub` from `Data.Array`, but uses a `Hashable` constraint
instead of an `Ord` constraint.

#### `debugShow`

``` purescript
debugShow :: forall k v. HashMap k v -> String
```



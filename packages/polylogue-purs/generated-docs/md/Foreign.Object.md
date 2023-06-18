## Module Foreign.Object

This module defines a type of native homogeneous Javascript Objects.

To maximize performance, Javascript objects are not wrapped,
and some native code is used even when it's not necessary.

#### `Object`

``` purescript
data Object t0
```

`Object a` represents a homogeneous JS Object with values of type `a`.

##### Instances
``` purescript
Functor Object
FunctorWithIndex String Object
Foldable Object
FoldableWithIndex String Object
Traversable Object
TraversableWithIndex String Object
(Eq a) => Eq (Object a)
Eq1 Object
(Ord a) => Ord (Object a)
(Show a) => Show (Object a)
(Semigroup a) => Semigroup (Object a)
(Semigroup a) => Monoid (Object a)
```

#### `empty`

``` purescript
empty :: forall a. Object a
```

An empty map

#### `isEmpty`

``` purescript
isEmpty :: forall a. Object a -> Boolean
```

Test whether a map is empty

#### `size`

``` purescript
size :: forall a. Object a -> Int
```

Calculate the number of key/value pairs in a map

#### `singleton`

``` purescript
singleton :: forall a. String -> a -> Object a
```

Create an `Object a` with one key/value pair

#### `insert`

``` purescript
insert :: forall a. String -> a -> Object a -> Object a
```

Insert or replace a key/value pair in a map

#### `lookup`

``` purescript
lookup :: forall a. String -> Object a -> Maybe a
```

Lookup the value for a key in a map

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f a. Unfoldable f => Object a -> f (Tuple String a)
```

Unfolds a map into a list of key/value pairs

#### `toAscUnfoldable`

``` purescript
toAscUnfoldable :: forall f a. Unfoldable f => Object a -> f (Tuple String a)
```

Unfolds a map into a list of key/value pairs which is guaranteed to be
sorted by key

#### `fromFoldable`

``` purescript
fromFoldable :: forall f a. Foldable f => f (Tuple String a) -> Object a
```

Create an `Object a` from a foldable collection of key/value pairs

#### `fromFoldableWith`

``` purescript
fromFoldableWith :: forall f a. Foldable f => (a -> a -> a) -> f (Tuple String a) -> Object a
```

Create an `Object a` from a foldable collection of key/value pairs, using the
specified function to combine values for duplicate keys.

#### `fromFoldableWithIndex`

``` purescript
fromFoldableWithIndex :: forall f a. FoldableWithIndex String f => f a -> Object a
```

Create an `Object a` from a `String`-indexed foldable collection

#### `fromHomogeneous`

``` purescript
fromHomogeneous :: forall r a. Homogeneous r a => Record r -> Object a
```

Create an `Object a` from a homogeneous record, i.e. all of the record
fields are of the same type.

#### `delete`

``` purescript
delete :: forall a. String -> Object a -> Object a
```

Delete a key and value from a map

#### `pop`

``` purescript
pop :: forall a. String -> Object a -> Maybe (Tuple a (Object a))
```

Delete a key and value from a map, returning the value
as well as the subsequent map

#### `member`

``` purescript
member :: forall a. String -> Object a -> Boolean
```

Test whether a `String` appears as a key in a map

#### `alter`

``` purescript
alter :: forall a. (Maybe a -> Maybe a) -> String -> Object a -> Object a
```

Insert, remove or update a value for a key in a map

#### `update`

``` purescript
update :: forall a. (a -> Maybe a) -> String -> Object a -> Object a
```

Remove or update a value for a key in a map

#### `mapWithKey`

``` purescript
mapWithKey :: forall a b. (String -> a -> b) -> Object a -> Object b
```

Apply a function of two arguments to each key/value pair, producing a new map

#### `filterWithKey`

``` purescript
filterWithKey :: forall a. (String -> a -> Boolean) -> Object a -> Object a
```

Filter out those key/value pairs of a map for which a predicate
fails to hold.

#### `filterKeys`

``` purescript
filterKeys :: (String -> Boolean) -> Object ~> Object
```

Filter out those key/value pairs of a map for which a predicate
on the key fails to hold.

#### `filter`

``` purescript
filter :: forall a. (a -> Boolean) -> Object a -> Object a
```

Filter out those key/value pairs of a map for which a predicate
on the value fails to hold.

#### `keys`

``` purescript
keys :: forall a. Object a -> Array String
```

Get an array of the keys in a map

#### `values`

``` purescript
values :: forall a. Object a -> Array a
```

Get a list of the values in a map

#### `union`

``` purescript
union :: forall a. Object a -> Object a -> Object a
```

Compute the union of two maps, preferring the first map in the case of
duplicate keys.

#### `unionWith`

``` purescript
unionWith :: forall a. (a -> a -> a) -> Object a -> Object a -> Object a
```

Compute the union of two maps, using the specified function
to combine values for duplicate keys.

#### `unions`

``` purescript
unions :: forall f a. Foldable f => f (Object a) -> Object a
```

Compute the union of a collection of maps

#### `isSubmap`

``` purescript
isSubmap :: forall a. Eq a => Object a -> Object a -> Boolean
```

Test whether one map contains all of the keys and values contained in another map

#### `fold`

``` purescript
fold :: forall a z. (z -> String -> a -> z) -> z -> Object a -> z
```

Fold the keys and values of an object

#### `foldMap`

``` purescript
foldMap :: forall a m. Monoid m => (String -> a -> m) -> Object a -> m
```

Fold the keys and values of an object, accumulating values using some
`Monoid`.

#### `foldM`

``` purescript
foldM :: forall a m z. Monad m => (z -> String -> a -> m z) -> z -> Object a -> m z
```

Fold the keys and values of an object, accumulating values and effects in
some `Monad`.

#### `foldMaybe`

``` purescript
foldMaybe :: forall a z. (z -> String -> a -> Maybe z) -> z -> Object a -> z
```

Fold the keys and values of a map.

This function allows the folding function to terminate the fold early,
using `Maybe`.

#### `all`

``` purescript
all :: forall a. (String -> a -> Boolean) -> Object a -> Boolean
```

Test whether all key/value pairs in a `Object` satisfy a predicate.

#### `thawST`

``` purescript
thawST :: forall a r. Object a -> ST r (STObject r a)
```

Convert an immutable Object into a mutable Object

#### `freezeST`

``` purescript
freezeST :: forall a r. STObject r a -> ST r (Object a)
```

Convert a mutable Object into an immutable Object

#### `runST`

``` purescript
runST :: forall a. (forall r. ST r (STObject r a)) -> Object a
```

Freeze a mutable Object, creating an immutable Object. Use this function as you would use
`Control.Monad.ST.run` (from the `purescript-st` package) to freeze a mutable reference.

The rank-2 type prevents the Object from escaping the scope of `runST`.

#### `toArrayWithKey`

``` purescript
toArrayWithKey :: forall a b. (String -> a -> b) -> Object a -> Array b
```



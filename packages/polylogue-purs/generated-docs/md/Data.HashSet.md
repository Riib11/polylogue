## Module Data.HashSet

#### `HashSet`

``` purescript
newtype HashSet a
```

A `HashSet a` is a set with elements of type `a`.

`a` needs to be `Hashable` for most operations.

##### Instances
``` purescript
(Eq a) => Eq (HashSet a)
(Hashable a) => Hashable (HashSet a)
(Hashable a) => Semigroup (HashSet a)
(Hashable a) => Monoid (HashSet a)
(Show a) => Show (HashSet a)
Foldable HashSet
```

#### `empty`

``` purescript
empty :: forall a. HashSet a
```

The empty set.

#### `singleton`

``` purescript
singleton :: forall a. Hashable a => a -> HashSet a
```

The singleton set.

#### `insert`

``` purescript
insert :: forall a. Hashable a => a -> HashSet a -> HashSet a
```

Insert a value into a set.

#### `member`

``` purescript
member :: forall a. Hashable a => a -> HashSet a -> Boolean
```

Test whether a value is in a set.

#### `delete`

``` purescript
delete :: forall a. Hashable a => a -> HashSet a -> HashSet a
```

Remove a value from a set.

#### `map`

``` purescript
map :: forall a b. Hashable b => (a -> b) -> HashSet a -> HashSet b
```

Construct a new set by applying a function to each element of an
input set.

If distinct inputs map to the same output, this changes the
cardinality of the set, therefore hash set is not a `Functor`.
Also, the order in which elements appear in the new set is
entirely dependent on the hash function for type `b`.

#### `filter`

``` purescript
filter :: forall a. (a -> Boolean) -> HashSet a -> HashSet a
```

Remove all elements from the set for which the predicate does not
hold.

`filter (const false) s == empty`

#### `mapMaybe`

``` purescript
mapMaybe :: forall a b. Hashable b => (a -> Maybe b) -> HashSet a -> HashSet b
```

Map a function over a set, keeping only the `Just` values.

#### `union`

``` purescript
union :: forall a. Hashable a => HashSet a -> HashSet a -> HashSet a
```

Union two sets.

#### `unions`

``` purescript
unions :: forall f a. Foldable f => Hashable a => f (HashSet a) -> HashSet a
```

Union a collection of sets.

#### `intersection`

``` purescript
intersection :: forall a. Hashable a => HashSet a -> HashSet a -> HashSet a
```

Intersect two sets.

#### `difference`

``` purescript
difference :: forall a. Hashable a => HashSet a -> HashSet a -> HashSet a
```

Difference of two sets.

Also known as set minus or relative complement. Returns a set of
all elements of the left set that are not in the right set.

#### `size`

``` purescript
size :: forall a. HashSet a -> Int
```

Count the number of elements.

Also known as cardinality, or length.

#### `isEmpty`

``` purescript
isEmpty :: forall a. HashSet a -> Boolean
```

Test whether a set is empty.

`isEmpty s  ==  (s == empty)`

#### `fromArray`

``` purescript
fromArray :: forall a. Hashable a => Array a -> HashSet a
```

Turn an array into a hash set.

This uses a mutable hash map internally and is faster than
`fromFoldable`.

#### `fromFoldable`

``` purescript
fromFoldable :: forall f a. Foldable f => Hashable a => f a -> HashSet a
```

Create a set from a foldable structure.

#### `fromMap`

``` purescript
fromMap :: forall a. HashMap a Unit -> HashSet a
```

#### `toArray`

``` purescript
toArray :: forall a. HashSet a -> Array a
```

Turn a set into an array of its elments in no particular order.

To delete duplicates in an array, consider using `nubHash` from
`Data.HashMap` instead of `toArray <<< fromFoldable`.

#### `toMap`

``` purescript
toMap :: forall a. HashSet a -> HashMap a Unit
```

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f a. Unfoldable f => HashSet a -> f a
```

Turn a set into an unfoldable functor.

You probably want to use `toArray` instead, especially if you
want to get an array out.



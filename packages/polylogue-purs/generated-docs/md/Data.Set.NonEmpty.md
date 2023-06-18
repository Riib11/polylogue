## Module Data.Set.NonEmpty

#### `NonEmptySet`

``` purescript
newtype NonEmptySet a
```

`NonEmptySet a` represents a non-empty set of values of type `a`

##### Instances
``` purescript
(Eq a) => Eq (NonEmptySet a)
Eq1 NonEmptySet
(Ord a) => Ord (NonEmptySet a)
Ord1 NonEmptySet
(Ord a) => Semigroup (NonEmptySet a)
Foldable NonEmptySet
Foldable1 NonEmptySet
(Show a) => Show (NonEmptySet a)
```

#### `singleton`

``` purescript
singleton :: forall a. a -> NonEmptySet a
```

Create a set with one element.

#### `cons`

``` purescript
cons :: forall a. Ord a => a -> Set a -> NonEmptySet a
```

Creates a `NonEmptySet` from an item and a `Set`.

#### `fromSet`

``` purescript
fromSet :: forall a. Set a -> Maybe (NonEmptySet a)
```

Attempts to create a non-empty set from a possibly-empty set.

#### `fromFoldable`

``` purescript
fromFoldable :: forall f a. Foldable f => Ord a => f a -> Maybe (NonEmptySet a)
```

Create a set from a foldable structure.

#### `fromFoldable1`

``` purescript
fromFoldable1 :: forall f a. Foldable1 f => Ord a => f a -> NonEmptySet a
```

Create a set from a non-empty foldable structure.

#### `toSet`

``` purescript
toSet :: forall a. NonEmptySet a -> Set a
```

Forgets the non-empty property of a set, giving a normal possibly-empty
set.

#### `toUnfoldable`

``` purescript
toUnfoldable :: forall f a. Unfoldable f => NonEmptySet a -> f a
```

Convert a set to an unfoldable structure.

#### `toUnfoldable1`

``` purescript
toUnfoldable1 :: forall f a. Unfoldable1 f => NonEmptySet a -> f a
```

Convert a set to a non-empty unfoldable structure.

#### `map`

``` purescript
map :: forall a b. Ord b => (a -> b) -> NonEmptySet a -> NonEmptySet b
```

Maps over the values in a set.

This operation is not structure-preserving for sets, so is not a valid
`Functor`. An example case: mapping `const x` over a set with `n > 0`
elements will result in a set with one element.

#### `member`

``` purescript
member :: forall a. Ord a => a -> NonEmptySet a -> Boolean
```

Test if a value is a member of a set.

#### `insert`

``` purescript
insert :: forall a. Ord a => a -> NonEmptySet a -> NonEmptySet a
```

Insert a value into a set.

#### `delete`

``` purescript
delete :: forall a. Ord a => a -> NonEmptySet a -> Maybe (NonEmptySet a)
```

Delete a value from a non-empty set. If this would empty the set, the
result is `Nothing`.

#### `size`

``` purescript
size :: forall a. NonEmptySet a -> Int
```

Find the size of a set.

#### `min`

``` purescript
min :: forall a. NonEmptySet a -> a
```

The minimum value in the set.

#### `max`

``` purescript
max :: forall a. NonEmptySet a -> a
```

The maximum value in the set.

#### `unionSet`

``` purescript
unionSet :: forall a. Ord a => Set a -> NonEmptySet a -> NonEmptySet a
```

Form the union of a set and the non-empty set.

#### `difference`

``` purescript
difference :: forall a. Ord a => NonEmptySet a -> NonEmptySet a -> Maybe (NonEmptySet a)
```

Form the set difference. `Nothing` if the first is a subset of the second.

#### `subset`

``` purescript
subset :: forall a. Ord a => NonEmptySet a -> NonEmptySet a -> Boolean
```

True if and only if every element in the first set is an element of the
second set.

#### `properSubset`

``` purescript
properSubset :: forall a. Ord a => NonEmptySet a -> NonEmptySet a -> Boolean
```

True if and only if the first set is a subset of the second set and the
sets are not equal.

#### `intersection`

``` purescript
intersection :: forall a. Ord a => NonEmptySet a -> NonEmptySet a -> Maybe (NonEmptySet a)
```

The set of elements which are in both the first and second set. `Nothing`
if the sets are disjoint.

#### `filter`

``` purescript
filter :: forall a. Ord a => (a -> Boolean) -> NonEmptySet a -> Set a
```

Filter out those values of a set for which a predicate on the value fails
to hold.

#### `mapMaybe`

``` purescript
mapMaybe :: forall a b. Ord b => (a -> Maybe b) -> NonEmptySet a -> Set b
```

Applies a function to each value in a set, discarding entries where the
function returns `Nothing`.



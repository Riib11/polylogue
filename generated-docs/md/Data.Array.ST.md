## Module Data.Array.ST

Helper functions for working with mutable arrays using the `ST` effect.

This module can be used when performance is important and mutation is a local effect.

#### `STArray`

``` purescript
data STArray t0 t1
```

A reference to a mutable array.

The first type parameter represents the memory region which the array belongs to.
The second type parameter defines the type of elements of the mutable array.

The runtime representation of a value of type `STArray h a` is the same as that of `Array a`,
except that mutation is allowed.

#### `Assoc`

``` purescript
type Assoc a = { index :: Int, value :: a }
```

An element and its index.

#### `run`

``` purescript
run :: forall a. (forall h. ST h (STArray h a)) -> Array a
```

A safe way to create and work with a mutable array before returning an
immutable array for later perusal. This function avoids copying the array
before returning it - it uses unsafeFreeze internally, but this wrapper is
a safe interface to that function.

#### `withArray`

``` purescript
withArray :: forall h a b. (STArray h a -> ST h b) -> Array a -> ST h (Array a)
```

Perform an effect requiring a mutable array on a copy of an immutable array,
safely returning the result as an immutable array.

#### `new`

``` purescript
new :: forall h a. ST h (STArray h a)
```

Create a new, empty mutable array.

#### `peek`

``` purescript
peek :: forall h a. Int -> STArray h a -> ST h (Maybe a)
```

Read the value at the specified index in a mutable array.

#### `poke`

``` purescript
poke :: forall h a. Int -> a -> STArray h a -> ST h Boolean
```

Change the value at the specified index in a mutable array.

#### `modify`

``` purescript
modify :: forall h a. Int -> (a -> a) -> STArray h a -> ST h Boolean
```

Mutate the element at the specified index using the supplied function.

#### `length`

``` purescript
length :: forall h a. STArray h a -> ST h Int
```

Get the number of elements in a mutable array.

#### `pop`

``` purescript
pop :: forall h a. STArray h a -> ST h (Maybe a)
```

Remove the last element from an array and return that element.

#### `push`

``` purescript
push :: forall h a. a -> STArray h a -> ST h Int
```

Append an element to the end of a mutable array. Returns the new length of
the array.

#### `pushAll`

``` purescript
pushAll :: forall h a. Array a -> STArray h a -> ST h Int
```

Append the values in an immutable array to the end of a mutable array.
Returns the new length of the mutable array.

#### `shift`

``` purescript
shift :: forall h a. STArray h a -> ST h (Maybe a)
```

Remove the first element from an array and return that element.

#### `unshift`

``` purescript
unshift :: forall h a. a -> STArray h a -> ST h Int
```

Append an element to the front of a mutable array. Returns the new length of
the array.

#### `unshiftAll`

``` purescript
unshiftAll :: forall h a. Array a -> STArray h a -> ST h Int
```

Append the values in an immutable array to the front of a mutable array.
Returns the new length of the mutable array.

#### `splice`

``` purescript
splice :: forall h a. Int -> Int -> Array a -> STArray h a -> ST h (Array a)
```

Remove and/or insert elements from/into a mutable array at the specified index.

#### `sort`

``` purescript
sort :: forall a h. Ord a => STArray h a -> ST h (STArray h a)
```

Sort a mutable array in place. Sorting is stable: the order of equal
elements is preserved.

#### `sortBy`

``` purescript
sortBy :: forall a h. (a -> a -> Ordering) -> STArray h a -> ST h (STArray h a)
```

Sort a mutable array in place using a comparison function. Sorting is
stable: the order of elements is preserved if they are equal according to
the comparison function.

#### `sortWith`

``` purescript
sortWith :: forall a b h. Ord b => (a -> b) -> STArray h a -> ST h (STArray h a)
```

Sort a mutable array in place based on a projection. Sorting is stable: the
order of elements is preserved if they are equal according to the projection.

#### `freeze`

``` purescript
freeze :: forall h a. STArray h a -> ST h (Array a)
```

Create an immutable copy of a mutable array.

#### `thaw`

``` purescript
thaw :: forall h a. Array a -> ST h (STArray h a)
```

Create a mutable copy of an immutable array.

#### `unsafeFreeze`

``` purescript
unsafeFreeze :: forall h a. STArray h a -> ST h (Array a)
```

O(1). Convert a mutable array to an immutable array, without copying. The mutable
array must not be mutated afterwards.

#### `unsafeThaw`

``` purescript
unsafeThaw :: forall h a. Array a -> ST h (STArray h a)
```

O(1) Convert an immutable array to a mutable array, without copying. The input
array must not be used afterward.

#### `toAssocArray`

``` purescript
toAssocArray :: forall h a. STArray h a -> ST h (Array (Assoc a))
```

Create an immutable copy of a mutable array, where each element
is labelled with its index in the original array.



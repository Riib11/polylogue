## Module Data.Array.Partial

Partial helper functions for working with immutable arrays.

#### `head`

``` purescript
head :: forall a. Partial => Array a -> a
```

Get the first element of a non-empty array.

Running time: `O(1)`.

#### `tail`

``` purescript
tail :: forall a. Partial => Array a -> Array a
```

Get all but the first element of a non-empty array.

Running time: `O(n)`, where `n` is the length of the array.

#### `last`

``` purescript
last :: forall a. Partial => Array a -> a
```

Get the last element of a non-empty array.

Running time: `O(1)`.

#### `init`

``` purescript
init :: forall a. Partial => Array a -> Array a
```

Get all but the last element of a non-empty array.

Running time: `O(n)`, where `n` is the length of the array.



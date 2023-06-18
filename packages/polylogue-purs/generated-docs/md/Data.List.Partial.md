## Module Data.List.Partial

Partial helper functions for working with strict linked lists.

#### `head`

``` purescript
head :: forall a. Partial => List a -> a
```

Get the first element of a non-empty list.

Running time: `O(1)`.

#### `tail`

``` purescript
tail :: forall a. Partial => List a -> List a
```

Get all but the first element of a non-empty list.

Running time: `O(1)`

#### `last`

``` purescript
last :: forall a. Partial => List a -> a
```

Get the last element of a non-empty list.

Running time: `O(n)`

#### `init`

``` purescript
init :: forall a. Partial => List a -> List a
```

Get all but the last element of a non-empty list.

Running time: `O(n)`



## Module Data.Array.ST.Partial

Partial functions for working with mutable arrays using the `ST` effect.

This module is particularly helpful when performance is very important.

#### `peek`

``` purescript
peek :: forall h a. Partial => Int -> STArray h a -> ST h a
```

Read the value at the specified index in a mutable array.

#### `poke`

``` purescript
poke :: forall h a. Partial => Int -> a -> STArray h a -> ST h Unit
```

Change the value at the specified index in a mutable array.



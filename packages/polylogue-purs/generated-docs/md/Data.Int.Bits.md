## Module Data.Int.Bits

This module defines bitwise operations for the `Int` type.

#### `and`

``` purescript
and :: Int -> Int -> Int
```

Bitwise AND.

#### `(.&.)`

``` purescript
infixl 10 and as .&.
```

#### `or`

``` purescript
or :: Int -> Int -> Int
```

Bitwise OR.

#### `(.|.)`

``` purescript
infixl 10 or as .|.
```

#### `xor`

``` purescript
xor :: Int -> Int -> Int
```

Bitwise XOR.

#### `(.^.)`

``` purescript
infixl 10 xor as .^.
```

#### `shl`

``` purescript
shl :: Int -> Int -> Int
```

Bitwise shift left.

#### `shr`

``` purescript
shr :: Int -> Int -> Int
```

Bitwise shift right.

#### `zshr`

``` purescript
zshr :: Int -> Int -> Int
```

Bitwise zero-fill shift right.

#### `complement`

``` purescript
complement :: Int -> Int
```

Bitwise NOT.



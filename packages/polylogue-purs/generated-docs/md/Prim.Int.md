## Module Prim.Int

The Prim.Int module is embedded in the PureScript compiler. Unlike `Prim`, it is not imported implicitly. It contains automatically solved type classes for working with type-level intural numbers.
#### `Add`

``` purescript
class Add (left :: Int) (right :: Int) (sum :: Int) | left right -> sum, left sum -> right, right sum -> left
```

Compiler solved type class for adding type-level `Int`s.

#### `Compare`

``` purescript
class Compare (left :: Int) (right :: Int) (ordering :: Ordering) | left right -> ordering
```

Compiler solved type class for comparing two type-level `Int`s.
Produces an `Ordering`.

#### `Mul`

``` purescript
class Mul (left :: Int) (right :: Int) (product :: Int) | left right -> product
```

Compiler solved type class for multiplying type-level `Int`s.

#### `ToString`

``` purescript
class ToString (int :: Int) (string :: Symbol) | int -> string
```

Compiler solved type class for converting a type-level `Int` into a type-level `String` (i.e. `Symbol`).



## Module Prim.Symbol

The Prim.Symbol module is embedded in the PureScript compiler. Unlike `Prim`, it is not imported implicitly. It contains automatically solved type classes for working with `Symbols`.
#### `Append`

``` purescript
class Append (left :: Symbol) (right :: Symbol) (appended :: Symbol) | left right -> appended, right appended -> left, appended left -> right
```

Compiler solved type class for appending `Symbol`s together.

#### `Compare`

``` purescript
class Compare (left :: Symbol) (right :: Symbol) (ordering :: Ordering) | left right -> ordering
```

Compiler solved type class for comparing two `Symbol`s.
Produces an `Ordering`.

#### `Cons`

``` purescript
class Cons (head :: Symbol) (tail :: Symbol) (symbol :: Symbol) | head tail -> symbol, symbol -> head tail
```

Compiler solved type class for either splitting up a symbol into its
head and tail or for combining a head and tail into a new symbol.
Requires the head to be a single character and the combined string
cannot be empty.



## Module Type.Data.Symbol

#### `append`

``` purescript
append :: forall l r o. Append l r o => Proxy l -> Proxy r -> Proxy o
```

#### `compare`

``` purescript
compare :: forall l r o. Compare l r o => Proxy l -> Proxy r -> Proxy o
```

#### `uncons`

``` purescript
uncons :: forall h t s. Cons h t s => Proxy s -> { head :: Proxy h, tail :: Proxy t }
```

#### `Equals`

``` purescript
class Equals lhs rhs out | lhs rhs -> out
```

##### Instances
``` purescript
(Compare lhs rhs ord, Equals EQ ord out) => Equals lhs rhs out
```

#### `equals`

``` purescript
equals :: forall l r o. Equals l r o => Proxy l -> Proxy r -> Proxy o
```


### Re-exported from Data.Symbol:

#### `IsSymbol`

``` purescript
class IsSymbol (sym :: Symbol)  where
  reflectSymbol :: Proxy sym -> String
```

A class for known symbols

#### `reifySymbol`

``` purescript
reifySymbol :: forall r. String -> (forall sym. IsSymbol sym => Proxy sym -> r) -> r
```

### Re-exported from Prim.Symbol:

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


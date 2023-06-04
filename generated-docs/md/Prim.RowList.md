## Module Prim.RowList

The Prim.RowList module is embedded in the PureScript compiler. Unlike `Prim`, it is not imported implicitly. It contains a type level list (`RowList`) that represents an ordered view of a row of types.
#### `RowList`

``` purescript
data RowList :: Type -> Type
```

A type level list representation of a row of types.

#### `Cons`

``` purescript
data Cons :: forall (k :: Type). Symbol -> k -> RowList k -> RowList k
```

Constructs a new `RowList` from a label, a type, and an existing tail
`RowList`.  E.g: `Cons "x" Int (Cons "y" Int Nil)`.

#### `Nil`

``` purescript
data Nil :: forall (k :: Type). RowList k
```

The empty `RowList`.

#### `RowToList`

``` purescript
class RowToList (row :: Row k) (list :: RowList k) | row -> list
```

Compiler solved type class for generating a `RowList` from a closed row
of types.  Entries are sorted by label and duplicates are preserved in
the order they appeared in the row.



## Module Type.RowList

#### `ListToRow`

``` purescript
class ListToRow list row | list -> row
```

Convert a RowList to a row of types.
The inverse of this operation is `RowToList`.

##### Instances
``` purescript
ListToRow Nil ()
(ListToRow tail tailRow, Cons label ty tailRow row) => ListToRow (Cons label ty tail) row
```

#### `RowListRemove`

``` purescript
class RowListRemove label input output | label input -> output
```

Remove all occurences of a given label from a RowList

##### Instances
``` purescript
RowListRemove label Nil Nil
(RowListRemove label tail tailOutput, Equals label key eq, If eq tailOutput (Cons key head tailOutput) output) => RowListRemove label (Cons key head tail) output
```

#### `RowListSet`

``` purescript
class RowListSet label typ input output | label typ input -> output
```

Add a label to a RowList after removing other occurences.

##### Instances
``` purescript
(TypeEquals label label', TypeEquals typ typ', RowListRemove label input lacking) => RowListSet label typ input (Cons label' typ' lacking)
```

#### `RowListNub`

``` purescript
class RowListNub input output | input -> output
```

Remove label duplicates, keeps earlier occurrences.

##### Instances
``` purescript
RowListNub Nil Nil
(TypeEquals label label', TypeEquals head head', TypeEquals nubbed nubbed', RowListRemove label tail removed, RowListNub removed nubbed) => RowListNub (Cons label head tail) (Cons label' head' nubbed')
```

#### `RowListAppend`

``` purescript
class RowListAppend lhs rhs out | lhs rhs -> out
```

##### Instances
``` purescript
(TypeEquals rhs out) => RowListAppend Nil rhs out
(RowListAppend tail rhs out', TypeEquals (Cons label head out') out) => RowListAppend (Cons label head tail) rhs out
```


### Re-exported from Prim.RowList:

#### `RowList`

``` purescript
data RowList :: Type -> Type
```

A type level list representation of a row of types.

#### `Nil`

``` purescript
data Nil :: forall (k :: Type). RowList k
```

The empty `RowList`.

#### `Cons`

``` purescript
data Cons :: forall (k :: Type). Symbol -> k -> RowList k -> RowList k
```

Constructs a new `RowList` from a label, a type, and an existing tail
`RowList`.  E.g: `Cons "x" Int (Cons "y" Int Nil)`.

#### `RowToList`

``` purescript
class RowToList (row :: Row k) (list :: RowList k) | row -> list
```

Compiler solved type class for generating a `RowList` from a closed row
of types.  Entries are sorted by label and duplicates are preserved in
the order they appeared in the row.


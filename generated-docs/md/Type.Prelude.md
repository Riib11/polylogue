## Module Type.Prelude


### Re-exported from Type.Data.Boolean:

#### `True`

``` purescript
data True :: Boolean
```

The 'True' boolean type.

#### `False`

``` purescript
data False :: Boolean
```

The 'False' boolean type.

#### `IsBoolean`

``` purescript
class IsBoolean bool  where
  reflectBoolean :: Proxy bool -> Boolean
```

Class for reflecting a type level `Boolean` at the value level

##### Instances
``` purescript
IsBoolean True
IsBoolean False
```

#### `reifyBoolean`

``` purescript
reifyBoolean :: forall r. Boolean -> (forall o. IsBoolean o => Proxy o -> r) -> r
```

Use a value level `Boolean` as a type-level `Boolean`

### Re-exported from Type.Data.Ordering:

#### `Ordering`

``` purescript
data Ordering :: Type
```

The `Ordering` kind represents the three possibilities of comparing two
types of the same kind: `LT` (less than), `EQ` (equal to), and
`GT` (greater than).

#### `LT`

``` purescript
data LT :: Ordering
```

The 'less than' ordering type.

#### `GT`

``` purescript
data GT :: Ordering
```

The 'greater than' ordering type.

#### `EQ`

``` purescript
data EQ :: Ordering
```

The 'equal to' ordering type.

#### `IsOrdering`

``` purescript
class IsOrdering ordering  where
  reflectOrdering :: Proxy ordering -> Ordering
```

Class for reflecting a type level `Ordering` at the value level

##### Instances
``` purescript
IsOrdering LT
IsOrdering EQ
IsOrdering GT
```

#### `reifyOrdering`

``` purescript
reifyOrdering :: forall r. Ordering -> (forall o. IsOrdering o => Proxy o -> r) -> r
```

Use a value level `Ordering` as a type-level `Ordering`

### Re-exported from Type.Data.Symbol:

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

#### `compare`

``` purescript
compare :: forall l r o. Compare l r o => Proxy l -> Proxy r -> Proxy o
```

#### `append`

``` purescript
append :: forall l r o. Append l r o => Proxy l -> Proxy r -> Proxy o
```

### Re-exported from Type.Equality:

#### `TypeEquals`

``` purescript
class (Coercible a b) <= TypeEquals a b | a -> b, b -> a
```

This type class asserts that types `a` and `b`
are equal.

The functional dependencies and the single
instance below will force the two type arguments
to unify when either one is known.

Note: any instance will necessarily overlap with
`refl` below, so instances of this class should
not be defined in libraries.

##### Instances
``` purescript
TypeEquals a a
```

#### `to`

``` purescript
to :: forall a b. TypeEquals a b => a -> b
```

#### `from`

``` purescript
from :: forall a b. TypeEquals a b => b -> a
```

### Re-exported from Type.Proxy:

#### `Proxy`

``` purescript
data Proxy a
  = Proxy
```

Proxy type for all `kind`s.

### Re-exported from Type.Row:

#### `Lacks`

``` purescript
class Lacks (label :: Symbol) (row :: Row k) 
```

The Lacks type class asserts that a label does not occur in a given row.

#### `Union`

``` purescript
class Union (left :: Row k) (right :: Row k) (union :: Row k) | left right -> union, right union -> left, union left -> right
```

The Union type class is used to compute the union of two rows of types
(left-biased, including duplicates).

The third type argument represents the union of the first two.

### Re-exported from Type.RowList:

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

#### `RowToList`

``` purescript
class RowToList (row :: Row k) (list :: RowList k) | row -> list
```

Compiler solved type class for generating a `RowList` from a closed row
of types.  Entries are sorted by label and duplicates are preserved in
the order they appeared in the row.


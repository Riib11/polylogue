## Module Type.Row

#### `RowApply`

``` purescript
type RowApply f a = f a
```

Type application for rows.

#### `type (+)`

``` purescript
infixr 0 type RowApply as ype (+
```

Applies a type alias of open rows to a set of rows. The primary use case
this operator is as convenient sugar for combining open rows without
parentheses.
```purescript
type Rows1 r = (a :: Int, b :: String | r)
type Rows2 r = (c :: Boolean | r)
type Rows3 r = (Rows1 + Rows2 + r)
type Rows4 r = (d :: String | Rows1 + Rows2 + r)
```


### Re-exported from Prim.Row:

#### `Cons`

``` purescript
class Cons (label :: Symbol) (a :: k) (tail :: Row k) (row :: Row k) | label a tail -> row, label row -> a tail
```

The Cons type class is a 4-way relation which asserts that one row of
types can be obtained from another by inserting a new label/type pair on
the left.

#### `Lacks`

``` purescript
class Lacks (label :: Symbol) (row :: Row k) 
```

The Lacks type class asserts that a label does not occur in a given row.

#### `Nub`

``` purescript
class Nub (original :: Row k) (nubbed :: Row k) | original -> nubbed
```

The Nub type class is used to remove duplicate labels from rows.

#### `Union`

``` purescript
class Union (left :: Row k) (right :: Row k) (union :: Row k) | left right -> union, right union -> left, union left -> right
```

The Union type class is used to compute the union of two rows of types
(left-biased, including duplicates).

The third type argument represents the union of the first two.


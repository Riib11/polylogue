## Module Prim.Row

The Prim.Row module is embedded in the PureScript compiler. Unlike `Prim`, it is not imported implicitly. It contains automatically solved type classes for working with row types.
#### `Union`

``` purescript
class Union (left :: Row k) (right :: Row k) (union :: Row k) | left right -> union, right union -> left, union left -> right
```

The Union type class is used to compute the union of two rows of types
(left-biased, including duplicates).

The third type argument represents the union of the first two.

#### `Nub`

``` purescript
class Nub (original :: Row k) (nubbed :: Row k) | original -> nubbed
```

The Nub type class is used to remove duplicate labels from rows.

#### `Lacks`

``` purescript
class Lacks (label :: Symbol) (row :: Row k) 
```

The Lacks type class asserts that a label does not occur in a given row.

#### `Cons`

``` purescript
class Cons (label :: Symbol) (a :: k) (tail :: Row k) (row :: Row k) | label a tail -> row, label row -> a tail
```

The Cons type class is a 4-way relation which asserts that one row of
types can be obtained from another by inserting a new label/type pair on
the left.



## Module Data.BooleanAlgebra

#### `BooleanAlgebra`

``` purescript
class (HeytingAlgebra a) <= BooleanAlgebra a 
```

The `BooleanAlgebra` type class represents types that behave like boolean
values.

Instances should satisfy the following laws in addition to the
`HeytingAlgebra` law:

- Excluded middle:
  - `a || not a = tt`

##### Instances
``` purescript
BooleanAlgebra Boolean
BooleanAlgebra Unit
(BooleanAlgebra b) => BooleanAlgebra (a -> b)
(RowToList row list, BooleanAlgebraRecord list row row) => BooleanAlgebra (Record row)
BooleanAlgebra (Proxy a)
```

#### `BooleanAlgebraRecord`

``` purescript
class (HeytingAlgebraRecord rowlist row subrow) <= BooleanAlgebraRecord rowlist row subrow | rowlist -> subrow
```

A class for records where all fields have `BooleanAlgebra` instances, used
to implement the `BooleanAlgebra` instance for records.

##### Instances
``` purescript
BooleanAlgebraRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, BooleanAlgebraRecord rowlistTail row subrowTail, BooleanAlgebra focus) => BooleanAlgebraRecord (Cons key focus rowlistTail) row subrow
```


### Re-exported from Data.HeytingAlgebra:

#### `HeytingAlgebra`

``` purescript
class HeytingAlgebra a  where
  ff :: a
  tt :: a
  implies :: a -> a -> a
  conj :: a -> a -> a
  disj :: a -> a -> a
  not :: a -> a
```

The `HeytingAlgebra` type class represents types that are bounded lattices with
an implication operator such that the following laws hold:

- Associativity:
  - `a || (b || c) = (a || b) || c`
  - `a && (b && c) = (a && b) && c`
- Commutativity:
  - `a || b = b || a`
  - `a && b = b && a`
- Absorption:
  - `a || (a && b) = a`
  - `a && (a || b) = a`
- Idempotent:
  - `a || a = a`
  - `a && a = a`
- Identity:
  - `a || ff = a`
  - `a && tt = a`
- Implication:
  - ``a `implies` a = tt``
  - ``a && (a `implies` b) = a && b``
  - ``b && (a `implies` b) = b``
  - ``a `implies` (b && c) = (a `implies` b) && (a `implies` c)``
- Complemented:
  - ``not a = a `implies` ff``

##### Instances
``` purescript
HeytingAlgebra Boolean
HeytingAlgebra Unit
(HeytingAlgebra b) => HeytingAlgebra (a -> b)
HeytingAlgebra (Proxy a)
(RowToList row list, HeytingAlgebraRecord list row row) => HeytingAlgebra (Record row)
```

#### `HeytingAlgebraRecord`

``` purescript
class HeytingAlgebraRecord rowlist row subrow | rowlist -> subrow
```

A class for records where all fields have `HeytingAlgebra` instances, used
to implement the `HeytingAlgebra` instance for records.

##### Instances
``` purescript
HeytingAlgebraRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, HeytingAlgebraRecord rowlistTail row subrowTail, HeytingAlgebra focus) => HeytingAlgebraRecord (Cons key focus rowlistTail) row subrow
```

#### `(||)`

``` purescript
infixr 2 disj as ||
```

#### `(&&)`

``` purescript
infixr 3 conj as &&
```


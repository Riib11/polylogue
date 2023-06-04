## Module Data.HeytingAlgebra

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

#### `(&&)`

``` purescript
infixr 3 conj as &&
```

#### `(||)`

``` purescript
infixr 2 disj as ||
```

#### `HeytingAlgebraRecord`

``` purescript
class HeytingAlgebraRecord rowlist row subrow | rowlist -> subrow where
  ffRecord :: Proxy rowlist -> Proxy row -> Record subrow
  ttRecord :: Proxy rowlist -> Proxy row -> Record subrow
  impliesRecord :: Proxy rowlist -> Record row -> Record row -> Record subrow
  disjRecord :: Proxy rowlist -> Record row -> Record row -> Record subrow
  conjRecord :: Proxy rowlist -> Record row -> Record row -> Record subrow
  notRecord :: Proxy rowlist -> Record row -> Record subrow
```

A class for records where all fields have `HeytingAlgebra` instances, used
to implement the `HeytingAlgebra` instance for records.

##### Instances
``` purescript
HeytingAlgebraRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, HeytingAlgebraRecord rowlistTail row subrowTail, HeytingAlgebra focus) => HeytingAlgebraRecord (Cons key focus rowlistTail) row subrow
```



## Module Data.Semiring

#### `Semiring`

``` purescript
class Semiring a  where
  add :: a -> a -> a
  zero :: a
  mul :: a -> a -> a
  one :: a
```

The `Semiring` class is for types that support an addition and
multiplication operation.

Instances must satisfy the following laws:

- Commutative monoid under addition:
  - Associativity: `(a + b) + c = a + (b + c)`
  - Identity: `zero + a = a + zero = a`
  - Commutative: `a + b = b + a`
- Monoid under multiplication:
  - Associativity: `(a * b) * c = a * (b * c)`
  - Identity: `one * a = a * one = a`
- Multiplication distributes over addition:
  - Left distributivity: `a * (b + c) = (a * b) + (a * c)`
  - Right distributivity: `(a + b) * c = (a * c) + (b * c)`
- Annihilation: `zero * a = a * zero = zero`

**Note:** The `Number` and `Int` types are not fully law abiding
members of this class hierarchy due to the potential for arithmetic
overflows, and in the case of `Number`, the presence of `NaN` and
`Infinity` values. The behaviour is unspecified in these cases.

##### Instances
``` purescript
Semiring Int
Semiring Number
(Semiring b) => Semiring (a -> b)
Semiring Unit
Semiring (Proxy a)
(RowToList row list, SemiringRecord list row row) => Semiring (Record row)
```

#### `(+)`

``` purescript
infixl 6 add as +
```

#### `(*)`

``` purescript
infixl 7 mul as *
```

#### `SemiringRecord`

``` purescript
class SemiringRecord rowlist row subrow | rowlist -> subrow where
  addRecord :: Proxy rowlist -> Record row -> Record row -> Record subrow
  mulRecord :: Proxy rowlist -> Record row -> Record row -> Record subrow
  oneRecord :: Proxy rowlist -> Proxy row -> Record subrow
  zeroRecord :: Proxy rowlist -> Proxy row -> Record subrow
```

A class for records where all fields have `Semiring` instances, used to
implement the `Semiring` instance for records.

##### Instances
``` purescript
SemiringRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, SemiringRecord rowlistTail row subrowTail, Semiring focus) => SemiringRecord (Cons key focus rowlistTail) row subrow
```



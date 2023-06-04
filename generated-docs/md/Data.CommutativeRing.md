## Module Data.CommutativeRing

#### `CommutativeRing`

``` purescript
class (Ring a) <= CommutativeRing a 
```

The `CommutativeRing` class is for rings where multiplication is
commutative.

Instances must satisfy the following law in addition to the `Ring`
laws:

- Commutative multiplication: `a * b = b * a`

##### Instances
``` purescript
CommutativeRing Int
CommutativeRing Number
CommutativeRing Unit
(CommutativeRing b) => CommutativeRing (a -> b)
(RowToList row list, CommutativeRingRecord list row row) => CommutativeRing (Record row)
CommutativeRing (Proxy a)
```

#### `CommutativeRingRecord`

``` purescript
class (RingRecord rowlist row subrow) <= CommutativeRingRecord rowlist row subrow | rowlist -> subrow
```

A class for records where all fields have `CommutativeRing` instances, used
to implement the `CommutativeRing` instance for records.

##### Instances
``` purescript
CommutativeRingRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, CommutativeRingRecord rowlistTail row subrowTail, CommutativeRing focus) => CommutativeRingRecord (Cons key focus rowlistTail) row subrow
```


### Re-exported from Data.Ring:

#### `Ring`

``` purescript
class (Semiring a) <= Ring a 
```

The `Ring` class is for types that support addition, multiplication,
and subtraction operations.

Instances must satisfy the following laws in addition to the `Semiring`
laws:

- Additive inverse: `a - a = zero`
- Compatibility of `sub` and `negate`: `a - b = a + (zero - b)`

##### Instances
``` purescript
Ring Int
Ring Number
Ring Unit
(Ring b) => Ring (a -> b)
Ring (Proxy a)
(RowToList row list, RingRecord list row row) => Ring (Record row)
```

#### `RingRecord`

``` purescript
class (SemiringRecord rowlist row subrow) <= RingRecord rowlist row subrow | rowlist -> subrow
```

A class for records where all fields have `Ring` instances, used to
implement the `Ring` instance for records.

##### Instances
``` purescript
RingRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, RingRecord rowlistTail row subrowTail, Ring focus) => RingRecord (Cons key focus rowlistTail) row subrow
```

### Re-exported from Data.Semiring:

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


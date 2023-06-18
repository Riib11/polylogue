## Module Data.DivisionRing

#### `DivisionRing`

``` purescript
class (Ring a) <= DivisionRing a  where
  recip :: a -> a
```

The `DivisionRing` class is for non-zero rings in which every non-zero
element has a multiplicative inverse. Division rings are sometimes also
called *skew fields*.

Instances must satisfy the following laws in addition to the `Ring` laws:

- Non-zero ring: `one /= zero`
- Non-zero multiplicative inverse: `recip a * a = a * recip a = one` for
  all non-zero `a`

The result of `recip zero` is left undefined; individual instances may
choose how to handle this case.

If a type has both `DivisionRing` and `CommutativeRing` instances, then
it is a field and should have a `Field` instance.

##### Instances
``` purescript
DivisionRing Number
```

#### `leftDiv`

``` purescript
leftDiv :: forall a. DivisionRing a => a -> a -> a
```

Left division, defined as `leftDiv a b = recip b * a`. Left and right
division are distinct in this module because a `DivisionRing` is not
necessarily commutative.

If the type `a` is also a `EuclideanRing`, then this function is
equivalent to `div` from the `EuclideanRing` class. When working
abstractly, `div` should generally be preferred, unless you know that you
need your code to work with noncommutative rings.

#### `rightDiv`

``` purescript
rightDiv :: forall a. DivisionRing a => a -> a -> a
```

Right division, defined as `rightDiv a b = a * recip b`. Left and right
division are distinct in this module because a `DivisionRing` is not
necessarily commutative.

If the type `a` is also a `EuclideanRing`, then this function is
equivalent to `div` from the `EuclideanRing` class. When working
abstractly, `div` should generally be preferred, unless you know that you
need your code to work with noncommutative rings.


### Re-exported from Data.Ring:

#### `Ring`

``` purescript
class (Semiring a) <= Ring a  where
  sub :: a -> a -> a
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

#### `negate`

``` purescript
negate :: forall a. Ring a => a -> a
```

`negate x` can be used as a shorthand for `zero - x`.

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


## Module Data.Field

#### `Field`

``` purescript
class (EuclideanRing a, DivisionRing a) <= Field a 
```

The `Field` class is for types that are (commutative) fields.

Mathematically, a field is a ring which is commutative and in which every
nonzero element has a multiplicative inverse; these conditions correspond
to the `CommutativeRing` and `DivisionRing` classes in PureScript
respectively. However, the `Field` class has `EuclideanRing` and
`DivisionRing` as superclasses, which seems like a stronger requirement
(since `CommutativeRing` is a superclass of `EuclideanRing`). In fact, it
is not stronger, since any type which has law-abiding `CommutativeRing`
and `DivisionRing` instances permits exactly one law-abiding
`EuclideanRing` instance. We use a `EuclideanRing` superclass here in
order to ensure that a `Field` constraint on a function permits you to use
`div` on that type, since `div` is a member of `EuclideanRing`.

This class has no laws or members of its own; it exists as a convenience,
so a single constraint can be used when field-like behaviour is expected.

This module also defines a single `Field` instance for any type which has
both `EuclideanRing` and `DivisionRing` instances. Any other instance
would overlap with this instance, so no other `Field` instances should be
defined in libraries. Instead, simply define `EuclideanRing` and
`DivisionRing` instances, and this will permit your type to be used with a
`Field` constraint.

##### Instances
``` purescript
(EuclideanRing a, DivisionRing a) => Field a
```


### Re-exported from Data.CommutativeRing:

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

### Re-exported from Data.DivisionRing:

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

### Re-exported from Data.EuclideanRing:

#### `EuclideanRing`

``` purescript
class (CommutativeRing a) <= EuclideanRing a  where
  degree :: a -> Int
  div :: a -> a -> a
  mod :: a -> a -> a
```

The `EuclideanRing` class is for commutative rings that support division.
The mathematical structure this class is based on is sometimes also called
a *Euclidean domain*.

Instances must satisfy the following laws in addition to the `Ring`
laws:

- Integral domain: `one /= zero`, and if `a` and `b` are both nonzero then
  so is their product `a * b`
- Euclidean function `degree`:
  - Nonnegativity: For all nonzero `a`, `degree a >= 0`
  - Quotient/remainder: For all `a` and `b`, where `b` is nonzero,
    let `q = a / b` and ``r = a `mod` b``; then `a = q*b + r`, and also
    either `r = zero` or `degree r < degree b`
- Submultiplicative euclidean function:
  - For all nonzero `a` and `b`, `degree a <= degree (a * b)`

The behaviour of division by `zero` is unconstrained by these laws,
meaning that individual instances are free to choose how to behave in this
case. Similarly, there are no restrictions on what the result of
`degree zero` is; it doesn't make sense to ask for `degree zero` in the
same way that it doesn't make sense to divide by `zero`, so again,
individual instances may choose how to handle this case.

For any `EuclideanRing` which is also a `Field`, one valid choice
for `degree` is simply `const 1`. In fact, unless there's a specific
reason not to, `Field` types should normally use this definition of
`degree`.

The `EuclideanRing Int` instance is one of the most commonly used
`EuclideanRing` instances and deserves a little more discussion. In
particular, there are a few different sensible law-abiding implementations
to choose from, with slightly different behaviour in the presence of
negative dividends or divisors. The most common definitions are "truncating"
division, where the result of `a / b` is rounded towards 0, and "Knuthian"
or "flooring" division, where the result of `a / b` is rounded towards
negative infinity. A slightly less common, but arguably more useful, option
is "Euclidean" division, which is defined so as to ensure that ``a `mod` b``
is always nonnegative. With Euclidean division, `a / b` rounds towards
negative infinity if the divisor is positive, and towards positive infinity
if the divisor is negative. Note that all three definitions are identical if
we restrict our attention to nonnegative dividends and divisors.

In versions 1.x, 2.x, and 3.x of the Prelude, the `EuclideanRing Int`
instance used truncating division. As of 4.x, the `EuclideanRing Int`
instance uses Euclidean division. Additional functions `quot` and `rem` are
supplied if truncating division is desired.

##### Instances
``` purescript
EuclideanRing Int
EuclideanRing Number
```

#### `lcm`

``` purescript
lcm :: forall a. Eq a => EuclideanRing a => a -> a -> a
```

The *least common multiple* of two values.

#### `gcd`

``` purescript
gcd :: forall a. Eq a => EuclideanRing a => a -> a -> a
```

The *greatest common divisor* of two values.

#### `(/)`

``` purescript
infixl 7 div as /
```

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


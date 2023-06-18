## Module Data.Semiring.Generic

#### `GenericSemiring`

``` purescript
class GenericSemiring a  where
  genericAdd' :: a -> a -> a
  genericZero' :: a
  genericMul' :: a -> a -> a
  genericOne' :: a
```

##### Instances
``` purescript
GenericSemiring NoArguments
(Semiring a) => GenericSemiring (Argument a)
(GenericSemiring a, GenericSemiring b) => GenericSemiring (Product a b)
(GenericSemiring a) => GenericSemiring (Constructor name a)
```

#### `genericZero`

``` purescript
genericZero :: forall a rep. Generic a rep => GenericSemiring rep => a
```

A `Generic` implementation of the `zero` member from the `Semiring` type class.

#### `genericOne`

``` purescript
genericOne :: forall a rep. Generic a rep => GenericSemiring rep => a
```

A `Generic` implementation of the `one` member from the `Semiring` type class.

#### `genericAdd`

``` purescript
genericAdd :: forall a rep. Generic a rep => GenericSemiring rep => a -> a -> a
```

A `Generic` implementation of the `add` member from the `Semiring` type class.

#### `genericMul`

``` purescript
genericMul :: forall a rep. Generic a rep => GenericSemiring rep => a -> a -> a
```

A `Generic` implementation of the `mul` member from the `Semiring` type class.



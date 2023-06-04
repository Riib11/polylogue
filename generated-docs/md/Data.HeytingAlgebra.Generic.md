## Module Data.HeytingAlgebra.Generic

#### `GenericHeytingAlgebra`

``` purescript
class GenericHeytingAlgebra a  where
  genericFF' :: a
  genericTT' :: a
  genericImplies' :: a -> a -> a
  genericConj' :: a -> a -> a
  genericDisj' :: a -> a -> a
  genericNot' :: a -> a
```

##### Instances
``` purescript
GenericHeytingAlgebra NoArguments
(HeytingAlgebra a) => GenericHeytingAlgebra (Argument a)
(GenericHeytingAlgebra a, GenericHeytingAlgebra b) => GenericHeytingAlgebra (Product a b)
(GenericHeytingAlgebra a) => GenericHeytingAlgebra (Constructor name a)
```

#### `genericFF`

``` purescript
genericFF :: forall a rep. Generic a rep => GenericHeytingAlgebra rep => a
```

A `Generic` implementation of the `ff` member from the `HeytingAlgebra` type class.

#### `genericTT`

``` purescript
genericTT :: forall a rep. Generic a rep => GenericHeytingAlgebra rep => a
```

A `Generic` implementation of the `tt` member from the `HeytingAlgebra` type class.

#### `genericImplies`

``` purescript
genericImplies :: forall a rep. Generic a rep => GenericHeytingAlgebra rep => a -> a -> a
```

A `Generic` implementation of the `implies` member from the `HeytingAlgebra` type class.

#### `genericConj`

``` purescript
genericConj :: forall a rep. Generic a rep => GenericHeytingAlgebra rep => a -> a -> a
```

A `Generic` implementation of the `conj` member from the `HeytingAlgebra` type class.

#### `genericDisj`

``` purescript
genericDisj :: forall a rep. Generic a rep => GenericHeytingAlgebra rep => a -> a -> a
```

A `Generic` implementation of the `disj` member from the `HeytingAlgebra` type class.

#### `genericNot`

``` purescript
genericNot :: forall a rep. Generic a rep => GenericHeytingAlgebra rep => a -> a
```

A `Generic` implementation of the `not` member from the `HeytingAlgebra` type class.



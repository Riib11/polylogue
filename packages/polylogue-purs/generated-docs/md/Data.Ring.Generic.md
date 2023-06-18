## Module Data.Ring.Generic

#### `GenericRing`

``` purescript
class GenericRing a  where
  genericSub' :: a -> a -> a
```

##### Instances
``` purescript
GenericRing NoArguments
(Ring a) => GenericRing (Argument a)
(GenericRing a, GenericRing b) => GenericRing (Product a b)
(GenericRing a) => GenericRing (Constructor name a)
```

#### `genericSub`

``` purescript
genericSub :: forall a rep. Generic a rep => GenericRing rep => a -> a -> a
```

A `Generic` implementation of the `sub` member from the `Ring` type class.



## Module Data.Eq.Generic

#### `GenericEq`

``` purescript
class GenericEq a  where
  genericEq' :: a -> a -> Boolean
```

##### Instances
``` purescript
GenericEq NoConstructors
GenericEq NoArguments
(GenericEq a, GenericEq b) => GenericEq (Sum a b)
(GenericEq a, GenericEq b) => GenericEq (Product a b)
(GenericEq a) => GenericEq (Constructor name a)
(Eq a) => GenericEq (Argument a)
```

#### `genericEq`

``` purescript
genericEq :: forall a rep. Generic a rep => GenericEq rep => a -> a -> Boolean
```

A `Generic` implementation of the `eq` member from the `Eq` type class.



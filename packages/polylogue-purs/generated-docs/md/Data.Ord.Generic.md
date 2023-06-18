## Module Data.Ord.Generic

#### `GenericOrd`

``` purescript
class GenericOrd a  where
  genericCompare' :: a -> a -> Ordering
```

##### Instances
``` purescript
GenericOrd NoConstructors
GenericOrd NoArguments
(GenericOrd a, GenericOrd b) => GenericOrd (Sum a b)
(GenericOrd a, GenericOrd b) => GenericOrd (Product a b)
(GenericOrd a) => GenericOrd (Constructor name a)
(Ord a) => GenericOrd (Argument a)
```

#### `genericCompare`

``` purescript
genericCompare :: forall a rep. Generic a rep => GenericOrd rep => a -> a -> Ordering
```

A `Generic` implementation of the `compare` member from the `Ord` type class.



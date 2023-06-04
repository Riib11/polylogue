## Module Data.Semigroup.Generic

#### `GenericSemigroup`

``` purescript
class GenericSemigroup a  where
  genericAppend' :: a -> a -> a
```

##### Instances
``` purescript
GenericSemigroup NoConstructors
GenericSemigroup NoArguments
(GenericSemigroup a, GenericSemigroup b) => GenericSemigroup (Product a b)
(GenericSemigroup a) => GenericSemigroup (Constructor name a)
(Semigroup a) => GenericSemigroup (Argument a)
```

#### `genericAppend`

``` purescript
genericAppend :: forall a rep. Generic a rep => GenericSemigroup rep => a -> a -> a
```

A `Generic` implementation of the `append` member from the `Semigroup` type class.



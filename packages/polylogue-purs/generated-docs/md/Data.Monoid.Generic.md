## Module Data.Monoid.Generic

#### `GenericMonoid`

``` purescript
class GenericMonoid a  where
  genericMempty' :: a
```

##### Instances
``` purescript
GenericMonoid NoArguments
(GenericMonoid a, GenericMonoid b) => GenericMonoid (Product a b)
(GenericMonoid a) => GenericMonoid (Constructor name a)
(Monoid a) => GenericMonoid (Argument a)
```

#### `genericMempty`

``` purescript
genericMempty :: forall a rep. Generic a rep => GenericMonoid rep => a
```

A `Generic` implementation of the `mempty` member from the `Monoid` type class.



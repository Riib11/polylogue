## Module Data.Bounded.Generic

#### `GenericBottom`

``` purescript
class GenericBottom a  where
  genericBottom' :: a
```

##### Instances
``` purescript
GenericBottom NoArguments
(Bounded a) => GenericBottom (Argument a)
(GenericBottom a) => GenericBottom (Sum a b)
(GenericBottom a, GenericBottom b) => GenericBottom (Product a b)
(GenericBottom a) => GenericBottom (Constructor name a)
```

#### `genericBottom`

``` purescript
genericBottom :: forall a rep. Generic a rep => GenericBottom rep => a
```

A `Generic` implementation of the `bottom` member from the `Bounded` type class.

#### `GenericTop`

``` purescript
class GenericTop a  where
  genericTop' :: a
```

##### Instances
``` purescript
GenericTop NoArguments
(Bounded a) => GenericTop (Argument a)
(GenericTop b) => GenericTop (Sum a b)
(GenericTop a, GenericTop b) => GenericTop (Product a b)
(GenericTop a) => GenericTop (Constructor name a)
```

#### `genericTop`

``` purescript
genericTop :: forall a rep. Generic a rep => GenericTop rep => a
```

A `Generic` implementation of the `top` member from the `Bounded` type class.



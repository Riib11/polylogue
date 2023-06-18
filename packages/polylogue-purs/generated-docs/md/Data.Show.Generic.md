## Module Data.Show.Generic

#### `GenericShow`

``` purescript
class GenericShow a  where
  genericShow' :: a -> String
```

##### Instances
``` purescript
GenericShow NoConstructors
(GenericShow a, GenericShow b) => GenericShow (Sum a b)
(GenericShowArgs a, IsSymbol name) => GenericShow (Constructor name a)
```

#### `genericShow`

``` purescript
genericShow :: forall a rep. Generic a rep => GenericShow rep => a -> String
```

A `Generic` implementation of the `show` member from the `Show` type class.

#### `GenericShowArgs`

``` purescript
class GenericShowArgs a  where
  genericShowArgs :: a -> Array String
```

##### Instances
``` purescript
GenericShowArgs NoArguments
(GenericShowArgs a, GenericShowArgs b) => GenericShowArgs (Product a b)
(Show a) => GenericShowArgs (Argument a)
```



## Module Data.Functor.Coproduct.Inject

#### `Inject`

``` purescript
class Inject f g  where
  inj :: forall a. f a -> g a
  prj :: forall a. g a -> Maybe (f a)
```

##### Instances
``` purescript
Inject f f
Inject f (Coproduct f g)
(Inject f g) => Inject f (Coproduct h g)
```



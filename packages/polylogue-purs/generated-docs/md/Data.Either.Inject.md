## Module Data.Either.Inject

#### `Inject`

``` purescript
class Inject a b  where
  inj :: a -> b
  prj :: b -> Maybe a
```

##### Instances
``` purescript
Inject a a
Inject a (Either a b)
(Inject a b) => Inject a (Either c b)
```



## Module Control.Monad.ST.Class

#### `MonadST`

``` purescript
class (Monad m) <= MonadST s m | m -> s where
  liftST :: (ST s) ~> m
```

##### Instances
``` purescript
MonadST Global Effect
MonadST s (ST s)
```



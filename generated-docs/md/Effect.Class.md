## Module Effect.Class

#### `MonadEffect`

``` purescript
class (Monad m) <= MonadEffect m  where
  liftEffect :: forall a. Effect a -> m a
```

The `MonadEffect` class captures those monads which support native effects.

Instances are provided for `Effect` itself, and the standard monad
transformers.

`liftEffect` can be used in any appropriate monad transformer stack to lift an
action of type `Effect a` into the monad.


##### Instances
``` purescript
MonadEffect Effect
```



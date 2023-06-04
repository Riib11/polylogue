## Module Control.Monad.Free.Class

#### `MonadFree`

``` purescript
class (Monad m) <= MonadFree f m | m -> f where
  wrapFree :: forall a. f (m a) -> m a
```

Based on <http://hackage.haskell.org/package/free/docs/Control-Monad-Free-Class.html>

##### Instances
``` purescript
MonadFree f (Free f)
(Functor f, MonadFree f m) => MonadFree f (ReaderT r m)
(Functor f, MonadFree f m) => MonadFree f (StateT s m)
(Functor f, MonadFree f m, Monoid w) => MonadFree f (WriterT w m)
(Functor f, MonadFree f m) => MonadFree f (MaybeT m)
(Functor f, MonadFree f m) => MonadFree f (ExceptT e m)
```



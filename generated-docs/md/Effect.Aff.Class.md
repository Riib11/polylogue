## Module Effect.Aff.Class

#### `MonadAff`

``` purescript
class (MonadEffect m) <= MonadAff m  where
  liftAff :: Aff ~> m
```

##### Instances
``` purescript
MonadAff Aff
(MonadAff m) => MonadAff (ContT r m)
(MonadAff m) => MonadAff (ExceptT e m)
(MonadAff m) => MonadAff (ListT m)
(MonadAff m) => MonadAff (MaybeT m)
(MonadAff m) => MonadAff (ReaderT r m)
(MonadAff m, Monoid w) => MonadAff (RWST r w s m)
(MonadAff m) => MonadAff (StateT s m)
(MonadAff m, Monoid w) => MonadAff (WriterT w m)
```



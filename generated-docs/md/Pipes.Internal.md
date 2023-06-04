## Module Pipes.Internal

#### `Proxy`

``` purescript
data Proxy a' a b' b m r
  = Request a' (a -> Proxy a' a b' b m r)
  | Respond b (b' -> Proxy a' a b' b m r)
  | M (m (Proxy a' a b' b m r))
  | Pure r
```

##### Instances
``` purescript
(Monad m) => Functor (Proxy a' a b' b m)
(Monad m) => Apply (Proxy a' a b' b m)
(Monad m) => Applicative (Proxy a' a b' b m)
(Monad m) => Bind (Proxy a' a b' b m)
(Monad m) => Monad (Proxy a' a b' b m)
(Monad m, Monoid r) => Monoid (Proxy a' a b' b m r)
(Monad m, Semigroup r) => Semigroup (Proxy a' a b' b m r)
MonadTrans (Proxy a' a b' b)
MFunctor (Proxy a' a b' b)
MMonad (Proxy a' a b' b)
(MonadEffect m) => MonadEffect (Proxy a' a b' b m)
(MonadAff m) => MonadAff (Proxy a' a b' b m)
(MonadAsk r m) => MonadAsk r (Proxy a' a b' b m)
(MonadReader r m) => MonadReader r (Proxy a' a b' b m)
(MonadState s m) => MonadState s (Proxy a' a b' b m)
(Monoid w, MonadTell w m) => MonadTell w (Proxy a' a b' b m)
(Monoid w, MonadWriter w m) => MonadWriter w (Proxy a' a b' b m)
(MonadPlus m) => Alt (Proxy a' a b' b m)
(MonadPlus m) => Plus (Proxy a' a b' b m)
(MonadPlus m) => Alternative (Proxy a' a b' b m)
(MonadThrow e m) => MonadThrow e (Proxy a' a b' b m)
(MonadError e m) => MonadError e (Proxy a' a b' b m)
(Monad m) => MonadRec (Proxy a' a b' b m)
```

#### `observe`

``` purescript
observe :: forall m a' a b' b r. Monad m => Proxy a' a b' b m r -> Proxy a' a b' b m r
```

#### `X`

``` purescript
newtype X
  = X X
```

#### `closed`

``` purescript
closed :: forall a. X -> a
```



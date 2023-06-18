## Module Control.Monad.Identity.Trans

#### `IdentityT`

``` purescript
newtype IdentityT m a
  = IdentityT (m a)
```

The `IdentityT` monad transformer.

This monad acts like a placeholder for functions that take a monad
transformer as an argument, similar to `identity` for functions and
`Identity` for monads.

##### Instances
``` purescript
(Eq1 m, Eq a) => Eq (IdentityT m a)
(Ord1 m, Ord a) => Ord (IdentityT m a)
(Eq1 m) => Eq1 (IdentityT m)
(Ord1 m) => Ord1 (IdentityT m)
Newtype (IdentityT m a) _
(Functor m) => Functor (IdentityT m)
(Apply m) => Apply (IdentityT m)
(Applicative m) => Applicative (IdentityT m)
(Alt m) => Alt (IdentityT m)
(Plus m) => Plus (IdentityT m)
(Alternative m) => Alternative (IdentityT m)
(Bind m) => Bind (IdentityT m)
(Monad m) => Monad (IdentityT m)
(MonadRec m) => MonadRec (IdentityT m)
(MonadPlus m) => MonadPlus (IdentityT m)
MonadTrans IdentityT
(MonadEffect m) => MonadEffect (IdentityT m)
(MonadCont m) => MonadCont (IdentityT m)
(MonadThrow e m) => MonadThrow e (IdentityT m)
(MonadError e m) => MonadError e (IdentityT m)
(MonadAsk r m) => MonadAsk r (IdentityT m)
(MonadReader r m) => MonadReader r (IdentityT m)
(MonadState s m) => MonadState s (IdentityT m)
(MonadTell w m) => MonadTell w (IdentityT m)
(MonadWriter w m) => MonadWriter w (IdentityT m)
(Foldable m) => Foldable (IdentityT m)
(Traversable m) => Traversable (IdentityT m)
```

#### `runIdentityT`

``` purescript
runIdentityT :: forall m a. IdentityT m a -> m a
```

Run a computation in the `IdentityT` monad.

#### `mapIdentityT`

``` purescript
mapIdentityT :: forall m1 m2 a b. (m1 a -> m2 b) -> IdentityT m1 a -> IdentityT m2 b
```

Change the result type of a `IdentityT` monad action.



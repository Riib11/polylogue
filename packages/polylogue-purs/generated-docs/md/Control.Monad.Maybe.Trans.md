## Module Control.Monad.Maybe.Trans

This module defines the `MaybeT` monad transformer.

#### `MaybeT`

``` purescript
newtype MaybeT m a
  = MaybeT (m (Maybe a))
```

The `MaybeT` monad transformer.

This monad transformer extends the base monad, supporting failure and alternation via
the `MonadPlus` type class.

##### Instances
``` purescript
Newtype (MaybeT m a) _
(Functor m) => Functor (MaybeT m)
(Monad m) => Apply (MaybeT m)
(Monad m) => Applicative (MaybeT m)
(Monad m) => Bind (MaybeT m)
(Monad m) => Monad (MaybeT m)
MonadTrans MaybeT
(Monad m) => Alt (MaybeT m)
(Monad m) => Plus (MaybeT m)
(Monad m) => Alternative (MaybeT m)
(Monad m) => MonadPlus (MaybeT m)
(MonadRec m) => MonadRec (MaybeT m)
(MonadEffect m) => MonadEffect (MaybeT m)
(MonadCont m) => MonadCont (MaybeT m)
(MonadThrow e m) => MonadThrow e (MaybeT m)
(MonadError e m) => MonadError e (MaybeT m)
(MonadAsk r m) => MonadAsk r (MaybeT m)
(MonadReader r m) => MonadReader r (MaybeT m)
(MonadState s m) => MonadState s (MaybeT m)
(MonadTell w m) => MonadTell w (MaybeT m)
(MonadWriter w m) => MonadWriter w (MaybeT m)
(Monad m, Semigroup a) => Semigroup (MaybeT m a)
(Monad m, Monoid a) => Monoid (MaybeT m a)
```

#### `runMaybeT`

``` purescript
runMaybeT :: forall m a. MaybeT m a -> m (Maybe a)
```

Run a computation in the `MaybeT` monad.

#### `mapMaybeT`

``` purescript
mapMaybeT :: forall m1 m2 a b. (m1 (Maybe a) -> m2 (Maybe b)) -> MaybeT m1 a -> MaybeT m2 b
```

Change the result type of a `MaybeT` monad action.


### Re-exported from Control.Monad.Trans.Class:

#### `MonadTrans`

``` purescript
class MonadTrans t  where
  lift :: forall m a. Monad m => m a -> t m a
```

The `MonadTrans` type class represents _monad transformers_.

A monad transformer is a type constructor of kind `(* -> *) -> * -> *`, which
takes a `Monad` as its first argument, and returns another `Monad`.

This allows us to add additional effects to an existing monad. By iterating this
process, we create monad transformer _stacks_, which contain all of the effects
required for a particular computation.

The laws state that `lift` is a `Monad` morphism.

Laws:

- `lift (pure a) = pure a`
- `lift (do { x <- m ; y }) = do { x <- lift m ; lift y }`


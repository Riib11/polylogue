## Module Control.Monad.RWS.Trans

This module defines the reader-writer-state monad transformer, `RWST`.

#### `RWSResult`

``` purescript
data RWSResult state result writer
  = RWSResult state result writer
```

#### `RWST`

``` purescript
newtype RWST r w s m a
  = RWST (r -> s -> m (RWSResult s a w))
```

The reader-writer-state monad transformer, which combines the operations
of `ReaderT`, `WriterT` and `StateT` into a single monad transformer.

##### Instances
``` purescript
Newtype (RWST r w s m a) _
(Functor m) => Functor (RWST r w s m)
(Bind m, Monoid w) => Apply (RWST r w s m)
(Alt m) => Alt (RWST r w s m)
(Monoid w, Alternative m, Monad m) => Alternative (RWST r w s m)
(Bind m, Monoid w) => Bind (RWST r w s m)
(Monad m, Monoid w) => Applicative (RWST r w s m)
(Monad m, Monoid w) => Monad (RWST r w s m)
(Monoid w) => MonadTrans (RWST r w s)
Lazy (RWST r w s m a)
(Monoid w, MonadEffect m) => MonadEffect (RWST r w s m)
(Monad m, Monoid w) => MonadAsk r (RWST r w s m)
(Monad m, Monoid w) => MonadReader r (RWST r w s m)
(Monad m, Monoid w) => MonadState s (RWST r w s m)
(Monad m, Monoid w) => MonadTell w (RWST r w s m)
(Monad m, Monoid w) => MonadWriter w (RWST r w s m)
(MonadThrow e m, Monoid w) => MonadThrow e (RWST r w s m)
(MonadError e m, Monoid w) => MonadError e (RWST r w s m)
(MonadRec m, Monoid w) => MonadRec (RWST r w s m)
(Plus m) => Plus (RWST r w s m)
(Bind m, Monoid w, Semigroup a) => Semigroup (RWST r w s m a)
(Monad m, Monoid w, Monoid a) => Monoid (RWST r w s m a)
```

#### `runRWST`

``` purescript
runRWST :: forall r w s m a. RWST r w s m a -> r -> s -> m (RWSResult s a w)
```

Run a computation in the `RWST` monad.

#### `evalRWST`

``` purescript
evalRWST :: forall r w s m a. Monad m => RWST r w s m a -> r -> s -> m (Tuple a w)
```

Run a computation in the `RWST` monad, discarding the final state.

#### `execRWST`

``` purescript
execRWST :: forall r w s m a. Monad m => RWST r w s m a -> r -> s -> m (Tuple s w)
```

Run a computation in the `RWST` monad, discarding the result.

#### `mapRWST`

``` purescript
mapRWST :: forall r w1 w2 s m1 m2 a1 a2. (m1 (RWSResult s a1 w1) -> m2 (RWSResult s a2 w2)) -> RWST r w1 s m1 a1 -> RWST r w2 s m2 a2
```

Change the result and accumulator types in a `RWST` monad action.

#### `withRWST`

``` purescript
withRWST :: forall r1 r2 w s m a. (r2 -> s -> Tuple r1 s) -> RWST r1 w s m a -> RWST r2 w s m a
```

Change the context type in a `RWST` monad action.


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


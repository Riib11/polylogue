## Module Control.Monad.Reader.Trans

This module defines the reader monad transformer, `ReaderT`.

#### `ReaderT`

``` purescript
newtype ReaderT r m a
  = ReaderT (r -> m a)
```

The reader monad transformer.

This monad transformer extends the base monad transformer with a _global context_ of
type `r`.

The `MonadReader` type class describes the operations supported by this monad.

##### Instances
``` purescript
Newtype (ReaderT r m a) _
(Functor m) => Functor (ReaderT r m)
(Apply m) => Apply (ReaderT r m)
(Applicative m) => Applicative (ReaderT r m)
(Alt m) => Alt (ReaderT r m)
(Plus m) => Plus (ReaderT r m)
(Alternative m) => Alternative (ReaderT r m)
(Bind m) => Bind (ReaderT r m)
(Monad m) => Monad (ReaderT r m)
(Apply m, Semigroup a) => Semigroup (ReaderT s m a)
(Applicative m, Monoid a) => Monoid (ReaderT s m a)
(MonadPlus m) => MonadPlus (ReaderT r m)
MonadTrans (ReaderT r)
(MonadEffect m) => MonadEffect (ReaderT r m)
(MonadCont m) => MonadCont (ReaderT r m)
(MonadThrow e m) => MonadThrow e (ReaderT r m)
(MonadError e m) => MonadError e (ReaderT r m)
(Monad m) => MonadAsk r (ReaderT r m)
(Monad m) => MonadReader r (ReaderT r m)
(MonadState s m) => MonadState s (ReaderT r m)
(MonadTell w m) => MonadTell w (ReaderT r m)
(MonadWriter w m) => MonadWriter w (ReaderT r m)
(Distributive g) => Distributive (ReaderT e g)
(MonadRec m) => MonadRec (ReaderT r m)
```

#### `runReaderT`

``` purescript
runReaderT :: forall r m a. ReaderT r m a -> (r -> m a)
```

Run a computation in the `ReaderT` monad.

#### `withReaderT`

``` purescript
withReaderT :: forall r1 r2 m a. (r2 -> r1) -> ReaderT r1 m a -> ReaderT r2 m a
```

Change the type of the context in a `ReaderT` monad action.

#### `mapReaderT`

``` purescript
mapReaderT :: forall r m1 m2 a b. (m1 a -> m2 b) -> ReaderT r m1 a -> ReaderT r m2 b
```

Change the type of the result in a `ReaderT` monad action.


### Re-exported from Control.Monad.Reader.Class:

#### `MonadAsk`

``` purescript
class (Monad m) <= MonadAsk r m | m -> r where
  ask :: m r
```

The `MonadAsk` type class represents those monads which support a global
context that can be provided via the `ask` function.

An implementation is provided for `ReaderT`, and for other monad
transformers defined in this library.

Law:

- `do { ask ; ask } = ask`

##### Instances
``` purescript
MonadAsk r (Function r)
```

#### `MonadReader`

``` purescript
class (MonadAsk r m) <= MonadReader r m | m -> r where
  local :: forall a. (r -> r) -> m a -> m a
```

An extension of the `MonadAsk` class that introduces a function `local f x`
that allows the value of the local context to be modified for the duration
of the execution of action `x`.

An implementation is provided for `ReaderT`, and for other monad
transformers defined in this library.

Laws in addition to the `MonadAsk` law:

- `local f ask = f <$> ask`
- `local _ (pure a) = pure a`
- `local f (do { a <- x ; y }) = do { a <- local f x ; local f y }`

##### Instances
``` purescript
MonadReader r (Function r)
```

#### `asks`

``` purescript
asks :: forall r m a. MonadAsk r m => (r -> a) -> m a
```

Projects a value from the global context in a `MonadAsk`.

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


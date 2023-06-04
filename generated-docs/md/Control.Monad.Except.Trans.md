## Module Control.Monad.Except.Trans

This module defines the _exception monad transformer_ `ExceptT`.

#### `ExceptT`

``` purescript
newtype ExceptT e m a
  = ExceptT (m (Either e a))
```

A monad transformer which adds exceptions to other monads, in the same way
as `Except`. As before, `e` is the type of exceptions, and `a` is the type
of successful results. The new type parameter `m` is the inner monad that
computations run in.

##### Instances
``` purescript
Newtype (ExceptT e m a) _
(Functor m) => Functor (ExceptT e m)
(Monad m) => Apply (ExceptT e m)
(Monad m) => Applicative (ExceptT e m)
(Monad m) => Bind (ExceptT e m)
(Monad m) => Monad (ExceptT e m)
(MonadRec m) => MonadRec (ExceptT e m)
(Semigroup e, Monad m) => Alt (ExceptT e m)
(Monoid e, Monad m) => Plus (ExceptT e m)
(Monoid e, Monad m) => Alternative (ExceptT e m)
(Monoid e, Monad m) => MonadPlus (ExceptT e m)
MonadTrans (ExceptT e)
(MonadEffect m) => MonadEffect (ExceptT e m)
(MonadCont m) => MonadCont (ExceptT e m)
(Monad m) => MonadThrow e (ExceptT e m)
(Monad m) => MonadError e (ExceptT e m)
(MonadAsk r m) => MonadAsk r (ExceptT e m)
(MonadReader r m) => MonadReader r (ExceptT e m)
(MonadState s m) => MonadState s (ExceptT e m)
(MonadTell w m) => MonadTell w (ExceptT e m)
(MonadWriter w m) => MonadWriter w (ExceptT e m)
(Monad m, Semigroup a) => Semigroup (ExceptT e m a)
(Monad m, Monoid a) => Monoid (ExceptT e m a)
```

#### `runExceptT`

``` purescript
runExceptT :: forall e m a. ExceptT e m a -> m (Either e a)
```

The inverse of `ExceptT`. Run a computation in the `ExceptT` monad.

#### `withExceptT`

``` purescript
withExceptT :: forall e e' m a. Functor m => (e -> e') -> ExceptT e m a -> ExceptT e' m a
```

Transform any exceptions thrown by an `ExceptT` computation using the given function.

#### `mapExceptT`

``` purescript
mapExceptT :: forall e e' m n a b. (m (Either e a) -> n (Either e' b)) -> ExceptT e m a -> ExceptT e' n b
```

Transform the unwrapped computation using the given function.

#### `except`

``` purescript
except :: forall e m a. Applicative m => Either e a -> ExceptT e m a
```

Construct a computation in the `ExceptT` transformer from an `Either` value.


### Re-exported from Control.Monad.Error.Class:

#### `MonadError`

``` purescript
class (MonadThrow e m) <= MonadError e m | m -> e where
  catchError :: forall a. m a -> (e -> m a) -> m a
```

The `MonadError` type class represents those monads which support catching
errors.

- `catchError x f` calls the error handler `f` if an error is thrown during the
  evaluation of `x`.

An implementation is provided for `ExceptT`, and for other monad transformers
defined in this library.

Laws:

- Catch: `catchError (throwError e) f = f e`
- Pure: `catchError (pure a) f = pure a`


##### Instances
``` purescript
MonadError e (Either e)
MonadError Unit Maybe
MonadError Error Effect
```

#### `MonadThrow`

``` purescript
class (Monad m) <= MonadThrow e m | m -> e where
  throwError :: forall a. e -> m a
```

The `MonadThrow` type class represents those monads which support errors via
`throwError`, where `throwError e` halts, yielding the error `e`.

An implementation is provided for `ExceptT`, and for other monad transformers
defined in this library.

Laws:

- Left zero: `throwError e >>= f = throwError e`


##### Instances
``` purescript
MonadThrow e (Either e)
MonadThrow Unit Maybe
MonadThrow Error Effect
```

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


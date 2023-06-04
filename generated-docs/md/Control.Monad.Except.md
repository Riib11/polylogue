## Module Control.Monad.Except

#### `Except`

``` purescript
type Except e = ExceptT e Identity
```

A parametrizable exception monad; computations are either exceptions or
pure values. If an exception is thrown (see `throwError`), the computation
terminates with that value. Exceptions may also be caught with `catchError`,
allowing the computation to resume and exit successfully.

The type parameter `e` is the type of exceptions, and `a` is the type
of successful results.

A mechanism for trying many different computations until one succeeds is
provided via the `Alt` instance, specifically the `(<|>)` function.
The first computation to succeed is returned; if all fail, the exceptions
are combined using their `Semigroup` instance. The `Plus` instance goes
further and adds the possibility of a computation failing with an 'empty'
exception; naturally, this requires the stronger constraint of a `Monoid`
instance for the exception type.

#### `runExcept`

``` purescript
runExcept :: forall e a. Except e a -> Either e a
```

Run a computation in the `Except` monad. The inverse of `except`.

#### `mapExcept`

``` purescript
mapExcept :: forall e e' a b. (Either e a -> Either e' b) -> Except e a -> Except e' b
```

Transform the unwrapped computation using the given function.

#### `withExcept`

``` purescript
withExcept :: forall e e' a. (e -> e') -> Except e a -> Except e' a
```

Transform any exceptions thrown by an `Except` computation using the given function.


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

#### `throwError`

``` purescript
throwError :: forall e m a. MonadThrow e m => e -> m a
```

#### `catchJust`

``` purescript
catchJust :: forall e m a b. MonadError e m => (e -> Maybe b) -> m a -> (b -> m a) -> m a
```

This function allows you to provide a predicate for selecting the
exceptions that you're interested in, and handle only those exceptons.
If the inner computation throws an exception, and the predicate returns
Nothing, then the whole computation will still fail with that exception.

### Re-exported from Control.Monad.Except.Trans:

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

#### `withExceptT`

``` purescript
withExceptT :: forall e e' m a. Functor m => (e -> e') -> ExceptT e m a -> ExceptT e' m a
```

Transform any exceptions thrown by an `ExceptT` computation using the given function.

#### `runExceptT`

``` purescript
runExceptT :: forall e m a. ExceptT e m a -> m (Either e a)
```

The inverse of `ExceptT`. Run a computation in the `ExceptT` monad.

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


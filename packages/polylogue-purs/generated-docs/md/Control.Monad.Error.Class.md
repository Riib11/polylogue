## Module Control.Monad.Error.Class

This module defines the `MonadError` type class and its instances.

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

#### `catchJust`

``` purescript
catchJust :: forall e m a b. MonadError e m => (e -> Maybe b) -> m a -> (b -> m a) -> m a
```

This function allows you to provide a predicate for selecting the
exceptions that you're interested in, and handle only those exceptons.
If the inner computation throws an exception, and the predicate returns
Nothing, then the whole computation will still fail with that exception.

#### `try`

``` purescript
try :: forall e m a. MonadError e m => m a -> m (Either e a)
```

Return `Right` if the given action succeeds, `Left` if it throws.

#### `withResource`

``` purescript
withResource :: forall e m r a. MonadError e m => m r -> (r -> m Unit) -> (r -> m a) -> m a
```

Make sure that a resource is cleaned up in the event of an exception. The
release action is called regardless of whether the body action throws or
returns.

#### `liftMaybe`

``` purescript
liftMaybe :: forall m e a. MonadThrow e m => e -> Maybe a -> m a
```

Lift a `Maybe` value to a MonadThrow monad.

#### `liftEither`

``` purescript
liftEither :: forall m e a. MonadThrow e m => Either e a -> m a
```

Lift an `Either` value to a MonadThrow monad.



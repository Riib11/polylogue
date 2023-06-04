## Module Control.Monad.Cont

This module defines the `Cont`inuation monad.

#### `Cont`

``` purescript
type Cont r = ContT r Identity
```

The `Cont` monad is a synonym for the `ContT` monad transformer applied to
the `Identity` monad.

#### `cont`

``` purescript
cont :: forall a r. ((a -> r) -> r) -> Cont r a
```

Creates a computation in the `Cont` monad.

#### `runCont`

``` purescript
runCont :: forall r a. ContT r Identity a -> (a -> r) -> r
```

Runs a computation in the `Cont` monad.

#### `mapCont`

``` purescript
mapCont :: forall r a. (r -> r) -> Cont r a -> Cont r a
```

Transform the result of a continuation-passing function.

#### `withCont`

``` purescript
withCont :: forall a b r. ((b -> r) -> (a -> r)) -> Cont r a -> Cont r b
```

Transform the continuation passed into the continuation-passing function.


### Re-exported from Control.Monad.Cont.Class:

#### `MonadCont`

``` purescript
class (Monad m) <= MonadCont m  where
  callCC :: forall a. ((forall b. a -> m b) -> m a) -> m a
```

The `MonadCont` type class represents those monads which support the
`callCC`, or _call-with-current-continuation_ operation.

This action makes the current continuation available to the caller.

For example:

```purescript
-- setTimeout :: Number -> Effect Unit -> Effect Unit

delay :: Number -> ContT Unit Effect Unit
delay n = callCC \cont ->
  lift $ setTimeout n (runContT (cont unit) (\_ -> pure unit))
```
An implementation is provided for `ContT`, and for other monad transformers
defined in this library.

### Re-exported from Control.Monad.Cont.Trans:

#### `ContT`

``` purescript
newtype ContT r m a
  = ContT ((a -> m r) -> m r)
```

The CPS monad transformer.

This monad transformer extends the base monad with the operation `callCC`.

##### Instances
``` purescript
Newtype (ContT r m a) _
(Monad m) => MonadCont (ContT r m)
(Functor m) => Functor (ContT r m)
(Apply m) => Apply (ContT r m)
(Applicative m) => Applicative (ContT r m)
(Bind m) => Bind (ContT r m)
(Monad m) => Monad (ContT r m)
MonadTrans (ContT r)
(MonadEffect m) => MonadEffect (ContT r m)
(MonadAsk r1 m) => MonadAsk r1 (ContT r m)
(MonadReader r1 m) => MonadReader r1 (ContT r m)
(MonadState s m) => MonadState s (ContT r m)
(Apply m, Semigroup a) => Semigroup (ContT r m a)
(Applicative m, Monoid a) => Monoid (ContT r m a)
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

#### `withContT`

``` purescript
withContT :: forall r m a b. ((b -> m r) -> (a -> m r)) -> ContT r m a -> ContT r m b
```

Modify the continuation in a `ContT` monad action

#### `runContT`

``` purescript
runContT :: forall r m a. ContT r m a -> (a -> m r) -> m r
```

Run a computation in the `ContT` monad, by providing a continuation.

#### `mapContT`

``` purescript
mapContT :: forall r m a. (m r -> m r) -> ContT r m a -> ContT r m a
```

Modify the underlying action in a `ContT` monad action.


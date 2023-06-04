## Module Control.Monad.Fork.Class

#### `MonadFork`

``` purescript
class (Monad m, Functor f) <= MonadFork f m | m -> f where
  suspend :: forall a. m a -> m (f a)
  fork :: forall a. m a -> m (f a)
  join :: forall a. f a -> m a
```

Represents Monads which can be forked asynchronously.

Laws:

```purescript
-- Unjoined suspension is a no-op
suspend a1 *> suspend a2 = suspend a2

-- Suspend/join is identity
suspend >=> join = id

-- Fork/join is identity
fork >=> join = id

-- Join is idempotent
join t *> join t = join t
```

##### Instances
``` purescript
MonadFork Fiber Aff
(MonadFork f m) => MonadFork f (ReaderT r m)
```

#### `MonadKill`

``` purescript
class (MonadFork f m, MonadThrow e m) <= MonadKill e f m | m -> e f where
  kill :: forall a. e -> f a -> m Unit
```

Represents Monads which can be killed after being forked.

Laws:

```purescript
-- Killed suspension is an exception
suspend a >>= \f -> kill e f *> join f = throwError e

-- Suspend/kill is unit
suspend a >>= kill e = pure unit
```

##### Instances
``` purescript
MonadKill Error Fiber Aff
(MonadKill e f m) => MonadKill e f (ReaderT r m)
```

#### `BracketCondition`

``` purescript
data BracketCondition e a
  = Completed a
  | Failed e
  | Killed e
```

#### `MonadBracket`

``` purescript
class (MonadKill e f m, MonadError e m) <= MonadBracket e f m | m -> e f where
  bracket :: forall r a. m r -> (BracketCondition e a -> r -> m Unit) -> (r -> m a) -> m a
  uninterruptible :: forall a. m a -> m a
  never :: forall a. m a
```

Represents Monads which support cleanup in the presence of async
exceptions.

Laws:
```purescript
bracket a k \_ -> pure r
  = uninterruptible (a >>= k (Completed r))

-- Release failed
bracket a k \_ -> throwError e
  = uninterruptible (a >>= k (Failed e) *> throwError e)

-- Release killed
fork (bracket a k \_ -> never) >>= \f -> kill e f *> void (try (join f))
  = uninterruptible (a >>= k (Killed e))
```

##### Instances
``` purescript
MonadBracket Error Fiber Aff
(MonadBracket e f m) => MonadBracket e f (ReaderT r m)
```



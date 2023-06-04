## Module Control.Monad.State

This module defines the `State` monad.

#### `State`

``` purescript
type State s = StateT s Identity
```

The `State` monad is a synonym for the `StateT` monad transformer, applied
to the `Identity` monad.

#### `runState`

``` purescript
runState :: forall s a. State s a -> s -> Tuple a s
```

Run a computation in the `State` monad

#### `evalState`

``` purescript
evalState :: forall s a. State s a -> s -> a
```

Run a computation in the `State` monad, discarding the final state

#### `execState`

``` purescript
execState :: forall s a. State s a -> s -> s
```

Run a computation in the `State` monad, discarding the result

#### `mapState`

``` purescript
mapState :: forall s a b. (Tuple a s -> Tuple b s) -> State s a -> State s b
```

Change the type of the result in a `State` action

#### `withState`

``` purescript
withState :: forall s a. (s -> s) -> State s a -> State s a
```

Modify the state in a `State` action


### Re-exported from Control.Monad.State.Class:

#### `MonadState`

``` purescript
class (Monad m) <= MonadState s m | m -> s where
  state :: forall a. (s -> (Tuple a s)) -> m a
```

The `MonadState s` type class represents those monads which support a single piece of mutable
state of type `s`.

- `state f` updates the state using the function `f`.

An implementation is provided for `StateT`, and for other monad transformers
defined in this library.

Laws:

- `do { get ; get } = get`
- `do { put x ; put y } = put y`
- `do { put x ; get } = put x $> x`
- `do { s <- get ; put s } = pure unit`


#### `put`

``` purescript
put :: forall m s. MonadState s m => s -> m Unit
```

Set the state.

#### `modify_`

``` purescript
modify_ :: forall s m. MonadState s m => (s -> s) -> m Unit
```

#### `modify`

``` purescript
modify :: forall s m. MonadState s m => (s -> s) -> m s
```

Modify the state by applying a function to the current state. The returned
value is the new state value.

#### `gets`

``` purescript
gets :: forall s m a. MonadState s m => (s -> a) -> m a
```

Get a value which depends on the current state.

#### `get`

``` purescript
get :: forall m s. MonadState s m => m s
```

Get the current state.

### Re-exported from Control.Monad.State.Trans:

#### `StateT`

``` purescript
newtype StateT s m a
  = StateT (s -> m (Tuple a s))
```

The state monad transformer.

This monad transformer extends the base monad with the operations `get`
and `put` which can be used to model a single piece of mutable state.

The `MonadState` type class describes the operations supported by this monad.

##### Instances
``` purescript
Newtype (StateT s m a) _
(Functor m) => Functor (StateT s m)
(Monad m) => Apply (StateT s m)
(Monad m) => Applicative (StateT s m)
(Monad m, Alt m) => Alt (StateT s m)
(Monad m, Plus m) => Plus (StateT s m)
(Monad m, Alternative m) => Alternative (StateT s m)
(Monad m) => Bind (StateT s m)
(Monad m) => Monad (StateT s m)
(MonadRec m) => MonadRec (StateT s m)
(MonadPlus m) => MonadPlus (StateT s m)
MonadTrans (StateT s)
Lazy (StateT s m a)
(MonadEffect m) => MonadEffect (StateT s m)
(MonadCont m) => MonadCont (StateT s m)
(MonadThrow e m) => MonadThrow e (StateT s m)
(MonadError e m) => MonadError e (StateT s m)
(MonadAsk r m) => MonadAsk r (StateT s m)
(MonadReader r m) => MonadReader r (StateT s m)
(Monad m) => MonadState s (StateT s m)
(MonadTell w m) => MonadTell w (StateT s m)
(MonadWriter w m) => MonadWriter w (StateT s m)
(Monad m, Semigroup a) => Semigroup (StateT s m a)
(Monad m, Monoid a) => Monoid (StateT s m a)
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

#### `withStateT`

``` purescript
withStateT :: forall s m a. (s -> s) -> StateT s m a -> StateT s m a
```

Modify the final state in a `StateT` monad action.

#### `runStateT`

``` purescript
runStateT :: forall s m a. StateT s m a -> s -> m (Tuple a s)
```

Run a computation in the `StateT` monad.

#### `mapStateT`

``` purescript
mapStateT :: forall s m1 m2 a b. (m1 (Tuple a s) -> m2 (Tuple b s)) -> StateT s m1 a -> StateT s m2 b
```

Change the result type in a `StateT` monad action.

#### `execStateT`

``` purescript
execStateT :: forall s m a. Functor m => StateT s m a -> s -> m s
```

Run a computation in the `StateT` monad discarding the result.

#### `evalStateT`

``` purescript
evalStateT :: forall s m a. Functor m => StateT s m a -> s -> m a
```

Run a computation in the `StateT` monad, discarding the final state.


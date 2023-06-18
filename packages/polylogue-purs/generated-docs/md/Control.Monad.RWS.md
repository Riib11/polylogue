## Module Control.Monad.RWS

This module defines the `RWS` monad.

#### `RWS`

``` purescript
type RWS r w s = RWST r w s Identity
```

The `RWS` monad is a synonym for the `RWST` monad transformer, applied
to the `Identity` monad.

#### `rws`

``` purescript
rws :: forall r w s a. (r -> s -> RWSResult s a w) -> RWS r w s a
```

Create an action in the `RWS` monad from a function which uses the
global context and state explicitly.

#### `runRWS`

``` purescript
runRWS :: forall r w s a. RWS r w s a -> r -> s -> RWSResult s a w
```

Run a computation in the `RWS` monad.

#### `evalRWS`

``` purescript
evalRWS :: forall r w s a. RWS r w s a -> r -> s -> Tuple a w
```

Run a computation in the `RWS` monad, discarding the final state

#### `execRWS`

``` purescript
execRWS :: forall r w s a. RWS r w s a -> r -> s -> Tuple s w
```

Run a computation in the `RWS` monad, discarding the result

#### `mapRWS`

``` purescript
mapRWS :: forall r w1 w2 s a1 a2. (RWSResult s a1 w1 -> RWSResult s a2 w2) -> RWS r w1 s a1 -> RWS r w2 s a2
```

Change the types of the result and accumulator in a `RWS` action

#### `withRWS`

``` purescript
withRWS :: forall r1 r2 w s a. (r2 -> s -> Tuple r1 s) -> RWS r1 w s a -> RWS r2 w s a
```

Change the type of the context in a `RWS` action


### Re-exported from Control.Monad.RWS.Trans:

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

#### `RWSResult`

``` purescript
data RWSResult state result writer
  = RWSResult state result writer
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

#### `withRWST`

``` purescript
withRWST :: forall r1 r2 w s m a. (r2 -> s -> Tuple r1 s) -> RWST r1 w s m a -> RWST r2 w s m a
```

Change the context type in a `RWST` monad action.

#### `runRWST`

``` purescript
runRWST :: forall r w s m a. RWST r w s m a -> r -> s -> m (RWSResult s a w)
```

Run a computation in the `RWST` monad.

#### `mapRWST`

``` purescript
mapRWST :: forall r w1 w2 s m1 m2 a1 a2. (m1 (RWSResult s a1 w1) -> m2 (RWSResult s a2 w2)) -> RWST r w1 s m1 a1 -> RWST r w2 s m2 a2
```

Change the result and accumulator types in a `RWST` monad action.

#### `execRWST`

``` purescript
execRWST :: forall r w s m a. Monad m => RWST r w s m a -> r -> s -> m (Tuple s w)
```

Run a computation in the `RWST` monad, discarding the result.

#### `evalRWST`

``` purescript
evalRWST :: forall r w s m a. Monad m => RWST r w s m a -> r -> s -> m (Tuple a w)
```

Run a computation in the `RWST` monad, discarding the final state.

### Re-exported from Control.Monad.Reader.Class:

#### `ask`

``` purescript
ask :: forall r m. MonadAsk r m => m r
```

#### `local`

``` purescript
local :: forall r m a. MonadReader r m => (r -> r) -> m a -> m a
```

#### `asks`

``` purescript
asks :: forall r m a. MonadAsk r m => (r -> a) -> m a
```

Projects a value from the global context in a `MonadAsk`.

### Re-exported from Control.Monad.State.Class:

#### `state`

``` purescript
state :: forall s m a. MonadState s m => (s -> (Tuple a s)) -> m a
```

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

### Re-exported from Control.Monad.Writer.Class:

#### `listen`

``` purescript
listen :: forall w m a. MonadWriter w m => m a -> m (Tuple a w)
```

#### `pass`

``` purescript
pass :: forall w m a. MonadWriter w m => m (Tuple a (w -> w)) -> m a
```

#### `tell`

``` purescript
tell :: forall w m. MonadTell w m => w -> m Unit
```

#### `listens`

``` purescript
listens :: forall w m a b. MonadWriter w m => (w -> b) -> m a -> m (Tuple a b)
```

Projects a value from modifications made to the accumulator during an
action.

#### `censor`

``` purescript
censor :: forall w m a. MonadWriter w m => (w -> w) -> m a -> m a
```

Modify the final accumulator value by applying a function.


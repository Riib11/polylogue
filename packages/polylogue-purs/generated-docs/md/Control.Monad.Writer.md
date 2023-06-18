## Module Control.Monad.Writer

This module defines the `Writer` monad.

#### `Writer`

``` purescript
type Writer w = WriterT w Identity
```

The `Writer` monad is a synonym for the `WriterT` monad transformer, applied
to the `Identity` monad.

#### `writer`

``` purescript
writer :: forall w a. Tuple a w -> Writer w a
```

Creates a `Writer` from a result and output pair.

#### `runWriter`

``` purescript
runWriter :: forall w a. Writer w a -> Tuple a w
```

Run a computation in the `Writer` monad

#### `execWriter`

``` purescript
execWriter :: forall w a. Writer w a -> w
```

Run a computation in the `Writer` monad, discarding the result

#### `mapWriter`

``` purescript
mapWriter :: forall w1 w2 a b. (Tuple a w1 -> Tuple b w2) -> Writer w1 a -> Writer w2 b
```

Change the result and accumulator types in a `Writer` monad action


### Re-exported from Control.Monad.Writer.Class:

#### `MonadTell`

``` purescript
class (Semigroup w, Monad m) <= MonadTell w m | m -> w where
  tell :: w -> m Unit
```

The `MonadTell w` type class represents those monads which support a
monoidal accumulator of type `w`, where `tell` appends a value to the
accumulator.

An implementation is provided for `WriterT`, and for other monad
transformers defined in this library.

Law:

- `do { tell x ; tell y } = tell (x <> y)`

#### `MonadWriter`

``` purescript
class (Monoid w, MonadTell w m) <= MonadWriter w m | m -> w where
  listen :: forall a. m a -> m (Tuple a w)
  pass :: forall a. m (Tuple a (w -> w)) -> m a
```

An extension of the `MonadTell` class that introduces some operations on
the accumulator:

- `listen` modifies the result to include the changes to the accumulator.
- `pass` applies the returned function to the accumulator.

An implementation is provided for `WriterT`, and for other monad
transformers defined in this library.

Laws in addition to the `MonadTell` law:

- `do { tell x ; tell y } = tell (x <> y)`
- `listen (pure a) = pure (Tuple a mempty)`
- `listen (writer a x) = tell x $> Tuple a x`

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

### Re-exported from Control.Monad.Writer.Trans:

#### `WriterT`

``` purescript
newtype WriterT w m a
  = WriterT (m (Tuple a w))
```

The writer monad transformer.

This monad transformer extends the base monad with a monoidal accumulator of
type `w`.

The `MonadWriter` type class describes the operations supported by this monad.

##### Instances
``` purescript
Newtype (WriterT w m a) _
(Functor m) => Functor (WriterT w m)
(Semigroup w, Apply m) => Apply (WriterT w m)
(Monoid w, Applicative m) => Applicative (WriterT w m)
(Alt m) => Alt (WriterT w m)
(Plus m) => Plus (WriterT w m)
(Monoid w, Alternative m) => Alternative (WriterT w m)
(Semigroup w, Bind m) => Bind (WriterT w m)
(Monoid w, Monad m) => Monad (WriterT w m)
(Monoid w, MonadRec m) => MonadRec (WriterT w m)
(Monoid w, MonadPlus m) => MonadPlus (WriterT w m)
(Monoid w) => MonadTrans (WriterT w)
(Monoid w, MonadEffect m) => MonadEffect (WriterT w m)
(Monoid w, MonadCont m) => MonadCont (WriterT w m)
(Monoid w, MonadThrow e m) => MonadThrow e (WriterT w m)
(Monoid w, MonadError e m) => MonadError e (WriterT w m)
(Monoid w, MonadAsk r m) => MonadAsk r (WriterT w m)
(Monoid w, MonadReader r m) => MonadReader r (WriterT w m)
(Monoid w, MonadState s m) => MonadState s (WriterT w m)
(Monoid w, Monad m) => MonadTell w (WriterT w m)
(Monoid w, Monad m) => MonadWriter w (WriterT w m)
(Apply m, Semigroup w, Semigroup a) => Semigroup (WriterT w m a)
(Applicative m, Monoid w, Monoid a) => Monoid (WriterT w m a)
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

#### `runWriterT`

``` purescript
runWriterT :: forall w m a. WriterT w m a -> m (Tuple a w)
```

Run a computation in the `WriterT` monad.

#### `mapWriterT`

``` purescript
mapWriterT :: forall w1 w2 m1 m2 a b. (m1 (Tuple a w1) -> m2 (Tuple b w2)) -> WriterT w1 m1 a -> WriterT w2 m2 b
```

Change the accumulator and base monad types in a `WriterT` monad action.

#### `execWriterT`

``` purescript
execWriterT :: forall w m a. Functor m => WriterT w m a -> m w
```

Run a computation in the `WriterT` monad, discarding the result.


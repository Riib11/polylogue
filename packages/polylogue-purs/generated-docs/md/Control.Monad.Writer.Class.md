## Module Control.Monad.Writer.Class

This module defines the `MonadWriter` type class and its instances.

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



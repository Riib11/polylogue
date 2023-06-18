## Module Control.Parallel.Class

#### `Parallel`

``` purescript
class (Monad m, Applicative f) <= Parallel f m | m -> f, f -> m where
  parallel :: m ~> f
  sequential :: f ~> m
```

The `Parallel` class abstracts over monads which support
parallel composition via some related `Applicative`.

##### Instances
``` purescript
(Parallel f m) => Parallel (Compose f (Either e)) (ExceptT e m)
(Parallel f m) => Parallel (ReaderT e f) (ReaderT e m)
(Monoid w, Parallel f m) => Parallel (WriterT w f) (WriterT w m)
(Parallel f m) => Parallel (Compose f Maybe) (MaybeT m)
(Parallel f m) => Parallel (Star f a) (Star m a)
(Parallel f m) => Parallel (Costar f a) (Costar m a)
(MonadEffect m) => Parallel (ParCont m) (ContT Unit m)
```

#### `ParCont`

``` purescript
newtype ParCont m a
  = ParCont (ContT Unit m a)
```

The `ParCont` type constructor provides an `Applicative` instance
based on `ContT Unit m`, which waits for multiple continuations to be
resumed simultaneously.

ParCont sections of code can be embedded in sequential code by using
the `parallel` and `sequential` functions:

```purescript
loadModel :: ContT Unit (Eff (ajax :: AJAX)) Model
loadModel = do
  token <- authenticate
  sequential $
    Model <$> parallel (get "/products/popular/" token)
          <*> parallel (get "/categories/all" token)
```

##### Instances
``` purescript
Newtype (ParCont m a) _
(MonadEffect m) => Functor (ParCont m)
(MonadEffect m) => Apply (ParCont m)
(MonadEffect m) => Applicative (ParCont m)
(MonadEffect m) => Alt (ParCont m)
(MonadEffect m) => Plus (ParCont m)
(MonadEffect m) => Alternative (ParCont m)
(MonadEffect m) => Parallel (ParCont m) (ContT Unit m)
```



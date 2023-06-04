## Module Control.Monad.Free

#### `Free`

``` purescript
data Free f a
```

The free monad for a type constructor `f`.

Implemented in the spirit of [Reflection without Remorse](http://okmij.org/ftp/Haskell/zseq.pdf),
the free monad is represented using a sequential data structure in
order to overcome the quadratic complexity of left-associated binds
and traversal through the free monad structure.

##### Instances
``` purescript
(Functor f, Eq1 f, Eq a) => Eq (Free f a)
(Functor f, Eq1 f) => Eq1 (Free f)
(Functor f, Ord1 f, Ord a) => Ord (Free f a)
(Functor f, Ord1 f) => Ord1 (Free f)
Functor (Free f)
Bind (Free f)
Applicative (Free f)
Apply (Free f)
Monad (Free f)
MonadTrans Free
MonadRec (Free f)
(Functor f, Foldable f) => Foldable (Free f)
(Traversable f) => Traversable (Free f)
(Semigroup a) => Semigroup (Free f a)
(Monoid a) => Monoid (Free f a)
```

#### `suspendF`

``` purescript
suspendF :: forall f. Applicative f => (Free f) ~> (Free f)
```

Suspend a value given the applicative functor `f` into the free monad.

#### `wrap`

``` purescript
wrap :: forall f a. f (Free f a) -> Free f a
```

Add a layer.

#### `liftF`

``` purescript
liftF :: forall f. f ~> (Free f)
```

Lift an impure value described by the generating type constructor `f` into
the free monad.

#### `hoistFree`

``` purescript
hoistFree :: forall f g. (f ~> g) -> (Free f) ~> (Free g)
```

Use a natural transformation to change the generating type constructor of a
free monad.

#### `foldFree`

``` purescript
foldFree :: forall f m. MonadRec m => (f ~> m) -> (Free f) ~> m
```

Run a free monad with a natural transformation from the type constructor `f`
to the tail-recursive monad `m`. See the `MonadRec` type class for more
details.

#### `substFree`

``` purescript
substFree :: forall f g. (f ~> (Free g)) -> (Free f) ~> (Free g)
```

Like `foldFree`, but for folding into some other Free monad without the
overhead that `MonadRec` incurs.

#### `runFree`

``` purescript
runFree :: forall f a. Functor f => (f (Free f a) -> Free f a) -> Free f a -> a
```

Run a free monad with a function that unwraps a single layer of the functor
`f` at a time.

#### `runFreeM`

``` purescript
runFreeM :: forall f m a. Functor f => MonadRec m => (f (Free f a) -> m (Free f a)) -> Free f a -> m a
```

Run a free monad with a function mapping a functor `f` to a tail-recursive
monad `m`. See the `MonadRec` type class for more details.

#### `resume`

``` purescript
resume :: forall f a. Functor f => Free f a -> Either (f (Free f a)) a
```

Unwraps a single layer of the functor `f`.

#### `resume'`

``` purescript
resume' :: forall f a r. (forall b. f b -> (b -> Free f a) -> r) -> (a -> r) -> Free f a -> r
```

Unwraps a single layer of `f`, providing the continuation.



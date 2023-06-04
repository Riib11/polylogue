## Module Control.Monad.List.Trans

This module defines the list monad transformer, `ListT`.

#### `ListT`

``` purescript
newtype ListT f a
  = ListT (f (Step a (ListT f a)))
```

The list monad transformer.

This monad transformer extends the base monad with _non-determinism_.
That is, the transformed monad supports the same effects as the base monad
but with multiple return values.

##### Instances
``` purescript
Newtype (ListT f a) _
(Applicative f) => Semigroup (ListT f a)
(Applicative f) => Monoid (ListT f a)
(Functor f) => Functor (ListT f)
(Monad f) => Unfoldable (ListT f)
(Monad f) => Unfoldable1 (ListT f)
(Monad f) => Apply (ListT f)
(Monad f) => Applicative (ListT f)
(Monad f) => Bind (ListT f)
(Monad f) => Monad (ListT f)
MonadTrans ListT
(Applicative f) => Alt (ListT f)
(Monad f) => Plus (ListT f)
(Monad f) => Alternative (ListT f)
(Monad f) => MonadPlus (ListT f)
(MonadEffect m) => MonadEffect (ListT m)
```

#### `Step`

``` purescript
data Step a s
  = Yield a (Lazy s)
  | Skip (Lazy s)
  | Done
```

The result of a single step in a `ListT` computation. Either:

- Computation has finished (`Done`), or
- A result has been returned, along with the next part of the computation (`Yield`).

The `Skip` constructor allows us to avoid traversing lists during certain operations.

#### `catMaybes`

``` purescript
catMaybes :: forall f a. Functor f => ListT f (Maybe a) -> ListT f a
```

Remove elements from a list which do not contain a value.

#### `cons`

``` purescript
cons :: forall f a. Applicative f => Lazy a -> Lazy (ListT f a) -> ListT f a
```

Attach an element to the front of a list.

#### `drop`

``` purescript
drop :: forall f a. Applicative f => Int -> ListT f a -> ListT f a
```

Drop a number of elements from the front of a list.

#### `dropWhile`

``` purescript
dropWhile :: forall f a. Applicative f => (a -> Boolean) -> ListT f a -> ListT f a
```

Drop elements from the front of a list while a predicate holds.

#### `filter`

``` purescript
filter :: forall f a. Functor f => (a -> Boolean) -> ListT f a -> ListT f a
```

Remove elements from a list for which a predicate fails to hold.

#### `foldl`

``` purescript
foldl :: forall f a b. Monad f => (b -> a -> b) -> b -> ListT f a -> f b
```

Fold a list from the left, accumulating the result using the specified function.

#### `foldlRec`

``` purescript
foldlRec :: forall f a b. MonadRec f => (b -> a -> b) -> b -> ListT f a -> f b
```

Fold a list from the left, accumulating the result using the specified function.
Uses tail call optimization.

#### `foldl'`

``` purescript
foldl' :: forall f a b. Monad f => (b -> a -> f b) -> b -> ListT f a -> f b
```

Fold a list from the left, accumulating the result (effectfully) using the specified function.

#### `foldlRec'`

``` purescript
foldlRec' :: forall f a b. MonadRec f => (b -> a -> f b) -> b -> ListT f a -> f b
```

Fold a list from the left, accumulating the result (effectfully) using the specified function.
Uses tail call optimization.

#### `fromEffect`

``` purescript
fromEffect :: forall f a. Applicative f => f a -> ListT f a
```

Lift a computation from the base functor.

#### `head`

``` purescript
head :: forall f a. Monad f => ListT f a -> f (Maybe a)
```

Extract the first element of a list.

#### `iterate`

``` purescript
iterate :: forall f a. Monad f => (a -> a) -> a -> ListT f a
```

Generate an infinite list by iterating a function.

#### `mapMaybe`

``` purescript
mapMaybe :: forall f a b. Functor f => (a -> Maybe b) -> ListT f a -> ListT f b
```

Apply a function to the elements of a list, keeping only those return values which contain a result.

#### `nil`

``` purescript
nil :: forall f a. Applicative f => ListT f a
```

The empty list.

#### `prepend`

``` purescript
prepend :: forall f a. Applicative f => a -> ListT f a -> ListT f a
```

Prepend an element to a list.

#### `prepend'`

``` purescript
prepend' :: forall f a. Applicative f => a -> Lazy (ListT f a) -> ListT f a
```

Prepend an element to a lazily-evaluated list.

#### `repeat`

``` purescript
repeat :: forall f a. Monad f => a -> ListT f a
```

Generate an infinite list by repeating a value.

#### `runListT`

``` purescript
runListT :: forall f a. Monad f => ListT f a -> f Unit
```

Drain a `ListT`, running it to completion and discarding all values.

#### `runListTRec`

``` purescript
runListTRec :: forall f a. MonadRec f => ListT f a -> f Unit
```

Drain a `ListT`, running it to completion and discarding all values.
Stack safe: Uses tail call optimization.

#### `scanl`

``` purescript
scanl :: forall f a b. Monad f => (b -> a -> b) -> b -> ListT f a -> ListT f b
```

Fold a list from the left, accumulating the list of results using the specified function.

#### `singleton`

``` purescript
singleton :: forall f a. Applicative f => a -> ListT f a
```

Create a list with one element.

#### `tail`

``` purescript
tail :: forall f a. Monad f => ListT f a -> f (Maybe (ListT f a))
```

Extract all but the first element of a list.

#### `take`

``` purescript
take :: forall f a. Applicative f => Int -> ListT f a -> ListT f a
```

Take a number of elements from the front of a list.

#### `takeWhile`

``` purescript
takeWhile :: forall f a. Applicative f => (a -> Boolean) -> ListT f a -> ListT f a
```

Take elements from the front of a list while a predicate holds.

#### `uncons`

``` purescript
uncons :: forall f a. Monad f => ListT f a -> f (Maybe (Tuple a (ListT f a)))
```

Perform the first step of a computation in the `ListT` monad.

#### `unfold`

``` purescript
unfold :: forall f a z. Monad f => (z -> f (Maybe (Tuple z a))) -> z -> ListT f a
```

Unfold a list using an effectful generator function.

#### `wrapEffect`

``` purescript
wrapEffect :: forall f a. Functor f => f (ListT f a) -> ListT f a
```

Lift a computation from the base monad.

#### `wrapLazy`

``` purescript
wrapLazy :: forall f a. Applicative f => Lazy (ListT f a) -> ListT f a
```

Defer evaluation of a list.

#### `zipWith`

``` purescript
zipWith :: forall f a b c. Monad f => (a -> b -> c) -> ListT f a -> ListT f b -> ListT f c
```

Zip the elements of two lists, combining elements at the same position from each list.

#### `zipWith'`

``` purescript
zipWith' :: forall f a b c. Monad f => (a -> b -> f c) -> ListT f a -> ListT f b -> ListT f c
```

Zip the elements of two lists, combining elements at the same position from each list.


### Re-exported from Control.Monad.Trans.Class:

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


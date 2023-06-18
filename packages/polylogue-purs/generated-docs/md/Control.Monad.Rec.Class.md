## Module Control.Monad.Rec.Class

#### `Step`

``` purescript
data Step a b
  = Loop a
  | Done b
```

The result of a computation: either `Loop` containing the updated
accumulator, or `Done` containing the final result of the computation.

##### Instances
``` purescript
Functor (Step a)
Bifunctor Step
```

#### `MonadRec`

``` purescript
class (Monad m) <= MonadRec m  where
  tailRecM :: forall a b. (a -> m (Step a b)) -> a -> m b
```

This type class captures those monads which support tail recursion in
constant stack space.

The `tailRecM` function takes a step function, and applies that step
function recursively until a pure value of type `b` is found.

Instances are provided for standard monad transformers.

For example:

```purescript
loopWriter :: Int -> WriterT (Additive Int) Effect Unit
loopWriter n = tailRecM go n
  where
  go 0 = do
    traceM "Done!"
    pure (Done unit)
  go i = do
    tell $ Additive i
    pure (Loop (i - 1))
```

##### Instances
``` purescript
MonadRec Identity
MonadRec Effect
MonadRec (Function e)
MonadRec (Either e)
MonadRec Maybe
```

#### `tailRec`

``` purescript
tailRec :: forall a b. (a -> Step a b) -> a -> b
```

Create a pure tail-recursive function of one argument

For example:

```purescript
pow :: Int -> Int -> Int
pow n p = tailRec go { accum: 1, power: p }
  where
  go :: _ -> Step _ Int
  go { accum: acc, power: 0 } = Done acc
  go { accum: acc, power: p } = Loop { accum: acc * n, power: p - 1 }
```

#### `tailRec2`

``` purescript
tailRec2 :: forall a b c. (a -> b -> Step { a :: a, b :: b } c) -> a -> b -> c
```

Create a pure tail-recursive function of two arguments

The `loop2` helper function provides a curried alternative to the `Loop`
constructor for this function.

#### `tailRec3`

``` purescript
tailRec3 :: forall a b c d. (a -> b -> c -> Step { a :: a, b :: b, c :: c } d) -> a -> b -> c -> d
```

Create a pure tail-recursive function of three arguments

The `loop3` helper function provides a curried alternative to the `Loop`
constructor for this function.

#### `tailRecM2`

``` purescript
tailRecM2 :: forall m a b c. MonadRec m => (a -> b -> m (Step { a :: a, b :: b } c)) -> a -> b -> m c
```

Create a tail-recursive function of two arguments which uses constant stack space.

The `loop2` helper function provides a curried alternative to the `Loop`
constructor for this function.

#### `tailRecM3`

``` purescript
tailRecM3 :: forall m a b c d. MonadRec m => (a -> b -> c -> m (Step { a :: a, b :: b, c :: c } d)) -> a -> b -> c -> m d
```

Create a tail-recursive function of three arguments which uses constant stack space.

The `loop3` helper function provides a curried alternative to the `Loop`
constructor for this function.

#### `forever`

``` purescript
forever :: forall m a b. MonadRec m => m a -> m b
```

`forever` runs an action indefinitely, using the `MonadRec` instance to
ensure constant stack usage.

For example:

```purescript
main = forever $ trace "Hello, World!"
```

#### `whileJust`

``` purescript
whileJust :: forall a m. Monoid a => MonadRec m => m (Maybe a) -> m a
```

While supplied computation evaluates to `Just _`, it will be
executed repeatedly and results will be combined using monoid instance.

#### `untilJust`

``` purescript
untilJust :: forall a m. MonadRec m => m (Maybe a) -> m a
```

Supplied computation will be executed repeatedly until it evaluates
to `Just value` and then that `value` will be returned.

#### `loop2`

``` purescript
loop2 :: forall a b c. a -> b -> Step { a :: a, b :: b } c
```

A curried version of the `Loop` constructor, provided as a convenience for
use with `tailRec2` and `tailRecM2`.

#### `loop3`

``` purescript
loop3 :: forall a b c d. a -> b -> c -> Step { a :: a, b :: b, c :: c } d
```

A curried version of the `Loop` constructor, provided as a convenience for
use with `tailRec3` and `tailRecM3`.



## Module Control.Comonad.Traced

This module defines the `Traced` comonad.

#### `Traced`

``` purescript
type Traced m = TracedT m Identity
```

The `Traced` comonad is a synonym for the `TracedT` comonad transformer, applied
to the `Identity` monad.

#### `runTraced`

``` purescript
runTraced :: forall m a. Traced m a -> m -> a
```

Unwrap a value in the `Traced` comonad.

#### `traced`

``` purescript
traced :: forall m a. (m -> a) -> Traced m a
```

Create a value in context in the `Traced` comonad.


### Re-exported from Control.Comonad.Traced.Class:

#### `ComonadTraced`

``` purescript
class (Comonad w) <= ComonadTraced t w | w -> t where
  track :: forall a. t -> w a -> a
```

The `ComonadTraced` type class represents those monads which support relative (monoidal)
position information via `track`.

- `track` extracts a value at the specified relative position.

An implementation is provided for `TracedT`.

Laws:

- `track mempty = extract`
- `(track s =<= track t) x = track (s <> t) x`

For example:

```purescript
blur :: forall w. (ComonadTraced (Additive Number) w) -> w Number -> w Number
blur = extend \r -> (track (Additive (-1)) r + track (Additive 1) r) / 2
```

##### Instances
``` purescript
(Comonad w, Monoid t) => ComonadTraced t (TracedT t w)
```

#### `tracks`

``` purescript
tracks :: forall w a t. ComonadTraced t w => (a -> t) -> w a -> a
```

Extracts a value at a relative position which depends on the current value.

#### `listens`

``` purescript
listens :: forall w a t b. Functor w => (t -> b) -> TracedT t w a -> TracedT t w (Tuple a b)
```

Get a value which depends on the current position.

#### `listen`

``` purescript
listen :: forall w a t. Functor w => TracedT t w a -> TracedT t w (Tuple a t)
```

Get the current position.

#### `censor`

``` purescript
censor :: forall w a t. Functor w => (t -> t) -> TracedT t w a -> TracedT t w a
```

Apply a function to the current position.

### Re-exported from Control.Comonad.Traced.Trans:

#### `TracedT`

``` purescript
newtype TracedT t w a
  = TracedT (w (t -> a))
```

The cowriter comonad transformer.

This comonad transformer extends the context of a value in the base comonad so that the value
depends on a monoidal position of type `t`.

The `ComonadTraced` type class describes the operations supported by this comonad.

##### Instances
``` purescript
Newtype (TracedT t w a) _
(Functor w) => Functor (TracedT t w)
(Extend w, Semigroup t) => Extend (TracedT t w)
(Comonad w, Monoid t) => Comonad (TracedT t w)
(Monoid t) => ComonadTrans (TracedT t)
```

#### `runTracedT`

``` purescript
runTracedT :: forall w a t. TracedT t w a -> w (t -> a)
```

Unwrap a value in the `TracedT` comonad.


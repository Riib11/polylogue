## Module Control.Comonad.Env

This module defines the `Env` comonad.

#### `Env`

``` purescript
type Env e = EnvT e Identity
```

The `Env` comonad is a synonym for the `EnvT` comonad transformer, applied
to the `Identity` monad.

#### `runEnv`

``` purescript
runEnv :: forall e a. Env e a -> Tuple e a
```

Unwrap a value in the `Env` comonad.

#### `withEnv`

``` purescript
withEnv :: forall e1 e2 a. (e1 -> e2) -> Env e1 a -> Env e2 a
```

Change the environment type in an `Env` computation.

#### `mapEnv`

``` purescript
mapEnv :: forall e a b. (a -> b) -> Env e a -> Env e b
```

Change the data type in an `Env` computation.

#### `env`

``` purescript
env :: forall e a. e -> a -> Env e a
```

Create a value in context in the `Env` comonad.


### Re-exported from Control.Comonad.Env.Class:

#### `ComonadEnv`

``` purescript
class (ComonadAsk e w) <= ComonadEnv e w | w -> e where
  local :: forall a. (e -> e) -> w a -> w a
```

The `ComonadEnv` type class extends `ComonadAsk` with a function
`local f x` that allows the value of the local context to be modified for
the duration of the execution of action `x`.

An implementation is provided for `EnvT`.

Laws:

- `ask (local f x) = f (ask x)`
- `extract (local _ x) = extract a`
- `extend g (local f x) = extend (g <<< local f) x`

##### Instances
``` purescript
ComonadEnv e (Tuple e)
(Comonad w) => ComonadEnv e (EnvT e w)
```

#### `ask`

``` purescript
ask :: forall e w a. ComonadAsk e w => w a -> e
```

#### `asks`

``` purescript
asks :: forall e1 e2 w a. ComonadAsk e1 w => (e1 -> e2) -> w a -> e2
```

Get a value which depends on the environment.

### Re-exported from Control.Comonad.Env.Trans:

#### `EnvT`

``` purescript
newtype EnvT e w a
  = EnvT (Tuple e (w a))
```

The environment comonad transformer.

This comonad transformer extends the context of a value in the base comonad with a _global environment_ of
type `e`.

The `ComonadEnv` type class describes the operations supported by this comonad.

##### Instances
``` purescript
Newtype (EnvT e w a) _
(Functor w) => Functor (EnvT e w)
(Extend w) => Extend (EnvT e w)
(Comonad w) => Comonad (EnvT e w)
ComonadTrans (EnvT e)
(Foldable f) => Foldable (EnvT e f)
(Traversable f) => Traversable (EnvT e f)
(FunctorWithIndex i w) => FunctorWithIndex i (EnvT e w)
(FoldableWithIndex i w) => FoldableWithIndex i (EnvT e w)
(TraversableWithIndex i w) => TraversableWithIndex i (EnvT e w)
```

#### `withEnvT`

``` purescript
withEnvT :: forall e1 e2 w a. (e1 -> e2) -> EnvT e1 w a -> EnvT e2 w a
```

Change the environment type in an `EnvT` context.

#### `runEnvT`

``` purescript
runEnvT :: forall e w a. EnvT e w a -> Tuple e (w a)
```

Unwrap a value in the `EnvT` comonad.

#### `mapEnvT`

``` purescript
mapEnvT :: forall e w1 w2 a b. (w1 a -> w2 b) -> EnvT e w1 a -> EnvT e w2 b
```

Change the underlying comonad and data type in an `EnvT` context.


## Module Control.Comonad.Env.Class

This module defines the `ComonadEnv` type class and its instances.

#### `ComonadAsk`

``` purescript
class (Comonad w) <= ComonadAsk e w | w -> e where
  ask :: forall a. w a -> e
```

The `ComonadEnv` type class represents those comonads which support a
global environment that can be provided via the `ask` function.

An implementation is provided for `EnvT`.

##### Instances
``` purescript
ComonadAsk e (Tuple e)
(Comonad w) => ComonadAsk e (EnvT e w)
```

#### `asks`

``` purescript
asks :: forall e1 e2 w a. ComonadAsk e1 w => (e1 -> e2) -> w a -> e2
```

Get a value which depends on the environment.

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



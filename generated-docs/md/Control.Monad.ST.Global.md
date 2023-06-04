## Module Control.Monad.ST.Global

#### `Global`

``` purescript
data Global
```

This region allows `ST` computations to be converted into `Effect`
computations so they can be run in a global context.

#### `toEffect`

``` purescript
toEffect :: (ST Global) ~> Effect
```

Converts an `ST` computation into an `Effect` computation.



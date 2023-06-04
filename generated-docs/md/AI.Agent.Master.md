## Module AI.Agent.Master

#### `_master`

``` purescript
_master :: Proxy @Symbol "master"
```

#### `Agent`

``` purescript
type Agent state errors m = Agent state errors Start m
```

#### `_start`

``` purescript
_start :: Proxy @Symbol "start"
```

#### `Start`

``` purescript
data Start (a :: Type)
  = Start a
```

##### Instances
``` purescript
Functor Start
```

#### `define`

``` purescript
define :: forall state errors m a. Monad m => (Unit -> M state errors m a) -> Agent state errors Start m
```

#### `run`

``` purescript
run :: forall state errors m. Monad m => Agent state errors m -> state -> m Unit
```



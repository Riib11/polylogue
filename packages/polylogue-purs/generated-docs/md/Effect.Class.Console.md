## Module Effect.Class.Console

#### `log`

``` purescript
log :: forall m. MonadEffect m => String -> m Unit
```

#### `logShow`

``` purescript
logShow :: forall m a. MonadEffect m => Show a => a -> m Unit
```

#### `warn`

``` purescript
warn :: forall m. MonadEffect m => String -> m Unit
```

#### `warnShow`

``` purescript
warnShow :: forall m a. MonadEffect m => Show a => a -> m Unit
```

#### `error`

``` purescript
error :: forall m. MonadEffect m => String -> m Unit
```

#### `errorShow`

``` purescript
errorShow :: forall m a. MonadEffect m => Show a => a -> m Unit
```

#### `info`

``` purescript
info :: forall m. MonadEffect m => String -> m Unit
```

#### `infoShow`

``` purescript
infoShow :: forall m a. MonadEffect m => Show a => a -> m Unit
```

#### `debug`

``` purescript
debug :: forall m. MonadEffect m => String -> m Unit
```

#### `debugShow`

``` purescript
debugShow :: forall m a. MonadEffect m => Show a => a -> m Unit
```

#### `time`

``` purescript
time :: forall m. MonadEffect m => String -> m Unit
```

#### `timeLog`

``` purescript
timeLog :: forall m. MonadEffect m => String -> m Unit
```

#### `timeEnd`

``` purescript
timeEnd :: forall m. MonadEffect m => String -> m Unit
```

#### `clear`

``` purescript
clear :: forall m. MonadEffect m => m Unit
```



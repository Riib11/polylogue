## Module Effect.Console

#### `log`

``` purescript
log :: String -> Effect Unit
```

Write a message to the console.

#### `logShow`

``` purescript
logShow :: forall a. Show a => a -> Effect Unit
```

Write a value to the console, using its `Show` instance to produce a
`String`.

#### `warn`

``` purescript
warn :: String -> Effect Unit
```

Write an warning to the console.

#### `warnShow`

``` purescript
warnShow :: forall a. Show a => a -> Effect Unit
```

Write an warning value to the console, using its `Show` instance to produce
a `String`.

#### `error`

``` purescript
error :: String -> Effect Unit
```

Write an error to the console.

#### `errorShow`

``` purescript
errorShow :: forall a. Show a => a -> Effect Unit
```

Write an error value to the console, using its `Show` instance to produce a
`String`.

#### `info`

``` purescript
info :: String -> Effect Unit
```

Write an info message to the console.

#### `infoShow`

``` purescript
infoShow :: forall a. Show a => a -> Effect Unit
```

Write an info value to the console, using its `Show` instance to produce a
`String`.

#### `debug`

``` purescript
debug :: String -> Effect Unit
```

Write an debug message to the console.

#### `debugShow`

``` purescript
debugShow :: forall a. Show a => a -> Effect Unit
```

Write an debug value to the console, using its `Show` instance to produce a
`String`.

#### `time`

``` purescript
time :: String -> Effect Unit
```

Start a named timer.

#### `timeLog`

``` purescript
timeLog :: String -> Effect Unit
```

Print the time since a named timer started in milliseconds.

#### `timeEnd`

``` purescript
timeEnd :: String -> Effect Unit
```

Stop a named timer and print time since it started in milliseconds.

#### `clear`

``` purescript
clear :: Effect Unit
```

Clears the console



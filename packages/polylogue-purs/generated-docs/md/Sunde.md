## Module Sunde

#### `spawn`

``` purescript
spawn :: { args :: Array String, cmd :: String, stdin :: Maybe String } -> SpawnOptions -> Aff { exit :: Exit, stderr :: String, stdout :: String }
```

#### `spawn'`

``` purescript
spawn' :: Encoding -> Signal -> { args :: Array String, cmd :: String, stdin :: Maybe String } -> SpawnOptions -> Aff { exit :: Exit, stderr :: String, stdout :: String }
```



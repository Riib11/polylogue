## Module Test.Spec.Console

#### `tellLn`

``` purescript
tellLn :: forall m. MonadWriter String m => String -> m Unit
```

#### `tellLns`

``` purescript
tellLns :: forall m. MonadWriter String m => Array String -> m Unit
```

#### `write`

``` purescript
write :: String -> Effect Unit
```

#### `logWriter`

``` purescript
logWriter :: forall m. MonadEffect m => WriterT String m Unit -> m Unit
```



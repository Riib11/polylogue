## Module Effect.File

#### `FilePath`

``` purescript
newtype FilePath
  = FilePath String
```

#### `writeFile`

``` purescript
writeFile :: forall m. MonadEffect m => String -> FilePath -> m Unit
```

#### `_writeFile`

``` purescript
_writeFile :: String -> String -> Void
```



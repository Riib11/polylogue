## Module Data.Symbol

#### `IsSymbol`

``` purescript
class IsSymbol (sym :: Symbol)  where
  reflectSymbol :: Proxy sym -> String
```

A class for known symbols

#### `reifySymbol`

``` purescript
reifySymbol :: forall r. String -> (forall sym. IsSymbol sym => Proxy sym -> r) -> r
```



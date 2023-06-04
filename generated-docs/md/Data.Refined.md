## Module Data.Refined

#### `Refined`

``` purescript
class Refined a b  where
  refinement :: a -> String \/ b
```

#### `makeRefined`

``` purescript
makeRefined :: forall a b. Refined a b => a -> b
```



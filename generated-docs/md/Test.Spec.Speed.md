## Module Test.Spec.Speed

#### `Speed`

``` purescript
data Speed
  = Fast
  | Medium
  | Slow
```

##### Instances
``` purescript
Generic Speed _
Show Speed
Eq Speed
```

#### `speedOf`

``` purescript
speedOf :: Milliseconds -> Milliseconds -> Speed
```

#### `toStyle`

``` purescript
toStyle :: Speed -> Style
```



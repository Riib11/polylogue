## Module Hole

#### `HoleWarning`

``` purescript
class HoleWarning 
```

##### Instances
``` purescript
(Warn (Text "Contains holes")) => HoleWarning
```

#### `hole`

``` purescript
hole :: forall a b. HoleWarning => a -> b
```



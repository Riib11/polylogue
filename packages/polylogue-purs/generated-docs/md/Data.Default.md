## Module Data.Default

#### `HasDefault`

``` purescript
class HasDefault a  where
  _default :: a
```

#### `Default`

``` purescript
newtype Default a
  = Default a
```

#### `default`

``` purescript
default :: forall a. HasDefault (Default a) => a
```



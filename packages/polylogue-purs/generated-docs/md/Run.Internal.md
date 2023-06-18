## Module Run.Internal

#### `Choose`

``` purescript
data Choose a
  = Empty
  | Alt (Boolean -> a)
```

##### Instances
``` purescript
Functor Choose
```

#### `CHOOSE`

``` purescript
type CHOOSE r = (choose :: Choose | r)
```

#### `_choose`

``` purescript
_choose :: Proxy "choose"
```

#### `toRows`

``` purescript
toRows :: forall f r1 r2 a. TypeEquals (Proxy r1) (Proxy r2) => f r1 a -> f r2 a
```

#### `fromRows`

``` purescript
fromRows :: forall f r1 r2 a. TypeEquals (Proxy r1) (Proxy r2) => f r2 a -> f r1 a
```



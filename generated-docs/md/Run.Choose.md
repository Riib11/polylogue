## Module Run.Choose

#### `liftChoose`

``` purescript
liftChoose :: forall r a. Choose a -> Run (CHOOSE + r) a
```

#### `cempty`

``` purescript
cempty :: forall r a. Run (CHOOSE + r) a
```

#### `calt`

``` purescript
calt :: forall r a. Run (CHOOSE + r) a -> Run (CHOOSE + r) a -> Run (CHOOSE + r) a
```

#### `runChoose`

``` purescript
runChoose :: forall f a r. Alternative f => Run (CHOOSE + r) a -> Run r (f a)
```


### Re-exported from Run.Internal:

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


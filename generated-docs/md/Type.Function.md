## Module Type.Function

#### `APPLY`

``` purescript
type APPLY f a = f a
```

Polymorphic Type application

For example...
```
APPLY Maybe Int == Maybe $ Int == Maybe Int
```

#### `type ($)`

``` purescript
infixr 0 type APPLY as ype ($
```

#### `FLIP`

``` purescript
type FLIP a f = f a
```

Reversed polymorphic Type application

For example...
```
FLIP Int Maybe == Int # Maybe == Maybe Int
```

#### `type (#)`

``` purescript
infixl 1 type FLIP as ype (#
```



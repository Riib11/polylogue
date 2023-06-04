## Module Run.Except

#### `Except`

``` purescript
newtype Except e a
  = Except e
```

##### Instances
``` purescript
Functor (Except e)
```

#### `EXCEPT`

``` purescript
type EXCEPT e r = (except :: Except e | r)
```

#### `FAIL`

``` purescript
type FAIL r = EXCEPT Unit r
```

#### `_except`

``` purescript
_except :: Proxy "except"
```

#### `liftExcept`

``` purescript
liftExcept :: forall e a r. Except e a -> Run ((EXCEPT e) + r) a
```

#### `liftExceptAt`

``` purescript
liftExceptAt :: forall t e a r s. IsSymbol s => Cons s (Except e) t r => Proxy s -> Except e a -> Run r a
```

#### `runExcept`

``` purescript
runExcept :: forall e a r. Run ((EXCEPT e) + r) a -> Run r (Either e a)
```

#### `runExceptAt`

``` purescript
runExceptAt :: forall t e a r s. IsSymbol s => Cons s (Except e) t r => Proxy s -> Run r a -> Run t (Either e a)
```

#### `runFail`

``` purescript
runFail :: forall a r. Run (FAIL + r) a -> Run r (Maybe a)
```

#### `runFailAt`

``` purescript
runFailAt :: forall t a r s. IsSymbol s => Cons s Fail t r => Proxy s -> Run r a -> Run t (Maybe a)
```

#### `throw`

``` purescript
throw :: forall e a r. e -> Run ((EXCEPT e) + r) a
```

#### `throwAt`

``` purescript
throwAt :: forall t e a r s. IsSymbol s => Cons s (Except e) t r => Proxy s -> e -> Run r a
```

#### `fail`

``` purescript
fail :: forall a r. Run (FAIL + r) a
```

#### `failAt`

``` purescript
failAt :: forall t a r s. IsSymbol s => Cons s Fail t r => Proxy s -> Run r a
```

#### `rethrow`

``` purescript
rethrow :: forall e a r. Either e a -> Run ((EXCEPT e) + r) a
```

#### `rethrowAt`

``` purescript
rethrowAt :: forall t e a r s. IsSymbol s => Cons s (Except e) t r => Proxy s -> Either e a -> Run r a
```

#### `note`

``` purescript
note :: forall e a r. e -> Maybe a -> Run ((EXCEPT e) + r) a
```

#### `noteAt`

``` purescript
noteAt :: forall t e a r s. IsSymbol s => Cons s (Except e) t r => Proxy s -> e -> Maybe a -> Run r a
```

#### `fromJust`

``` purescript
fromJust :: forall a r. Maybe a -> Run (FAIL + r) a
```

#### `fromJustAt`

``` purescript
fromJustAt :: forall t a r s. IsSymbol s => Cons s Fail t r => Proxy s -> Maybe a -> Run r a
```

#### `catch`

``` purescript
catch :: forall e a r. (e -> Run r a) -> Run ((EXCEPT e) + r) a -> Run r a
```

#### `catchAt`

``` purescript
catchAt :: forall t e a r s. IsSymbol s => Cons s (Except e) t r => Proxy s -> (e -> Run t a) -> Run r a -> Run t a
```



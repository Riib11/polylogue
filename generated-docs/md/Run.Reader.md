## Module Run.Reader

#### `Reader`

``` purescript
newtype Reader e a
  = Reader (e -> a)
```

##### Instances
``` purescript
Functor (Reader e)
```

#### `READER`

``` purescript
type READER e r = (reader :: Reader e | r)
```

#### `_reader`

``` purescript
_reader :: Proxy "reader"
```

#### `liftReader`

``` purescript
liftReader :: forall e a r. Reader e a -> Run ((READER e) + r) a
```

#### `liftReaderAt`

``` purescript
liftReaderAt :: forall t e a r s. IsSymbol s => Cons s (Reader e) t r => Proxy s -> Reader e a -> Run r a
```

#### `ask`

``` purescript
ask :: forall e r. Run ((READER e) + r) e
```

#### `asks`

``` purescript
asks :: forall e r a. (e -> a) -> Run ((READER e) + r) a
```

#### `askAt`

``` purescript
askAt :: forall t e r s. IsSymbol s => Cons s (Reader e) t r => Proxy s -> Run r e
```

#### `asksAt`

``` purescript
asksAt :: forall t e r s a. IsSymbol s => Cons s (Reader e) t r => Proxy s -> (e -> a) -> Run r a
```

#### `local`

``` purescript
local :: forall e a r. (e -> e) -> Run ((READER e) + r) a -> Run ((READER e) + r) a
```

#### `localAt`

``` purescript
localAt :: forall t e a r s. IsSymbol s => Cons s (Reader e) t r => Proxy s -> (e -> e) -> Run r a -> Run r a
```

#### `runReader`

``` purescript
runReader :: forall e a r. e -> Run ((READER e) + r) a -> Run r a
```

#### `runReaderAt`

``` purescript
runReaderAt :: forall t e a r s. IsSymbol s => Cons s (Reader e) t r => Proxy s -> e -> Run r a -> Run t a
```



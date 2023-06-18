## Module Pipes

#### `(<~)`

``` purescript
infixl 4 composeLoopBodies' as <~
```

#### `(~>)`

``` purescript
infixr 4 composeLoopBodies as ~>
```

#### `(>~)`

``` purescript
infixr 5 replaceAwait as >~
```

#### `(~<)`

``` purescript
infixl 5 replaceAwait' as ~<
```

#### `(>->)`

``` purescript
infixl 7 composePipes as >->
```

#### `(<-<)`

``` purescript
infixr 7 composePipes' as <-<
```

#### `for`

``` purescript
for :: forall a b b' c c' x x' m. Monad m => Proxy x' x b' b m a -> (b -> Proxy x' x c' c m b') -> Proxy x' x c' c m a
```

#### `composeLoopBodies`

``` purescript
composeLoopBodies :: forall a a' b b' c c' x x' m. Monad m => (a -> Proxy x' x b' b m a') -> (b -> Proxy x' x c' c m b') -> (a -> Proxy x' x c' c m a')
```

#### `composeLoopBodies'`

``` purescript
composeLoopBodies' :: forall a a' b b' c c' x x' m. Monad m => (b -> Proxy x' x c' c m b') -> (a -> Proxy x' x b' b m a') -> (a -> Proxy x' x c' c m a')
```

#### `await`

``` purescript
await :: forall a m. Monad m => Consumer_ a m a
```

#### `replaceAwait`

``` purescript
replaceAwait :: forall a a' b y y' c m. Monad m => Proxy a' a y' y m b -> Proxy Unit b y' y m c -> Proxy a' a y' y m c
```

#### `replaceAwait'`

``` purescript
replaceAwait' :: forall a a' b y y' c m. Monad m => Proxy Unit b y' y m c -> Proxy a' a y' y m b -> Proxy a' a y' y m c
```

#### `cat`

``` purescript
cat :: forall a m r. Monad m => Pipe a a m r
```

#### `composePipes`

``` purescript
composePipes :: forall a a' b c c' m r. Monad m => Proxy a' a Unit b m r -> Proxy Unit b c' c m r -> Proxy a' a c' c m r
```

#### `composePipes'`

``` purescript
composePipes' :: forall a a' b c c' m r. Monad m => Proxy Unit b c' c m r -> Proxy a' a Unit b m r -> Proxy a' a c' c m r
```

#### `yield`

``` purescript
yield :: forall m a. Monad m => a -> Producer_ a m Unit
```

#### `next`

``` purescript
next :: forall a m r. Monad m => Producer a m r -> m (Either r (Tuple a (Producer a m r)))
```

Consume the first value from a `Producer`

#### `each`

``` purescript
each :: forall a f m. Monad m => Foldable f => f a -> Producer_ a m Unit
```

Convert a `F.Foldable` to a `Producer`

#### `discard`

``` purescript
discard :: forall a m. Monad m => a -> m Unit
```

Discards a value



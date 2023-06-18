## Module Pipes.Core

#### `runEffect`

``` purescript
runEffect :: forall m r. Monad m => Effect m r -> m r
```

#### `runEffectRec`

``` purescript
runEffectRec :: forall m r. MonadRec m => Effect m r -> m r
```

#### `respond`

``` purescript
respond :: forall m a a' x x'. Monad m => a -> Proxy x' x a' a m a'
```

#### `composeResponse'`

``` purescript
composeResponse' :: forall m x x' a a' b b' c c'. Monad m => (a -> Proxy x' x b' b m a') -> (b -> Proxy x' x c' c m b') -> (a -> Proxy x' x c' c m a')
```

#### `(/>/)`

``` purescript
infixr 4 composeResponse' as />/
```

#### `composeResponse`

``` purescript
composeResponse :: forall m x x' a' b b' c c'. Monad m => Proxy x' x b' b m a' -> (b -> Proxy x' x c' c m b') -> Proxy x' x c' c m a'
```

#### `(//>)`

``` purescript
infixl 4 composeResponse as //>
```

#### `request`

``` purescript
request :: forall a a' y y' m. Monad m => a' -> Proxy a' a y' y m a
```

#### `composeRequest'`

``` purescript
composeRequest' :: forall a a' b b' c c' y y' m. Monad m => (b' -> Proxy a' a y' y m b) -> (c' -> Proxy b' b y' y m c) -> (c' -> Proxy a' a y' y m c)
```

#### `(\>\)`

``` purescript
infixr 4 composeRequest' as \>\
```

#### `composeRequest`

``` purescript
composeRequest :: forall a a' b b' c y y' m. Monad m => (b' -> Proxy a' a y' y m b) -> Proxy b' b y' y m c -> Proxy a' a y' y m c
```

#### `(>\\)`

``` purescript
infixl 5 composeRequest as >\\
```

#### `push`

``` purescript
push :: forall a a' m r. Monad m => a -> Proxy a' a a' a m r
```

#### `composePush`

``` purescript
composePush :: forall _a a a' b b' c c' m r. Monad m => (_a -> Proxy a' a b' b m r) -> (b -> Proxy b' b c' c m r) -> (_a -> Proxy a' a c' c m r)
```

#### `(>~>)`

``` purescript
infixr 8 composePush as >~>
```

#### `composePush'`

``` purescript
composePush' :: forall a a' b b' c c' m r. Monad m => Proxy a' a b' b m r -> (b -> Proxy b' b c' c m r) -> Proxy a' a c' c m r
```

#### `(>>~)`

``` purescript
infixl 7 composePush' as >>~
```

#### `pull`

``` purescript
pull :: forall a a' m r. Monad m => a' -> Proxy a' a a' a m r
```

#### `composePull`

``` purescript
composePull :: forall a a' b b' c c' _c' m r. Monad m => (b' -> Proxy a' a b' b m r) -> (_c' -> Proxy b' b c' c m r) -> (_c' -> Proxy a' a c' c m r)
```

#### `(>+>)`

``` purescript
infixl 7 composePull as >+>
```

#### `composePull'`

``` purescript
composePull' :: forall a a' b b' c c' m r. Monad m => (b' -> Proxy a' a b' b m r) -> Proxy b' b c' c m r -> Proxy a' a c' c m r
```

#### `(+>>)`

``` purescript
infixr 6 composePull' as +>>
```

#### `reflect`

``` purescript
reflect :: forall a a' b b' m r. Monad m => Proxy a' a b' b m r -> Proxy b b' a a' m r
```

#### `Effect`

``` purescript
type Effect = Proxy X Unit Unit X
```

#### `Producer`

``` purescript
type Producer b = Proxy X Unit Unit b
```

#### `Pipe`

``` purescript
type Pipe a b = Proxy Unit a Unit b
```

#### `Consumer`

``` purescript
type Consumer a = Proxy Unit a Unit X
```

#### `Client`

``` purescript
type Client a' a = Proxy a' a Unit X
```

#### `Server`

``` purescript
type Server b' b = Proxy X Unit b' b
```

#### `Effect_`

``` purescript
type Effect_ m r = forall x' x y' y. Proxy x' x y' y m r
```

#### `Producer_`

``` purescript
type Producer_ b m r = forall x' x. Proxy x' x Unit b m r
```

#### `Consumer_`

``` purescript
type Consumer_ a m r = forall y' y. Proxy Unit a y' y m r
```

#### `Client_`

``` purescript
type Client_ a' a m r = forall y' y. Proxy a' a y' y m r
```

#### `Server_`

``` purescript
type Server_ b' b m r = forall x' x. Proxy x' x b' b m r
```

#### `flippedComposeResponse'`

``` purescript
flippedComposeResponse' :: forall m x x' a a' b b' c c'. Monad m => (b -> Proxy x' x c' c m b') -> (a -> Proxy x' x b' b m a') -> (a -> Proxy x' x c' c m a')
```

Equivalent to ('/>/') with the arguments flipped

#### `(\<\)`

``` purescript
infixl 4 flippedComposeResponse' as \<\
```

#### `flippedComposeRequest'`

``` purescript
flippedComposeRequest' :: forall a a' b b' c c' y y' m. Monad m => (c' -> Proxy b' b y' y m c) -> (b' -> Proxy a' a y' y m b) -> (c' -> Proxy a' a y' y m c)
```

Equivalent to ('\>\') with the arguments flipped

#### `(/</)`

``` purescript
infixr 4 flippedComposeRequest' as /</
```

#### `flippedComposePush`

``` purescript
flippedComposePush :: forall a a' b b' c c' m r. Monad m => (b -> Proxy b' b c' c m r) -> (a -> Proxy a' a b' b m r) -> (a -> Proxy a' a c' c m r)
```

Equivalent to ('>~>') with the arguments flipped

#### `(<~<)`

``` purescript
infixl 8 flippedComposePush as <~<
```

#### `flippedComposePush'`

``` purescript
flippedComposePush' :: forall a a' b b' c c' m r. Monad m => (b -> Proxy b' b c' c m r) -> Proxy a' a b' b m r -> Proxy a' a c' c m r
```

Equivalent to ('>>~') with the arguments flipped

#### `(~<<)`

``` purescript
infixr 7 flippedComposePush' as ~<<
```

#### `flippedComposePull`

``` purescript
flippedComposePull :: forall a a' b b' c c' m r. Monad m => (c' -> Proxy b' b c' c m r) -> (b' -> Proxy a' a b' b m r) -> (c' -> Proxy a' a c' c m r)
```

Equivalent to ('>+>') with the arguments flipped

#### `(<+<)`

``` purescript
infixr 7 flippedComposePull as <+<
```

#### `flippedComposePull'`

``` purescript
flippedComposePull' :: forall a a' b b' c c' m r. Monad m => Proxy b' b c' c m r -> (b' -> Proxy a' a b' b m r) -> Proxy a' a c' c m r
```

Equivalent to ('+>>') with the arguments flipped

#### `(<<+)`

``` purescript
infixl 6 flippedComposePull' as <<+
```

#### `flippedComposeResponse`

``` purescript
flippedComposeResponse :: forall m x x' a' b b' c c'. Monad m => (b -> Proxy x' x c' c m b') -> Proxy x' x b' b m a' -> Proxy x' x c' c m a'
```

Equivalent to ('//>') with the arguments flipped

#### `(<\\)`

``` purescript
infixr 3 flippedComposeResponse as <\\
```

#### `flippedComposeRequest`

``` purescript
flippedComposeRequest :: forall a a' b b' c y y' m. Monad m => Proxy b' b y' y m c -> (b' -> Proxy a' a y' y m b) -> Proxy a' a y' y m c
```

Equivalent to ('>\\') with the arguments flipped

#### `(//<)`

``` purescript
infixl 4 flippedComposeRequest as //<
```


### Re-exported from Pipes.Internal:

#### `X`

``` purescript
newtype X
```

#### `Proxy`

``` purescript
data Proxy a' a b' b m r
```

##### Instances
``` purescript
(Monad m) => Functor (Proxy a' a b' b m)
(Monad m) => Apply (Proxy a' a b' b m)
(Monad m) => Applicative (Proxy a' a b' b m)
(Monad m) => Bind (Proxy a' a b' b m)
(Monad m) => Monad (Proxy a' a b' b m)
(Monad m, Monoid r) => Monoid (Proxy a' a b' b m r)
(Monad m, Semigroup r) => Semigroup (Proxy a' a b' b m r)
MonadTrans (Proxy a' a b' b)
MFunctor (Proxy a' a b' b)
MMonad (Proxy a' a b' b)
(MonadEffect m) => MonadEffect (Proxy a' a b' b m)
(MonadAff m) => MonadAff (Proxy a' a b' b m)
(MonadAsk r m) => MonadAsk r (Proxy a' a b' b m)
(MonadReader r m) => MonadReader r (Proxy a' a b' b m)
(MonadState s m) => MonadState s (Proxy a' a b' b m)
(Monoid w, MonadTell w m) => MonadTell w (Proxy a' a b' b m)
(Monoid w, MonadWriter w m) => MonadWriter w (Proxy a' a b' b m)
(MonadPlus m) => Alt (Proxy a' a b' b m)
(MonadPlus m) => Plus (Proxy a' a b' b m)
(MonadPlus m) => Alternative (Proxy a' a b' b m)
(MonadThrow e m) => MonadThrow e (Proxy a' a b' b m)
(MonadError e m) => MonadError e (Proxy a' a b' b m)
(Monad m) => MonadRec (Proxy a' a b' b m)
```

#### `closed`

``` purescript
closed :: forall a. X -> a
```


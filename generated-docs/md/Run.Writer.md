## Module Run.Writer

#### `Writer`

``` purescript
data Writer w a
  = Writer w a
```

##### Instances
``` purescript
Functor (Writer w)
```

#### `WRITER`

``` purescript
type WRITER w r = (writer :: Writer w | r)
```

#### `_writer`

``` purescript
_writer :: Proxy "writer"
```

#### `liftWriter`

``` purescript
liftWriter :: forall w a r. Writer w a -> Run ((WRITER w) + r) a
```

#### `liftWriterAt`

``` purescript
liftWriterAt :: forall w a r t s. IsSymbol s => Cons s (Writer w) t r => Proxy s -> Writer w a -> Run r a
```

#### `tell`

``` purescript
tell :: forall w r. w -> Run (writer :: Writer w | r) Unit
```

#### `tellAt`

``` purescript
tellAt :: forall w r t s. IsSymbol s => Cons s (Writer w) t r => Proxy s -> w -> Run r Unit
```

#### `censor`

``` purescript
censor :: forall w a r. (w -> w) -> Run (writer :: Writer w | r) a -> Run (writer :: Writer w | r) a
```

#### `censorAt`

``` purescript
censorAt :: forall w a r t s. IsSymbol s => Cons s (Writer w) t r => Proxy s -> (w -> w) -> Run r a -> Run r a
```

#### `foldWriter`

``` purescript
foldWriter :: forall w b a r. (b -> w -> b) -> b -> Run ((WRITER w) + r) a -> Run r (Tuple b a)
```

#### `foldWriterAt`

``` purescript
foldWriterAt :: forall w b a r t s. IsSymbol s => Cons s (Writer w) t r => Proxy s -> (b -> w -> b) -> b -> Run r a -> Run t (Tuple b a)
```

#### `runWriter`

``` purescript
runWriter :: forall w a r. Monoid w => Run ((WRITER w) + r) a -> Run r (Tuple w a)
```

#### `runWriterAt`

``` purescript
runWriterAt :: forall w a r t s. IsSymbol s => Monoid w => Cons s (Writer w) t r => Proxy s -> Run r a -> Run t (Tuple w a)
```



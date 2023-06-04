## Module Run.State

#### `State`

``` purescript
data State s a
  = State (s -> s) (s -> a)
```

##### Instances
``` purescript
Functor (State s)
```

#### `STATE`

``` purescript
type STATE s r = (state :: State s | r)
```

#### `_state`

``` purescript
_state :: Proxy "state"
```

#### `liftState`

``` purescript
liftState :: forall s a r. State s a -> Run ((STATE s) + r) a
```

#### `liftStateAt`

``` purescript
liftStateAt :: forall q sym s a r. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> State s a -> Run r a
```

#### `modify`

``` purescript
modify :: forall s r. (s -> s) -> Run ((STATE s) + r) Unit
```

#### `modifyAt`

``` purescript
modifyAt :: forall q sym s r. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> (s -> s) -> Run r Unit
```

#### `put`

``` purescript
put :: forall s r. s -> Run ((STATE s) + r) Unit
```

#### `putAt`

``` purescript
putAt :: forall q sym s r. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> s -> Run r Unit
```

#### `get`

``` purescript
get :: forall s r. Run ((STATE s) + r) s
```

#### `getAt`

``` purescript
getAt :: forall q sym s r. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> Run r s
```

#### `gets`

``` purescript
gets :: forall s t r. (s -> t) -> Run ((STATE s) + r) t
```

#### `getsAt`

``` purescript
getsAt :: forall q sym s t r. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> (s -> t) -> Run r t
```

#### `runState`

``` purescript
runState :: forall s r a. s -> Run ((STATE s) + r) a -> Run r (Tuple s a)
```

#### `runStateAt`

``` purescript
runStateAt :: forall q sym s r a. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> s -> Run r a -> Run q (Tuple s a)
```

#### `evalState`

``` purescript
evalState :: forall s r a. s -> Run ((STATE s) + r) a -> Run r a
```

#### `evalStateAt`

``` purescript
evalStateAt :: forall q sym s r a. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> s -> Run r a -> Run q a
```

#### `execState`

``` purescript
execState :: forall s r a. s -> Run ((STATE s) + r) a -> Run r s
```

#### `execStateAt`

``` purescript
execStateAt :: forall q sym s r a. IsSymbol sym => Cons sym (State s) q r => Proxy sym -> s -> Run r a -> Run q s
```



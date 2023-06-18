## Module Data.Traversable.Accum.Internal

#### `StateL`

``` purescript
newtype StateL s a
  = StateL (s -> Accum s a)
```

##### Instances
``` purescript
Functor (StateL s)
Apply (StateL s)
Applicative (StateL s)
```

#### `stateL`

``` purescript
stateL :: forall s a. StateL s a -> s -> Accum s a
```

#### `StateR`

``` purescript
newtype StateR s a
  = StateR (s -> Accum s a)
```

##### Instances
``` purescript
Functor (StateR s)
Apply (StateR s)
Applicative (StateR s)
```

#### `stateR`

``` purescript
stateR :: forall s a. StateR s a -> s -> Accum s a
```



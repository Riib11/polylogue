## Module Control.Monad.ST.Ref


### Re-exported from Control.Monad.ST.Internal:

#### `STRef`

``` purescript
data STRef t0 t1
```

The type `STRef r a` represents a mutable reference holding a value of
type `a`, which can be used with the `ST r` effect.

#### `write`

``` purescript
write :: forall a r. a -> STRef r a -> ST r a
```

Set the value of a mutable reference.

#### `read`

``` purescript
read :: forall a r. STRef r a -> ST r a
```

Read the current value of a mutable reference.

#### `new`

``` purescript
new :: forall a r. a -> ST r (STRef r a)
```

Create a new mutable reference.

#### `modify'`

``` purescript
modify' :: forall r a b. (a -> { state :: a, value :: b }) -> STRef r a -> ST r b
```

Update the value of a mutable reference by applying a function
to the current value, computing a new state value for the reference and
a return value.

#### `modify`

``` purescript
modify :: forall r a. (a -> a) -> STRef r a -> ST r a
```

Modify the value of a mutable reference by applying a function to the
current value. The modified value is returned.


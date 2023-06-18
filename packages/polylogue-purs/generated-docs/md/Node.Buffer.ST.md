## Module Node.Buffer.ST

#### `STBuffer`

``` purescript
data STBuffer t0
```

A reference to a mutable buffer for use with `ST`

The type parameter represents the memory region which the buffer belongs to.

##### Instances
``` purescript
MutableBuffer (STBuffer h) (ST h)
```

#### `run`

``` purescript
run :: (forall h. ST h (STBuffer h)) -> ImmutableBuffer
```

Runs an effect creating an `STBuffer` then freezes the buffer and returns
it, without unneccessary copying.



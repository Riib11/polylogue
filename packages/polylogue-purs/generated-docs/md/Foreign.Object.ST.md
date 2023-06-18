## Module Foreign.Object.ST

Helper functions for working with mutable objects using the `ST` effect.

This module can be used when performance is important and mutation is a
local effect.

#### `STObject`

``` purescript
data STObject t0 t1
```

A reference to a mutable object

The first type parameter represents the memory region which the map belongs
to. The second type parameter defines the type of elements of the mutable
object.

The runtime representation of a value of type `STObject r a` is the same as
that of `Object a`, except that mutation is allowed.

#### `new`

``` purescript
new :: forall a r. ST r (STObject r a)
```

Create a new, empty mutable object

#### `peek`

``` purescript
peek :: forall a r. String -> STObject r a -> ST r (Maybe a)
```

Get the value for a key in a mutable object

#### `poke`

``` purescript
poke :: forall a r. String -> a -> STObject r a -> ST r (STObject r a)
```

Update the value for a key in a mutable object

#### `delete`

``` purescript
delete :: forall a r. String -> STObject r a -> ST r (STObject r a)
```

Remove a key and the corresponding value from a mutable object



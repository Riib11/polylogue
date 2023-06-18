## Module Effect.Aff.AVar

#### `new`

``` purescript
new :: forall a. a -> Aff (AVar a)
```

Creates a fresh AVar with an initial value.

#### `empty`

``` purescript
empty :: forall a. Aff (AVar a)
```

Creates a fresh AVar.

#### `status`

``` purescript
status :: forall a. AVar a -> Aff (AVarStatus a)
```

Synchronously checks the status of an AVar.

#### `take`

``` purescript
take :: forall a. AVar a -> Aff a
```

Takes the AVar value, leaving it empty. If the AVar is already empty,
the callback will be queued until the AVar is filled. Multiple takes will
resolve in order as the AVar fills.

#### `tryTake`

``` purescript
tryTake :: forall a. AVar a -> Aff (Maybe a)
```

Attempts to synchronously take an AVar value, leaving it empty. If the
AVar is empty, this will return `Nothing`.

#### `put`

``` purescript
put :: forall a. a -> AVar a -> Aff Unit
```

Sets the value of the AVar. If the AVar is already filled, it will be
queued until the value is emptied. Multiple puts will resolve in order as
the AVar becomes available.

#### `tryPut`

``` purescript
tryPut :: forall a. a -> AVar a -> Aff Boolean
```

Attempts to synchronously fill an AVar. If the AVar is already filled,
this will do nothing. Returns true or false depending on if it succeeded.

#### `read`

``` purescript
read :: forall a. AVar a -> Aff a
```

Reads the AVar value. Unlike `take`, this will not leave the AVar empty.
If the AVar is empty, this will queue until it is filled. Multiple reads
will resolve at the same time, as soon as possible.

#### `tryRead`

``` purescript
tryRead :: forall a. AVar a -> Aff (Maybe a)
```

Attempts to synchronously read an AVar. If the AVar is empty, this will
return `Nothing`.

#### `kill`

``` purescript
kill :: forall a. Error -> AVar a -> Aff Unit
```

Kills the AVar with an exception. All pending and future actions will
resolve immediately with the provided exception.


### Re-exported from Effect.AVar:

#### `AVarStatus`

``` purescript
data AVarStatus a
  = Killed Error
  | Filled a
  | Empty
```

#### `AVar`

``` purescript
data AVar t0
```

#### `isKilled`

``` purescript
isKilled :: forall a. AVarStatus a -> Boolean
```

#### `isFilled`

``` purescript
isFilled :: forall a. AVarStatus a -> Boolean
```

#### `isEmpty`

``` purescript
isEmpty :: forall a. AVarStatus a -> Boolean
```


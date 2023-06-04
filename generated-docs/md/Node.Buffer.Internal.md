## Module Node.Buffer.Internal

Functions and types to support the other modules. Not for public use.

#### `unsafeFreeze`

``` purescript
unsafeFreeze :: forall buf m. Monad m => buf -> m ImmutableBuffer
```

#### `unsafeThaw`

``` purescript
unsafeThaw :: forall buf m. Monad m => ImmutableBuffer -> m buf
```

#### `usingFromImmutable`

``` purescript
usingFromImmutable :: forall buf m a. Monad m => (ImmutableBuffer -> a) -> buf -> m a
```

#### `usingToImmutable`

``` purescript
usingToImmutable :: forall buf m a. Monad m => (a -> ImmutableBuffer) -> a -> m buf
```

#### `create`

``` purescript
create :: forall buf m. Monad m => Int -> m buf
```

#### `copyAll`

``` purescript
copyAll :: forall a buf m. a -> m buf
```

#### `fromArray`

``` purescript
fromArray :: forall buf m. Monad m => Array Octet -> m buf
```

#### `fromString`

``` purescript
fromString :: forall buf m. Monad m => String -> Encoding -> m buf
```

#### `fromArrayBuffer`

``` purescript
fromArrayBuffer :: forall buf m. Monad m => ArrayBuffer -> m buf
```

#### `toArrayBuffer`

``` purescript
toArrayBuffer :: forall buf m. Monad m => buf -> m ArrayBuffer
```

#### `read`

``` purescript
read :: forall buf m. Monad m => BufferValueType -> Offset -> buf -> m Number
```

#### `readString`

``` purescript
readString :: forall buf m. Monad m => Encoding -> Offset -> Offset -> buf -> m String
```

#### `toString`

``` purescript
toString :: forall buf m. Monad m => Encoding -> buf -> m String
```

#### `write`

``` purescript
write :: forall buf m. Monad m => BufferValueType -> Number -> Offset -> buf -> m Unit
```

#### `writeString`

``` purescript
writeString :: forall buf m. Monad m => Encoding -> Offset -> Int -> String -> buf -> m Int
```

#### `toArray`

``` purescript
toArray :: forall buf m. Monad m => buf -> m (Array Octet)
```

#### `getAtOffset`

``` purescript
getAtOffset :: forall buf m. Monad m => Offset -> buf -> m (Maybe Octet)
```

#### `setAtOffset`

``` purescript
setAtOffset :: forall buf m. Octet -> Offset -> buf -> m Unit
```

#### `slice`

``` purescript
slice :: forall buf. Offset -> Offset -> buf -> buf
```

#### `size`

``` purescript
size :: forall buf m. Monad m => buf -> m Int
```

#### `concat`

``` purescript
concat :: forall buf m. Array buf -> m buf
```

#### `concat'`

``` purescript
concat' :: forall buf m. Monad m => Array buf -> Int -> m buf
```

#### `copy`

``` purescript
copy :: forall buf m. Offset -> Offset -> buf -> Offset -> buf -> m Int
```

#### `fill`

``` purescript
fill :: forall buf m. Octet -> Offset -> Offset -> buf -> m Unit
```



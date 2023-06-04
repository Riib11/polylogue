## Module Node.Buffer

Mutable buffers and associated operations.

#### `Buffer`

``` purescript
data Buffer
```

A reference to a mutable buffer for use with `Effect`

##### Instances
``` purescript
MutableBuffer Buffer Effect
```


### Re-exported from Node.Buffer.Class:

#### `MutableBuffer`

``` purescript
class (Monad m) <= MutableBuffer buf m | buf -> m where
  create :: Int -> m buf
  freeze :: buf -> m ImmutableBuffer
  unsafeFreeze :: buf -> m ImmutableBuffer
  thaw :: ImmutableBuffer -> m buf
  unsafeThaw :: ImmutableBuffer -> m buf
  fromArray :: Array Octet -> m buf
  fromString :: String -> Encoding -> m buf
  fromArrayBuffer :: ArrayBuffer -> m buf
  toArrayBuffer :: buf -> m ArrayBuffer
  read :: BufferValueType -> Offset -> buf -> m Number
  readString :: Encoding -> Offset -> Offset -> buf -> m String
  toString :: Encoding -> buf -> m String
  write :: BufferValueType -> Number -> Offset -> buf -> m Unit
  writeString :: Encoding -> Offset -> Int -> String -> buf -> m Int
  toArray :: buf -> m (Array Octet)
  getAtOffset :: Offset -> buf -> m (Maybe Octet)
  setAtOffset :: Octet -> Offset -> buf -> m Unit
  slice :: Offset -> Offset -> buf -> buf
  size :: buf -> m Int
  concat :: Array buf -> m buf
  concat' :: Array buf -> Int -> m buf
  copy :: Offset -> Offset -> buf -> Offset -> buf -> m Int
  fill :: Octet -> Offset -> Offset -> buf -> m Unit
```

A type class for mutable buffers `buf` where operations on those buffers are
represented by a particular monadic effect type `m`.

### Re-exported from Node.Buffer.Types:

#### `Offset`

``` purescript
type Offset = Int
```

Type synonym indicating the value refers to an offset in a buffer.

#### `Octet`

``` purescript
type Octet = Int
```

Type synonym indicating the value should be an octet (0-255). If the value
provided is outside this range it will be used as modulo 256.

#### `BufferValueType`

``` purescript
data BufferValueType
  = UInt8
  | UInt16LE
  | UInt16BE
  | UInt32LE
  | UInt32BE
  | Int8
  | Int16LE
  | Int16BE
  | Int32LE
  | Int32BE
  | FloatLE
  | FloatBE
  | DoubleLE
  | DoubleBE
```

Enumeration of the numeric types that can be written to a buffer.

##### Instances
``` purescript
Show BufferValueType
```


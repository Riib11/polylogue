## Module Node.Buffer.Immutable

Immutable buffers and associated operations.

#### `ImmutableBuffer`

``` purescript
data ImmutableBuffer
```

An immutable buffer that exists independently of any memory region or effect.

##### Instances
``` purescript
Show ImmutableBuffer
Eq ImmutableBuffer
Ord ImmutableBuffer
```

#### `create`

``` purescript
create :: Int -> ImmutableBuffer
```

Creates a new buffer of the specified size.

#### `fromArray`

``` purescript
fromArray :: Array Octet -> ImmutableBuffer
```

Creates a new buffer from an array of octets, sized to match the array.

#### `fromString`

``` purescript
fromString :: String -> Encoding -> ImmutableBuffer
```

Creates a new buffer from a string with the specified encoding, sized to match the string.

#### `fromArrayBuffer`

``` purescript
fromArrayBuffer :: ArrayBuffer -> ImmutableBuffer
```

Creates a buffer view from a JS ArrayByffer without copying data.

#### `read`

``` purescript
read :: BufferValueType -> Offset -> ImmutableBuffer -> Number
```

Reads a numeric value from a buffer at the specified offset.

#### `readString`

``` purescript
readString :: Encoding -> Offset -> Offset -> ImmutableBuffer -> String
```

Reads a section of a buffer as a string with the specified encoding.

#### `toString`

``` purescript
toString :: Encoding -> ImmutableBuffer -> String
```

Reads the buffer as a string with the specified encoding.

#### `toArray`

``` purescript
toArray :: ImmutableBuffer -> Array Octet
```

Creates an array of octets from a buffer's contents.

#### `toArrayBuffer`

``` purescript
toArrayBuffer :: ImmutableBuffer -> ArrayBuffer
```

Creates an `ArrayBuffer` by copying a buffer's contents.

#### `getAtOffset`

``` purescript
getAtOffset :: Offset -> ImmutableBuffer -> Maybe Octet
```

Reads an octet from a buffer at the specified offset.

#### `concat`

``` purescript
concat :: Array ImmutableBuffer -> ImmutableBuffer
```

Concatenates a list of buffers.

#### `concat'`

``` purescript
concat' :: Array ImmutableBuffer -> Int -> ImmutableBuffer
```

Concatenates a list of buffers, combining them into a new buffer of the
specified length.

#### `slice`

``` purescript
slice :: Offset -> Offset -> ImmutableBuffer -> ImmutableBuffer
```

Creates a new buffer slice that shares the memory of the original buffer.

#### `size`

``` purescript
size :: ImmutableBuffer -> Int
```

Returns the size of a buffer.



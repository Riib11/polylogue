## Module Node.Buffer.Types

#### `Octet`

``` purescript
type Octet = Int
```

Type synonym indicating the value should be an octet (0-255). If the value
provided is outside this range it will be used as modulo 256.

#### `Offset`

``` purescript
type Offset = Int
```

Type synonym indicating the value refers to an offset in a buffer.

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



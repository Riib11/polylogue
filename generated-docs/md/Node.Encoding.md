## Module Node.Encoding

#### `Encoding`

``` purescript
data Encoding
  = ASCII
  | UTF8
  | UTF16LE
  | UCS2
  | Base64
  | Latin1
  | Binary
  | Hex
```

##### Instances
``` purescript
Show Encoding
```

#### `encodingToNode`

``` purescript
encodingToNode :: Encoding -> String
```

Convert an `Encoding` to a `String` in the format expected by Node.js
APIs.

#### `byteLength`

``` purescript
byteLength :: String -> Encoding -> Int
```



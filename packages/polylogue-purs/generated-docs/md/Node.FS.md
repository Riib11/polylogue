## Module Node.FS

#### `FileDescriptor`

``` purescript
data FileDescriptor
```

#### `FileMode`

``` purescript
type FileMode = Int
```

#### `SymlinkType`

``` purescript
data SymlinkType
  = FileLink
  | DirLink
  | JunctionLink
```

Symlink varieties.

##### Instances
``` purescript
Show SymlinkType
Eq SymlinkType
```

#### `symlinkTypeToNode`

``` purescript
symlinkTypeToNode :: SymlinkType -> String
```

Convert a `SymlinkType` to a `String` in the format expected by the
Node.js filesystem API.

#### `BufferLength`

``` purescript
type BufferLength = Int
```

#### `BufferOffset`

``` purescript
type BufferOffset = Int
```

#### `ByteCount`

``` purescript
type ByteCount = Int
```

#### `FilePosition`

``` purescript
type FilePosition = Int
```


### Re-exported from Node.FS.Constants:

#### `FileFlags`

``` purescript
data FileFlags
  = R
  | R_PLUS
  | RS
  | RS_PLUS
  | W
  | WX
  | W_PLUS
  | WX_PLUS
  | A
  | AX
  | A_PLUS
  | AX_PLUS
```

##### Instances
``` purescript
Show FileFlags
Eq FileFlags
```

#### `fileFlagsToNode`

``` purescript
fileFlagsToNode :: FileFlags -> String
```

Convert a `FileFlags` to a `String` in the format expected by the Node.js
filesystem API.


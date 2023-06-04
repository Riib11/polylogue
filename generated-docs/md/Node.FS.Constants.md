## Module Node.FS.Constants

#### `AccessMode`

``` purescript
data AccessMode
```

the mode parameter passed to `access` and `accessSync`.

#### `f_OK`

``` purescript
f_OK :: AccessMode
```

the file is visible to the calling process. 
This is useful for determining if a file exists, but says nothing about rwx permissions. Default if no mode is specified.

#### `r_OK`

``` purescript
r_OK :: AccessMode
```

the file can be read by the calling process.

#### `w_OK`

``` purescript
w_OK :: AccessMode
```

the file can be written by the calling process.

#### `x_OK`

``` purescript
x_OK :: AccessMode
```

the file can be executed by the calling process. This has no effect on Windows (will behave like fs.constants.F_OK).

#### `defaultAccessMode`

``` purescript
defaultAccessMode :: AccessMode
```

#### `CopyMode`

``` purescript
data CopyMode
```

A constant used in `copyFile`.

##### Instances
``` purescript
Semigroup CopyMode
```

#### `copyFile_EXCL`

``` purescript
copyFile_EXCL :: CopyMode
```

If present, the copy operation will fail with an error if the destination path already exists.

#### `copyFile_FICLONE`

``` purescript
copyFile_FICLONE :: CopyMode
```

If present, the copy operation will attempt to create a copy-on-write reflink. If the underlying platform does not support copy-on-write, then a fallback copy mechanism is used.

#### `copyFile_FICLONE_FORCE`

``` purescript
copyFile_FICLONE_FORCE :: CopyMode
```

 	If present, the copy operation will attempt to create a copy-on-write reflink. If the underlying platform does not support copy-on-write, then the operation will fail with an error.

#### `defaultCopyMode`

``` purescript
defaultCopyMode :: CopyMode
```

#### `appendCopyMode`

``` purescript
appendCopyMode :: Fn2 CopyMode CopyMode CopyMode
```

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



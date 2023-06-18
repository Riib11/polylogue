## Module Node.FS.Async

#### `Callback`

``` purescript
type Callback a = Either Error a -> Effect Unit
```

Type synonym for callback functions.

#### `access`

``` purescript
access :: FilePath -> (Maybe Error -> Effect Unit) -> Effect Unit
```

#### `access'`

``` purescript
access' :: FilePath -> AccessMode -> (Maybe Error -> Effect Unit) -> Effect Unit
```

#### `copyFile`

``` purescript
copyFile :: FilePath -> FilePath -> Callback Unit -> Effect Unit
```

#### `copyFile'`

``` purescript
copyFile' :: FilePath -> FilePath -> CopyMode -> Callback Unit -> Effect Unit
```

#### `mkdtemp`

``` purescript
mkdtemp :: String -> Callback String -> Effect Unit
```

#### `mkdtemp'`

``` purescript
mkdtemp' :: String -> Encoding -> Callback String -> Effect Unit
```

#### `rename`

``` purescript
rename :: FilePath -> FilePath -> Callback Unit -> Effect Unit
```

Renames a file.

#### `truncate`

``` purescript
truncate :: FilePath -> Int -> Callback Unit -> Effect Unit
```

Truncates a file to the specified length.

#### `chown`

``` purescript
chown :: FilePath -> Int -> Int -> Callback Unit -> Effect Unit
```

Changes the ownership of a file.

#### `chmod`

``` purescript
chmod :: FilePath -> Perms -> Callback Unit -> Effect Unit
```

Changes the permissions of a file.

#### `lstat`

``` purescript
lstat :: FilePath -> Callback Stats -> Effect Unit
```

Gets file or symlink statistics. `lstat` is identical to `stat`, except
that if the `FilePath` is a symbolic link, then the link itself is stat-ed,
not the file that it refers to.

#### `stat`

``` purescript
stat :: FilePath -> Callback Stats -> Effect Unit
```

Gets file statistics.

#### `link`

``` purescript
link :: FilePath -> FilePath -> Callback Unit -> Effect Unit
```

Creates a link to an existing file.

#### `symlink`

``` purescript
symlink :: FilePath -> FilePath -> SymlinkType -> Callback Unit -> Effect Unit
```

Creates a symlink.

#### `readlink`

``` purescript
readlink :: FilePath -> Callback FilePath -> Effect Unit
```

Reads the value of a symlink.

#### `realpath`

``` purescript
realpath :: FilePath -> Callback FilePath -> Effect Unit
```

Find the canonicalized absolute location for a path.

#### `realpath'`

``` purescript
realpath' :: forall cache. FilePath -> Record cache -> Callback FilePath -> Effect Unit
```

Find the canonicalized absolute location for a path using a cache object
for already resolved paths.

#### `unlink`

``` purescript
unlink :: FilePath -> Callback Unit -> Effect Unit
```

Deletes a file.

#### `rmdir`

``` purescript
rmdir :: FilePath -> Callback Unit -> Effect Unit
```

Deletes a directory.

#### `rmdir'`

``` purescript
rmdir' :: FilePath -> { maxRetries :: Int, retryDelay :: Int } -> Callback Unit -> Effect Unit
```

Deletes a directory with options.

#### `rm`

``` purescript
rm :: FilePath -> Callback Unit -> Effect Unit
```

Deletes a file or directory.

#### `rm'`

``` purescript
rm' :: FilePath -> { force :: Boolean, maxRetries :: Int, recursive :: Boolean, retryDelay :: Int } -> Callback Unit -> Effect Unit
```

Deletes a file or directory with options.

#### `mkdir`

``` purescript
mkdir :: FilePath -> Callback Unit -> Effect Unit
```

Makes a new directory.

#### `mkdir'`

``` purescript
mkdir' :: FilePath -> { mode :: Perms, recursive :: Boolean } -> Callback Unit -> Effect Unit
```

Makes a new directory with the specified permissions.

#### `readdir`

``` purescript
readdir :: FilePath -> Callback (Array FilePath) -> Effect Unit
```

Reads the contents of a directory.

#### `utimes`

``` purescript
utimes :: FilePath -> DateTime -> DateTime -> Callback Unit -> Effect Unit
```

Sets the accessed and modified times for the specified file.

#### `readFile`

``` purescript
readFile :: FilePath -> Callback Buffer -> Effect Unit
```

Reads the entire contents of a file returning the result as a raw buffer.

#### `readTextFile`

``` purescript
readTextFile :: Encoding -> FilePath -> Callback String -> Effect Unit
```

Reads the entire contents of a text file with the specified encoding.

#### `writeFile`

``` purescript
writeFile :: FilePath -> Buffer -> Callback Unit -> Effect Unit
```

Writes a buffer to a file.

#### `writeTextFile`

``` purescript
writeTextFile :: Encoding -> FilePath -> String -> Callback Unit -> Effect Unit
```

Writes text to a file using the specified encoding.

#### `appendFile`

``` purescript
appendFile :: FilePath -> Buffer -> Callback Unit -> Effect Unit
```

Appends the contents of a buffer to a file.

#### `appendTextFile`

``` purescript
appendTextFile :: Encoding -> FilePath -> String -> Callback Unit -> Effect Unit
```

Appends text to a file using the specified encoding.

#### `fdOpen`

``` purescript
fdOpen :: FilePath -> FileFlags -> Maybe FileMode -> Callback FileDescriptor -> Effect Unit
```

Open a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_open_path_flags_mode_callback)
for details.

#### `fdRead`

``` purescript
fdRead :: FileDescriptor -> Buffer -> BufferOffset -> BufferLength -> Maybe FilePosition -> Callback ByteCount -> Effect Unit
```

Read from a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_read_fd_buffer_offset_length_position_callback)
for details.

#### `fdNext`

``` purescript
fdNext :: FileDescriptor -> Buffer -> Callback ByteCount -> Effect Unit
```

Convenience function to fill the whole buffer from the current
file position.

#### `fdWrite`

``` purescript
fdWrite :: FileDescriptor -> Buffer -> BufferOffset -> BufferLength -> Maybe FilePosition -> Callback ByteCount -> Effect Unit
```

Write to a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_write_fd_buffer_offset_length_position_callback)
for details.

#### `fdAppend`

``` purescript
fdAppend :: FileDescriptor -> Buffer -> Callback ByteCount -> Effect Unit
```

Convenience function to append the whole buffer to the current
file position.

#### `fdClose`

``` purescript
fdClose :: FileDescriptor -> Callback Unit -> Effect Unit
```

Close a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_close_fd_callback)
for details.



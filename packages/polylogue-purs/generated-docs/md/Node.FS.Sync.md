## Module Node.FS.Sync

#### `access`

``` purescript
access :: FilePath -> Effect (Maybe Error)
```

#### `access'`

``` purescript
access' :: FilePath -> AccessMode -> Effect (Maybe Error)
```

#### `copyFile`

``` purescript
copyFile :: FilePath -> FilePath -> Effect Unit
```

#### `copyFile'`

``` purescript
copyFile' :: FilePath -> FilePath -> CopyMode -> Effect Unit
```

#### `mkdtemp`

``` purescript
mkdtemp :: String -> Effect String
```

#### `mkdtemp'`

``` purescript
mkdtemp' :: String -> Encoding -> Effect String
```

#### `rename`

``` purescript
rename :: FilePath -> FilePath -> Effect Unit
```

Renames a file.

#### `truncate`

``` purescript
truncate :: FilePath -> Int -> Effect Unit
```

Truncates a file to the specified length.

#### `chown`

``` purescript
chown :: FilePath -> Int -> Int -> Effect Unit
```

Changes the ownership of a file.

#### `chmod`

``` purescript
chmod :: FilePath -> Perms -> Effect Unit
```

Changes the permissions of a file.

#### `stat`

``` purescript
stat :: FilePath -> Effect Stats
```

Gets file statistics.

#### `lstat`

``` purescript
lstat :: FilePath -> Effect Stats
```

Gets file or symlink statistics. `lstat` is identical to `stat`, except
that if the `FilePath` is a symbolic link, then the link itself is stat-ed,
not the file that it refers to.

#### `link`

``` purescript
link :: FilePath -> FilePath -> Effect Unit
```

Creates a link to an existing file.

#### `symlink`

``` purescript
symlink :: FilePath -> FilePath -> SymlinkType -> Effect Unit
```

Creates a symlink.

#### `readlink`

``` purescript
readlink :: FilePath -> Effect FilePath
```

Reads the value of a symlink.

#### `realpath`

``` purescript
realpath :: FilePath -> Effect FilePath
```

Find the canonicalized absolute location for a path.

#### `realpath'`

``` purescript
realpath' :: forall cache. FilePath -> Record cache -> Effect FilePath
```

Find the canonicalized absolute location for a path using a cache object for
already resolved paths.

#### `unlink`

``` purescript
unlink :: FilePath -> Effect Unit
```

Deletes a file.

#### `rmdir`

``` purescript
rmdir :: FilePath -> Effect Unit
```

Deletes a directory.

#### `rmdir'`

``` purescript
rmdir' :: FilePath -> { maxRetries :: Int, retryDelay :: Int } -> Effect Unit
```

Deletes a directory with options.

#### `rm`

``` purescript
rm :: FilePath -> Effect Unit
```

Deletes a file or directory.

#### `rm'`

``` purescript
rm' :: FilePath -> { force :: Boolean, maxRetries :: Int, recursive :: Boolean, retryDelay :: Int } -> Effect Unit
```

Deletes a file or directory with options.

#### `mkdir`

``` purescript
mkdir :: FilePath -> Effect Unit
```

Makes a new directory.

#### `mkdir'`

``` purescript
mkdir' :: FilePath -> { mode :: Perms, recursive :: Boolean } -> Effect Unit
```

Makes a new directory with the specified permissions.

#### `readdir`

``` purescript
readdir :: FilePath -> Effect (Array FilePath)
```

Reads the contents of a directory.

#### `utimes`

``` purescript
utimes :: FilePath -> DateTime -> DateTime -> Effect Unit
```

Sets the accessed and modified times for the specified file.

#### `readFile`

``` purescript
readFile :: FilePath -> Effect Buffer
```

Reads the entire contents of a file returning the result as a raw buffer.

#### `readTextFile`

``` purescript
readTextFile :: Encoding -> FilePath -> Effect String
```

Reads the entire contents of a text file with the specified encoding.

#### `writeFile`

``` purescript
writeFile :: FilePath -> Buffer -> Effect Unit
```

Writes a buffer to a file.

#### `writeTextFile`

``` purescript
writeTextFile :: Encoding -> FilePath -> String -> Effect Unit
```

Writes text to a file using the specified encoding.

#### `appendFile`

``` purescript
appendFile :: FilePath -> Buffer -> Effect Unit
```

Appends the contents of a buffer to a file.

#### `appendTextFile`

``` purescript
appendTextFile :: Encoding -> FilePath -> String -> Effect Unit
```

Appends text to a file using the specified encoding.

#### `exists`

``` purescript
exists :: FilePath -> Effect Boolean
```

Check if the path exists.

#### `fdOpen`

``` purescript
fdOpen :: FilePath -> FileFlags -> Maybe FileMode -> Effect FileDescriptor
```

Open a file synchronously. See the [Node documentation](http://nodejs.org/api/fs.html#fs_fs_opensync_path_flags_mode)
for details.

#### `fdRead`

``` purescript
fdRead :: FileDescriptor -> Buffer -> BufferOffset -> BufferLength -> Maybe FilePosition -> Effect ByteCount
```

Read from a file synchronously. See the [Node documentation](http://nodejs.org/api/fs.html#fs_fs_readsync_fd_buffer_offset_length_position)
for details.

#### `fdNext`

``` purescript
fdNext :: FileDescriptor -> Buffer -> Effect ByteCount
```

Convenience function to fill the whole buffer from the current
file position.

#### `fdWrite`

``` purescript
fdWrite :: FileDescriptor -> Buffer -> BufferOffset -> BufferLength -> Maybe FilePosition -> Effect ByteCount
```

Write to a file synchronously. See the [Node documentation](http://nodejs.org/api/fs.html#fs_fs_writesync_fd_buffer_offset_length_position)
for details.

#### `fdAppend`

``` purescript
fdAppend :: FileDescriptor -> Buffer -> Effect ByteCount
```

Convenience function to append the whole buffer to the current
file position.

#### `fdFlush`

``` purescript
fdFlush :: FileDescriptor -> Effect Unit
```

Flush a file synchronously.  See the [Node documentation](http://nodejs.org/api/fs.html#fs_fs_fsyncsync_fd)
for details.

#### `fdClose`

``` purescript
fdClose :: FileDescriptor -> Effect Unit
```

Close a file synchronously. See the [Node documentation](http://nodejs.org/api/fs.html#fs_fs_closesync_fd)
for details.



## Module Node.FS.Aff

#### `access`

``` purescript
access :: String -> Aff (Maybe Error)
```

#### `access'`

``` purescript
access' :: String -> AccessMode -> Aff (Maybe Error)
```

#### `copyFile`

``` purescript
copyFile :: String -> String -> Aff Unit
```

#### `copyFile'`

``` purescript
copyFile' :: String -> String -> CopyMode -> Aff Unit
```

#### `mkdtemp`

``` purescript
mkdtemp :: String -> Aff String
```

#### `mkdtemp'`

``` purescript
mkdtemp' :: String -> Encoding -> Aff String
```

#### `rename`

``` purescript
rename :: FilePath -> FilePath -> Aff Unit
```


Rename a file.


#### `truncate`

``` purescript
truncate :: FilePath -> Int -> Aff Unit
```


Truncates a file to the specified length.


#### `chown`

``` purescript
chown :: FilePath -> Int -> Int -> Aff Unit
```


Changes the ownership of a file.


#### `chmod`

``` purescript
chmod :: FilePath -> Perms -> Aff Unit
```


Changes the permissions of a file.


#### `stat`

``` purescript
stat :: FilePath -> Aff Stats
```


Gets file statistics.


#### `link`

``` purescript
link :: FilePath -> FilePath -> Aff Unit
```


Creates a link to an existing file.


#### `symlink`

``` purescript
symlink :: FilePath -> FilePath -> SymlinkType -> Aff Unit
```


Creates a symlink.


#### `readlink`

``` purescript
readlink :: FilePath -> Aff FilePath
```


Reads the value of a symlink.


#### `realpath`

``` purescript
realpath :: FilePath -> Aff FilePath
```


Find the canonicalized absolute location for a path.


#### `realpath'`

``` purescript
realpath' :: forall cache. FilePath -> Record cache -> Aff FilePath
```


Find the canonicalized absolute location for a path using a cache object
for already resolved paths.


#### `unlink`

``` purescript
unlink :: FilePath -> Aff Unit
```


Deletes a file.


#### `rmdir`

``` purescript
rmdir :: FilePath -> Aff Unit
```


Deletes a directory.


#### `rmdir'`

``` purescript
rmdir' :: FilePath -> { maxRetries :: Int, retryDelay :: Int } -> Aff Unit
```


Deletes a directory with options.


#### `rm`

``` purescript
rm :: FilePath -> Aff Unit
```


Deletes a file or directory.


#### `rm'`

``` purescript
rm' :: FilePath -> { force :: Boolean, maxRetries :: Int, recursive :: Boolean, retryDelay :: Int } -> Aff Unit
```


Deletes a file or directory with options.


#### `mkdir`

``` purescript
mkdir :: FilePath -> Aff Unit
```


Makes a new directory.


#### `mkdir'`

``` purescript
mkdir' :: FilePath -> { mode :: Perms, recursive :: Boolean } -> Aff Unit
```


Makes a new directory with all of its options.


#### `readdir`

``` purescript
readdir :: FilePath -> Aff (Array FilePath)
```


Reads the contents of a directory.


#### `utimes`

``` purescript
utimes :: FilePath -> DateTime -> DateTime -> Aff Unit
```


Sets the accessed and modified times for the specified file.


#### `readFile`

``` purescript
readFile :: FilePath -> Aff Buffer
```


Reads the entire contents of a file returning the result as a raw buffer.


#### `readTextFile`

``` purescript
readTextFile :: Encoding -> FilePath -> Aff String
```


Reads the entire contents of a text file with the specified encoding.


#### `writeFile`

``` purescript
writeFile :: FilePath -> Buffer -> Aff Unit
```


Writes a buffer to a file.


#### `writeTextFile`

``` purescript
writeTextFile :: Encoding -> FilePath -> String -> Aff Unit
```


Writes text to a file using the specified encoding.


#### `appendFile`

``` purescript
appendFile :: FilePath -> Buffer -> Aff Unit
```


Appends the contents of a buffer to a file.


#### `appendTextFile`

``` purescript
appendTextFile :: Encoding -> FilePath -> String -> Aff Unit
```


Appends text to a file using the specified encoding.


#### `fdOpen`

``` purescript
fdOpen :: FilePath -> FileFlags -> Maybe FileMode -> Aff FileDescriptor
```

Open a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_open_path_flags_mode_callback)
for details.

#### `fdRead`

``` purescript
fdRead :: FileDescriptor -> Buffer -> BufferOffset -> BufferLength -> Maybe FilePosition -> Aff ByteCount
```

Read from a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_read_fd_buffer_offset_length_position_callback)
for details.

#### `fdNext`

``` purescript
fdNext :: FileDescriptor -> Buffer -> Aff ByteCount
```

Convenience function to fill the whole buffer from the current
file position.

#### `fdWrite`

``` purescript
fdWrite :: FileDescriptor -> Buffer -> BufferOffset -> BufferLength -> Maybe FilePosition -> Aff ByteCount
```

Write to a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_write_fd_buffer_offset_length_position_callback)
for details.

#### `fdAppend`

``` purescript
fdAppend :: FileDescriptor -> Buffer -> Aff ByteCount
```

Convenience function to append the whole buffer to the current
file position.

#### `fdClose`

``` purescript
fdClose :: FileDescriptor -> Aff Unit
```

Close a file asynchronously. See the [Node Documentation](https://nodejs.org/api/fs.html#fs_fs_close_fd_callback)
for details.



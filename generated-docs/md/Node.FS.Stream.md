## Module Node.FS.Stream

#### `createWriteStream`

``` purescript
createWriteStream :: FilePath -> Effect (Writable ())
```

Create a Writable stream which writes data to the specified file, using
the default options.

#### `fdCreateWriteStream`

``` purescript
fdCreateWriteStream :: FileDescriptor -> Effect (Writable ())
```

Create a Writable stream which writes data to the specified file
descriptor, using the default options.

#### `WriteStreamOptions`

``` purescript
type WriteStreamOptions = { flags :: FileFlags, perms :: Perms }
```

#### `defaultWriteStreamOptions`

``` purescript
defaultWriteStreamOptions :: WriteStreamOptions
```

#### `createWriteStreamWith`

``` purescript
createWriteStreamWith :: WriteStreamOptions -> FilePath -> Effect (Writable ())
```

Like `createWriteStream`, but allows you to pass options.

#### `fdCreateWriteStreamWith`

``` purescript
fdCreateWriteStreamWith :: WriteStreamOptions -> FileDescriptor -> Effect (Writable ())
```

Like `fdCreateWriteStream`, but allows you to pass options.

#### `createReadStream`

``` purescript
createReadStream :: FilePath -> Effect (Readable ())
```

Create a Readable stream which reads data to the specified file, using
the default options.

#### `fdCreateReadStream`

``` purescript
fdCreateReadStream :: FileDescriptor -> Effect (Readable ())
```

Create a Readable stream which reads data to the specified file
descriptor, using the default options.

#### `ReadStreamOptions`

``` purescript
type ReadStreamOptions = { autoClose :: Boolean, flags :: FileFlags, perms :: Perms }
```

#### `defaultReadStreamOptions`

``` purescript
defaultReadStreamOptions :: ReadStreamOptions
```

#### `createReadStreamWith`

``` purescript
createReadStreamWith :: ReadStreamOptions -> FilePath -> Effect (Readable ())
```

Create a Readable stream which reads data from the specified file.

#### `fdCreateReadStreamWith`

``` purescript
fdCreateReadStreamWith :: ReadStreamOptions -> FileDescriptor -> Effect (Readable ())
```

Create a Readable stream which reads data from the specified file descriptor.



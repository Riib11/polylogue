## Module Node.Stream

This module provides a low-level wrapper for the [Node Stream API](https://nodejs.org/api/stream.html).

#### `Stream`

``` purescript
data Stream t0
```

A stream.

The type arguments track, in order:

- Whether reading and/or writing from/to the stream are allowed.
- Effects associated with reading/writing from/to this stream.

#### `Read`

``` purescript
data Read
```

A phantom type associated with _readable streams_.

#### `Readable`

``` purescript
type Readable r = Stream (read :: Read | r)
```

A readable stream.

#### `Write`

``` purescript
data Write
```

A phantom type associated with _writable streams_.

#### `Writable`

``` purescript
type Writable r = Stream (write :: Write | r)
```

A writable stream.

#### `Duplex`

``` purescript
type Duplex = Stream (read :: Read, write :: Write)
```

A duplex (readable _and_ writable stream)

#### `onData`

``` purescript
onData :: forall w. Readable w -> (Buffer -> Effect Unit) -> Effect Unit
```

Listen for `data` events, returning data in a Buffer. Note that this will fail
if `setEncoding` has been called on the stream.

#### `onDataString`

``` purescript
onDataString :: forall w. Readable w -> Encoding -> (String -> Effect Unit) -> Effect Unit
```

Listen for `data` events, returning data in a String, which will be
decoded using the given encoding. Note that this will fail if `setEncoding`
has been called on the stream.

#### `onDataEither`

``` purescript
onDataEither :: forall r. Readable r -> (Either String Buffer -> Effect Unit) -> Effect Unit
```

Listen for `data` events, returning data in an `Either String Buffer`. This
function is provided for the (hopefully rare) case that `setEncoding` has
been called on the stream.

#### `setEncoding`

``` purescript
setEncoding :: forall w. Readable w -> Encoding -> Effect Unit
```

Set the encoding used to read chunks as strings from the stream. This
function may be useful when you are passing a readable stream to some other
JavaScript library, which already expects an encoding to be set.

Where possible, you should try to use `onDataString` instead of this
function.

#### `onReadable`

``` purescript
onReadable :: forall w. Readable w -> Effect Unit -> Effect Unit
```

Listen for `readable` events.

#### `onEnd`

``` purescript
onEnd :: forall w. Readable w -> Effect Unit -> Effect Unit
```

Listen for `end` events.

#### `onFinish`

``` purescript
onFinish :: forall w. Writable w -> Effect Unit -> Effect Unit
```

Listen for `finish` events.

#### `onClose`

``` purescript
onClose :: forall w. Stream w -> Effect Unit -> Effect Unit
```

Listen for `close` events.

#### `onError`

``` purescript
onError :: forall w. Stream w -> (Error -> Effect Unit) -> Effect Unit
```

Listen for `error` events.

#### `resume`

``` purescript
resume :: forall w. Readable w -> Effect Unit
```

Resume reading from the stream.

#### `pause`

``` purescript
pause :: forall w. Readable w -> Effect Unit
```

Pause reading from the stream.

#### `isPaused`

``` purescript
isPaused :: forall w. Readable w -> Effect Boolean
```

Check whether or not a stream is paused for reading.

#### `pipe`

``` purescript
pipe :: forall r w. Readable w -> Writable r -> Effect (Writable r)
```

Read chunks from a readable stream and write them to a writable stream.

#### `unpipe`

``` purescript
unpipe :: forall r w. Readable w -> Writable r -> Effect Unit
```

Detach a Writable stream previously attached using `pipe`.

#### `unpipeAll`

``` purescript
unpipeAll :: forall w. Readable w -> Effect Unit
```

Detach all Writable streams previously attached using `pipe`.

#### `read`

``` purescript
read :: forall w. Readable w -> Maybe Int -> Effect (Maybe Buffer)
```

#### `readString`

``` purescript
readString :: forall w. Readable w -> Maybe Int -> Encoding -> Effect (Maybe String)
```

#### `readEither`

``` purescript
readEither :: forall w. Readable w -> Maybe Int -> Effect (Maybe (Either String Buffer))
```

#### `write`

``` purescript
write :: forall r. Writable r -> Buffer -> (Maybe Error -> Effect Unit) -> Effect Boolean
```

Write a Buffer to a writable stream.

#### `writeString`

``` purescript
writeString :: forall r. Writable r -> Encoding -> String -> (Maybe Error -> Effect Unit) -> Effect Boolean
```

Write a string in the specified encoding to a writable stream.

#### `cork`

``` purescript
cork :: forall r. Writable r -> Effect Unit
```

Force buffering of writes.

#### `uncork`

``` purescript
uncork :: forall r. Writable r -> Effect Unit
```

Flush buffered data.

#### `setDefaultEncoding`

``` purescript
setDefaultEncoding :: forall r. Writable r -> Encoding -> Effect Unit
```

Set the default encoding used to write strings to the stream. This function
is useful when you are passing a writable stream to some other JavaScript
library, which already expects a default encoding to be set. It has no
effect on the behaviour of the `writeString` function (because that
function ensures that the encoding is always supplied explicitly).

#### `end`

``` purescript
end :: forall r. Writable r -> (Maybe Error -> Effect Unit) -> Effect Unit
```

End writing data to the stream.

#### `destroy`

``` purescript
destroy :: forall r. Stream r -> Effect Unit
```

Destroy the stream. It will release any internal resources.

#### `destroyWithError`

``` purescript
destroyWithError :: forall r. Stream r -> Error -> Effect Unit
```

Destroy the stream and emit 'error'.



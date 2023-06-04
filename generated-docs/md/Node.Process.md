## Module Node.Process

Bindings to the global `process` object in Node.js. See also [the Node API documentation](https://nodejs.org/api/process.html)

#### `onBeforeExit`

``` purescript
onBeforeExit :: Effect Unit -> Effect Unit
```

Register a callback to be performed when the event loop empties, and
Node.js is about to exit. Asynchronous calls can be made in the callback,
and if any are made, it will cause the process to continue a little longer.

#### `onExit`

``` purescript
onExit :: (Int -> Effect Unit) -> Effect Unit
```

Register a callback to be performed when the process is about to exit.
Any work scheduled via asynchronous calls made here will not be performed
in time.

The argument to the callback is the exit code which the process is about
to exit with.

#### `onSignal`

``` purescript
onSignal :: Signal -> Effect Unit -> Effect Unit
```

Install a handler for a particular signal.

#### `onUncaughtException`

``` purescript
onUncaughtException :: (Error -> Effect Unit) -> Effect Unit
```

Install a handler for uncaught exceptions. The callback will be called
when the process emits the `uncaughtException` event. The handler
currently does not expose the second `origin` argument from the Node 12
version of this event to maintain compatibility with older Node versions.

#### `onUnhandledRejection`

``` purescript
onUnhandledRejection :: forall a b. (a -> b -> Effect Unit) -> Effect Unit
```

Install a handler for unhandled promise rejections. The callback will be
called when the process emits the `unhandledRejection` event.

The first argument to the handler can be whatever type the unhandled
Promise yielded on rejection (typically, but not necessarily, an `Error`).

The handler currently does not expose the type of the second argument,
which is a `Promise`, in order to allow users of this library to choose
their own PureScript `Promise` bindings.

#### `nextTick`

``` purescript
nextTick :: Effect Unit -> Effect Unit
```

Register a callback to run as soon as the current event loop runs to
completion.

#### `argv`

``` purescript
argv :: Effect (Array String)
```

Get an array containing the command line arguments.

#### `execArgv`

``` purescript
execArgv :: Effect (Array String)
```

Node-specific options passed to the `node` executable.

#### `execPath`

``` purescript
execPath :: Effect String
```

The absolute pathname of the `node` executable that started the
process.

#### `chdir`

``` purescript
chdir :: String -> Effect Unit
```

Change the current working directory of the process. If the current
directory could not be changed, an exception will be thrown.

#### `cwd`

``` purescript
cwd :: Effect String
```

Get the current working directory of the process.

#### `getEnv`

``` purescript
getEnv :: Effect (Object String)
```

Get a copy of the current environment.

#### `lookupEnv`

``` purescript
lookupEnv :: String -> Effect (Maybe String)
```

Lookup a particular environment variable.

#### `setEnv`

``` purescript
setEnv :: String -> String -> Effect Unit
```

Set an environment variable.

#### `unsetEnv`

``` purescript
unsetEnv :: String -> Effect Unit
```

Delete an environment variable.
Use case: to hide secret environment variable from child processes.

#### `pid`

``` purescript
pid :: Pid
```

#### `platform`

``` purescript
platform :: Maybe Platform
```

#### `exit`

``` purescript
exit :: forall a. Int -> Effect a
```

Cause the process to exit with the supplied integer code. An exit code
of 0 is normally considered successful, and anything else is considered a
failure.

#### `stdin`

``` purescript
stdin :: Readable ()
```

The standard input stream. Note that this stream will never emit an `end`
event, so any handlers attached via `onEnd` will never be called.

#### `stdout`

``` purescript
stdout :: Writable ()
```

The standard output stream. Note that this stream cannot be closed; calling
`end` will result in an exception being thrown.

#### `stderr`

``` purescript
stderr :: Writable ()
```

The standard error stream. Note that this stream cannot be closed; calling
`end` will result in an exception being thrown.

#### `stdinIsTTY`

``` purescript
stdinIsTTY :: Boolean
```

Check whether the standard input stream appears to be attached to a TTY.
It is a good idea to check this before processing the input data from stdin.

#### `stdoutIsTTY`

``` purescript
stdoutIsTTY :: Boolean
```

Check whether the standard output stream appears to be attached to a TTY.
It is a good idea to check this before printing ANSI codes to stdout
(e.g. for coloured text in the terminal).

#### `stderrIsTTY`

``` purescript
stderrIsTTY :: Boolean
```

Check whether the standard error stream appears to be attached to a TTY.
It is a good idea to check this before printing ANSI codes to stderr
(e.g. for coloured text in the terminal).

#### `version`

``` purescript
version :: String
```

Get the Node.js version.



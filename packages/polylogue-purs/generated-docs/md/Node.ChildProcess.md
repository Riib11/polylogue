## Module Node.ChildProcess

This module contains various types and functions to allow you to spawn and
interact with child processes.

It is intended to be imported qualified, as follows:

```purescript
import Node.ChildProcess (ChildProcess, CHILD_PROCESS)
import Node.ChildProcess as ChildProcess
```

The [Node.js documentation](https://nodejs.org/api/child_process.html)
forms the basis for this module and has in-depth documentation about
runtime behaviour.

#### `Handle`

``` purescript
data Handle
```

A handle for inter-process communication (IPC).

#### `ChildProcess`

``` purescript
newtype ChildProcess
```

Opaque type returned by `spawn`, `fork` and `exec`.
Needed as input for most methods in this module.

#### `stdin`

``` purescript
stdin :: ChildProcess -> Writable ()
```

The standard input stream of a child process. Note that this is only
available if the process was spawned with the stdin option set to "pipe".

#### `stdout`

``` purescript
stdout :: ChildProcess -> Readable ()
```

The standard output stream of a child process. Note that this is only
available if the process was spawned with the stdout option set to "pipe".

#### `stderr`

``` purescript
stderr :: ChildProcess -> Readable ()
```

The standard error stream of a child process. Note that this is only
available if the process was spawned with the stderr option set to "pipe".

#### `pid`

``` purescript
pid :: ChildProcess -> Pid
```

The process ID of a child process. Note that if the process has already
exited, another process may have taken the same ID, so be careful!

#### `connected`

``` purescript
connected :: ChildProcess -> Effect Boolean
```

Indicates whether it is still possible to send and receive
messages from the child process.

#### `kill`

``` purescript
kill :: Signal -> ChildProcess -> Effect Unit
```

Send a signal to a child process. In the same way as the
[unix kill(2) system call](https://linux.die.net/man/2/kill),
sending a signal to a child process won't necessarily kill it.

The resulting effects of this function depend on the process
and the signal. They can vary from system to system.
The child process might emit an `"error"` event if the signal
could not be delivered.

#### `send`

``` purescript
send :: forall props. Record props -> Handle -> ChildProcess -> Effect Boolean
```

Send messages to the (`nodejs`) child process.

See the [node documentation](https://nodejs.org/api/child_process.html#child_process_subprocess_send_message_sendhandle_options_callback)
for in-depth documentation.

#### `disconnect`

``` purescript
disconnect :: ChildProcess -> Effect Unit
```

Closes the IPC channel between parent and child.

#### `Error`

``` purescript
type Error = { code :: String, errno :: String, syscall :: String }
```

An error which occurred inside a child process.

#### `toStandardError`

``` purescript
toStandardError :: Error -> Error
```

Convert a ChildProcess.Error to a standard Error, which can then be thrown
inside an Effect or Aff computation (for example).

#### `Exit`

``` purescript
data Exit
  = Normally Int
  | BySignal Signal
```

Specifies how a child process exited; normally (with an exit code), or
due to a signal.

##### Instances
``` purescript
Show Exit
```

#### `onExit`

``` purescript
onExit :: ChildProcess -> (Exit -> Effect Unit) -> Effect Unit
```

Handle the `"exit"` signal.

#### `onClose`

``` purescript
onClose :: ChildProcess -> (Exit -> Effect Unit) -> Effect Unit
```

Handle the `"close"` signal.

#### `onDisconnect`

``` purescript
onDisconnect :: ChildProcess -> Effect Unit -> Effect Unit
```

Handle the `"disconnect"` signal.

#### `onMessage`

``` purescript
onMessage :: ChildProcess -> (Foreign -> Maybe Handle -> Effect Unit) -> Effect Unit
```

Handle the `"message"` signal.

#### `onError`

``` purescript
onError :: ChildProcess -> (Error -> Effect Unit) -> Effect Unit
```

Handle the `"error"` signal.

#### `spawn`

``` purescript
spawn :: String -> Array String -> SpawnOptions -> Effect ChildProcess
```

Spawn a child process. Note that, in the event that a child process could
not be spawned (for example, if the executable was not found) this will
not throw an error. Instead, the `ChildProcess` will be created anyway,
but it will immediately emit an 'error' event.

#### `SpawnOptions`

``` purescript
type SpawnOptions = { cwd :: Maybe String, detached :: Boolean, env :: Maybe (Object String), gid :: Maybe Gid, stdio :: Array (Maybe StdIOBehaviour), uid :: Maybe Uid }
```

Configuration of `spawn`. Fields set to `Nothing` will use
the node defaults.

#### `defaultSpawnOptions`

``` purescript
defaultSpawnOptions :: SpawnOptions
```

A default set of `SpawnOptions`. Everything is set to `Nothing`,
`detached` is `false` and `stdio` is `ChildProcess.pipe`.

#### `exec`

``` purescript
exec :: String -> ExecOptions -> (ExecResult -> Effect Unit) -> Effect ChildProcess
```

Similar to `spawn`, except that this variant will:
* run the given command with the shell,
* buffer output, and wait until the process has exited before calling the
  callback.

Note that the child process will be killed if the amount of output exceeds
a certain threshold (the default is defined by Node.js).

#### `execFile`

``` purescript
execFile :: String -> Array String -> ExecOptions -> (ExecResult -> Effect Unit) -> Effect ChildProcess
```

Like `exec`, except instead of using a shell, it passes the arguments
directly to the specified command.

#### `ExecOptions`

``` purescript
type ExecOptions = { cwd :: Maybe String, encoding :: Maybe Encoding, env :: Maybe (Object String), gid :: Maybe Gid, killSignal :: Maybe Signal, maxBuffer :: Maybe Int, shell :: Maybe String, timeout :: Maybe Number, uid :: Maybe Uid }
```

Configuration of `exec`. Fields set to `Nothing`
will use the node defaults.

#### `ExecResult`

``` purescript
type ExecResult = { error :: Maybe Error, stderr :: Buffer, stdout :: Buffer }
```

The combined output of a process calld with `exec`.

#### `defaultExecOptions`

``` purescript
defaultExecOptions :: ExecOptions
```

A default set of `ExecOptions`. Everything is set to `Nothing`.

#### `execSync`

``` purescript
execSync :: String -> ExecSyncOptions -> Effect Buffer
```

Generally identical to `exec`, with the exception that
the method will not return until the child process has fully closed.
Returns: The stdout from the command.

#### `execFileSync`

``` purescript
execFileSync :: String -> Array String -> ExecSyncOptions -> Effect Buffer
```

Generally identical to `execFile`, with the exception that
the method will not return until the child process has fully closed.
Returns: The stdout from the command.

#### `ExecSyncOptions`

``` purescript
type ExecSyncOptions = { cwd :: Maybe String, env :: Maybe (Object String), gid :: Maybe Gid, input :: Maybe String, killSignal :: Maybe Signal, maxBuffer :: Maybe Int, stdio :: Array (Maybe StdIOBehaviour), timeout :: Maybe Number, uid :: Maybe Uid }
```

#### `defaultExecSyncOptions`

``` purescript
defaultExecSyncOptions :: ExecSyncOptions
```

#### `fork`

``` purescript
fork :: String -> Array String -> Effect ChildProcess
```

A special case of `spawn` for creating Node.js child processes. The first
argument is the module to be run, and the second is the argv (command line
arguments).

#### `StdIOBehaviour`

``` purescript
data StdIOBehaviour
  = Pipe
  | Ignore
  | ShareStream (forall r. Stream r)
  | ShareFD FileDescriptor
```

Behaviour for standard IO streams (eg, standard input, standard output) of
a child process.

* `Pipe`: creates a pipe between the child and parent process, which can
  then be accessed as a `Stream` via the `stdin`, `stdout`, or `stderr`
  functions.
* `Ignore`: ignore this stream. This will cause Node to open /dev/null and
  connect it to the stream.
* `ShareStream`: Connect the supplied stream to the corresponding file
   descriptor in the child.
* `ShareFD`: Connect the supplied file descriptor (which should be open
  in the parent) to the corresponding file descriptor in the child.

#### `pipe`

``` purescript
pipe :: Array (Maybe StdIOBehaviour)
```

Create pipes for each of the three standard IO streams.

#### `inherit`

``` purescript
inherit :: Array (Maybe StdIOBehaviour)
```

Share `stdin` with `stdin`, `stdout` with `stdout`,
and `stderr` with `stderr`.

#### `ignore`

``` purescript
ignore :: Array (Maybe StdIOBehaviour)
```

Ignore all streams.



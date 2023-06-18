## Module Dotenv.Internal.ChildProcess

This module encapsulates the logic for running a child process.

#### `CHILD_PROCESS`

``` purescript
type CHILD_PROCESS r = (childProcess :: ChildProcessF | r)
```

The effect type used for a child process

#### `ChildProcessF`

``` purescript
data ChildProcessF a
  = Spawn String (Array String) (String -> a)
```

A data type representing the supported operations

##### Instances
``` purescript
Functor ChildProcessF
```

#### `_childProcess`

``` purescript
_childProcess :: Proxy @Symbol "childProcess"
```

The effect label used for a child process

#### `handleChildProcess`

``` purescript
handleChildProcess :: ChildProcessF ~> Aff
```

The default interpreter for handling a child process

#### `spawn`

``` purescript
spawn :: forall r. String -> Array String -> Run (CHILD_PROCESS r) String
```

Constructs the value used to spawn a child process.



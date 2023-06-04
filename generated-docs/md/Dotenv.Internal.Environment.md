## Module Dotenv.Internal.Environment

This module encapsulates the logic for reading or modifying the environment.

#### `ENVIRONMENT`

``` purescript
type ENVIRONMENT r = (environment :: EnvironmentF | r)
```

The effect type used for reading or modifying the environment

#### `EnvironmentF`

``` purescript
data EnvironmentF a
  = LookupEnv String (Maybe String -> a)
  | SetEnv String String a
```

A data type representing the supported operations.

##### Instances
``` purescript
Functor EnvironmentF
```

#### `_environment`

``` purescript
_environment :: Proxy @Symbol "environment"
```

#### `handleEnvironment`

``` purescript
handleEnvironment :: EnvironmentF ~> Aff
```

The default interpreter used for reading or modifying the environment

#### `lookupEnv`

``` purescript
lookupEnv :: forall r. String -> Run (ENVIRONMENT r) (Maybe String)
```

Constructs the value used to look up an environment variable.

#### `setEnv`

``` purescript
setEnv :: forall r. String -> String -> Run (ENVIRONMENT r) Unit
```

Constructs the value used to set an environment variable.



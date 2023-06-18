## Module Test.Spec.Runner

#### `run`

``` purescript
run :: Warn (Text "`Test.Spec.Runner.run` is Deprecated use runSpec instead") => Array Reporter -> Spec Unit -> Aff Unit
```

Run the spec with the default config

#### `runSpecT`

``` purescript
runSpecT :: forall m. Functor m => Config -> Array Reporter -> SpecT Aff Unit m Unit -> m (Aff (Array (Tree Void Result)))
```

Run the spec with `config`, returning the results, which
are also reported using specified Reporters, if any.
If configured as such, `exit` the program upon completion
with appropriate exit code.

#### `runSpec`

``` purescript
runSpec :: Array Reporter -> Spec Unit -> Aff Unit
```

Run the spec with the default config

#### `runSpec'`

``` purescript
runSpec' :: Config -> Array Reporter -> Spec Unit -> Aff Unit
```

#### `defaultConfig`

``` purescript
defaultConfig :: Config
```

#### `Config`

``` purescript
type Config = { exit :: Boolean, slow :: Milliseconds, timeout :: Maybe Milliseconds }
```

#### `TestEvents`

``` purescript
type TestEvents = Producer Event Aff (Array (Tree Void Result))
```

#### `Reporter`

``` purescript
type Reporter = Pipe Event Event Aff (Array (Tree Void Result))
```



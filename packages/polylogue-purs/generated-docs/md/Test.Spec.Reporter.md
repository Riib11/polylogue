## Module Test.Spec.Reporter


### Re-exported from Test.Spec.Reporter.Base:

#### `RunningItem`

``` purescript
data RunningItem
  = RunningTest String (Maybe Result)
  | RunningPending String
  | RunningSuite String Boolean
```

##### Instances
``` purescript
Generic RunningItem _
Show RunningItem
```

#### `defaultUpdate`

``` purescript
defaultUpdate :: forall s. { getRunningItems :: s -> Map Path RunningItem, printFinishedItem :: Path -> RunningItem -> StateT s (Writer String) Unit, putRunningItems :: Map Path RunningItem -> s -> s, update :: Event -> StateT s (Writer String) Unit } -> (Event -> StateT s (Writer String) Unit)
```

#### `defaultSummary`

``` purescript
defaultSummary :: forall m. MonadWriter String m => Array (Tree Void Result) -> m Unit
```

#### `defaultReporter`

``` purescript
defaultReporter :: forall s. s -> (Event -> StateT s (Writer String) Unit) -> Reporter
```

A default reporter implementation that can be used as a base to build
other reporters on top of.

### Re-exported from Test.Spec.Reporter.Console:

#### `consoleReporter`

``` purescript
consoleReporter :: Reporter
```

### Re-exported from Test.Spec.Reporter.Dot:

#### `dotReporter`

``` purescript
dotReporter :: DotReporterConfig -> Reporter
```

### Re-exported from Test.Spec.Reporter.Spec:

#### `specReporter`

``` purescript
specReporter :: Reporter
```


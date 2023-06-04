## Module Test.Spec.Runner.Event

#### `Name`

``` purescript
type Name = String
```

#### `NumberOfTests`

``` purescript
type NumberOfTests = Int
```

#### `Execution`

``` purescript
data Execution
  = Parallel
  | Sequential
```

##### Instances
``` purescript
Show Execution
```

#### `Event`

``` purescript
data Event
  = Start NumberOfTests
  | Suite Execution Path Name
  | SuiteEnd Path
  | Test Execution Path Name
  | TestEnd Path Name Result
  | Pending Path Name
  | End (Array (Tree Void Result))
```

##### Instances
``` purescript
Show Event
```



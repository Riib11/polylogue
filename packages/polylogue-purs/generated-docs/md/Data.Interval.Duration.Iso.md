## Module Data.Interval.Duration.Iso

#### `IsoDuration`

``` purescript
newtype IsoDuration
```

##### Instances
``` purescript
Eq IsoDuration
Ord IsoDuration
Show IsoDuration
```

#### `unIsoDuration`

``` purescript
unIsoDuration :: IsoDuration -> Duration
```

#### `mkIsoDuration`

``` purescript
mkIsoDuration :: Duration -> Either Errors IsoDuration
```

#### `Error`

``` purescript
data Error
  = IsEmpty
  | InvalidWeekComponentUsage
  | ContainsNegativeValue DurationComponent
  | InvalidFractionalUse DurationComponent
```

##### Instances
``` purescript
Eq Error
Ord Error
Show Error
```

#### `Errors`

``` purescript
type Errors = NonEmptyList Error
```

#### `prettyError`

``` purescript
prettyError :: Error -> String
```



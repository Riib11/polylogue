## Module Data.Time.Duration

#### `Milliseconds`

``` purescript
newtype Milliseconds
  = Milliseconds Number
```

A duration measured in milliseconds.

##### Instances
``` purescript
Newtype Milliseconds _
Eq Milliseconds
Ord Milliseconds
Semigroup Milliseconds
Monoid Milliseconds
Show Milliseconds
Duration Milliseconds
```

#### `Seconds`

``` purescript
newtype Seconds
  = Seconds Number
```

A duration measured in seconds.

##### Instances
``` purescript
Newtype Seconds _
Eq Seconds
Ord Seconds
Semigroup Seconds
Monoid Seconds
Show Seconds
Duration Seconds
```

#### `Minutes`

``` purescript
newtype Minutes
  = Minutes Number
```

A duration measured in minutes.

##### Instances
``` purescript
Newtype Minutes _
Eq Minutes
Ord Minutes
Semigroup Minutes
Monoid Minutes
Show Minutes
Duration Minutes
```

#### `Hours`

``` purescript
newtype Hours
  = Hours Number
```

A duration measured in hours.

##### Instances
``` purescript
Newtype Hours _
Eq Hours
Ord Hours
Semigroup Hours
Monoid Hours
Show Hours
Duration Hours
```

#### `Days`

``` purescript
newtype Days
  = Days Number
```

A duration measured in days, where a day is assumed to be exactly 24 hours.

##### Instances
``` purescript
Newtype Days _
Eq Days
Ord Days
Semigroup Days
Monoid Days
Show Days
Duration Days
```

#### `Duration`

``` purescript
class Duration a  where
  fromDuration :: a -> Milliseconds
  toDuration :: Milliseconds -> a
```

A class for enabling conversions between duration types.

##### Instances
``` purescript
Duration Milliseconds
Duration Seconds
Duration Minutes
Duration Hours
Duration Days
```

#### `convertDuration`

``` purescript
convertDuration :: forall a b. Duration a => Duration b => a -> b
```

Converts directly between durations of differing types.

#### `negateDuration`

``` purescript
negateDuration :: forall a. Duration a => a -> a
```

Negates a duration, turning a positive duration negative or a negative
duration positive.



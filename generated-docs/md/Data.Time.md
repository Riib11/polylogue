## Module Data.Time

#### `Time`

``` purescript
data Time
  = Time Hour Minute Second Millisecond
```

##### Instances
``` purescript
Eq Time
Ord Time
Bounded Time
Show Time
```

#### `hour`

``` purescript
hour :: Time -> Hour
```

The hour component of a time value.

#### `setHour`

``` purescript
setHour :: Hour -> Time -> Time
```

Alters the hour component of a time value.

#### `minute`

``` purescript
minute :: Time -> Minute
```

The minute component of a time value.

#### `setMinute`

``` purescript
setMinute :: Minute -> Time -> Time
```

Alters the minute component of a time value.

#### `second`

``` purescript
second :: Time -> Second
```

The second component of a time value.

#### `setSecond`

``` purescript
setSecond :: Second -> Time -> Time
```

Alters the second component of a time value.

#### `millisecond`

``` purescript
millisecond :: Time -> Millisecond
```

The millisecond component of a time value.

#### `setMillisecond`

``` purescript
setMillisecond :: Millisecond -> Time -> Time
```

Alters the millisecond component of a time value.

#### `adjust`

``` purescript
adjust :: forall d. Duration d => d -> Time -> Tuple Days Time
```

Adjusts a time value with a duration offset. The result includes a
remainder value of the whole number of days involved in the adjustment,
for example, if a time of 23:00:00:00 has a duration of +2 hours added to
it, the result will be 1 day, and 01:00:00:00. Correspondingly, if the
duration is negative, a negative number of days may also be returned as
the remainder.

#### `diff`

``` purescript
diff :: forall d. Duration d => Time -> Time -> d
```

Calculates the difference between two times, returning the result as a
duration.


### Re-exported from Data.Time.Component:

#### `Second`

``` purescript
newtype Second
```

An second component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 59, inclusive. The `toEnum` function can be used to safely
acquire an `Second` value from an integer. Correspondingly, a `Second` can
be lowered to a plain integer with the `fromEnum` function.

##### Instances
``` purescript
Eq Second
Ord Second
Bounded Second
Enum Second
BoundedEnum Second
Show Second
```

#### `Minute`

``` purescript
newtype Minute
```

An minute component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 59, inclusive. The `toEnum` function can be used to safely
acquire an `Minute` value from an integer. Correspondingly, a `Minute` can
be lowered to a plain integer with the `fromEnum` function.

##### Instances
``` purescript
Eq Minute
Ord Minute
Bounded Minute
Enum Minute
BoundedEnum Minute
Show Minute
```

#### `Millisecond`

``` purescript
newtype Millisecond
```

An millisecond component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 999, inclusive. The `toEnum` function can be used to safely
acquire an `Millisecond` value from an integer. Correspondingly, a
`Millisecond` can be lowered to a plain integer with the `fromEnum`
function.

##### Instances
``` purescript
Eq Millisecond
Ord Millisecond
Bounded Millisecond
Enum Millisecond
BoundedEnum Millisecond
Show Millisecond
```

#### `Hour`

``` purescript
newtype Hour
```

An hour component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 23, inclusive. The `toEnum` function can be used to safely
acquire an `Hour` value from an integer. Correspondingly, an `Hour` can be
lowered to a plain integer with the `fromEnum` function.

##### Instances
``` purescript
Eq Hour
Ord Hour
Bounded Hour
Enum Hour
BoundedEnum Hour
Show Hour
```


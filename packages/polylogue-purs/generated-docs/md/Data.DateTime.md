## Module Data.DateTime

#### `DateTime`

``` purescript
data DateTime
  = DateTime Date Time
```

A date/time value in the Gregorian calendar/UTC time zone.

##### Instances
``` purescript
Eq DateTime
Ord DateTime
Bounded DateTime
Show DateTime
```

#### `date`

``` purescript
date :: DateTime -> Date
```

#### `modifyDate`

``` purescript
modifyDate :: (Date -> Date) -> DateTime -> DateTime
```

#### `modifyDateF`

``` purescript
modifyDateF :: forall f. Functor f => (Date -> f Date) -> DateTime -> f DateTime
```

#### `time`

``` purescript
time :: DateTime -> Time
```

#### `modifyTime`

``` purescript
modifyTime :: (Time -> Time) -> DateTime -> DateTime
```

#### `modifyTimeF`

``` purescript
modifyTimeF :: forall f. Functor f => (Time -> f Time) -> DateTime -> f DateTime
```

#### `adjust`

``` purescript
adjust :: forall d. Duration d => d -> DateTime -> Maybe DateTime
```

Adjusts a date/time value with a duration offset. `Nothing` is returned
if the resulting date would be outside of the range of valid dates.

#### `diff`

``` purescript
diff :: forall d. Duration d => DateTime -> DateTime -> d
```

Calculates the difference between two date/time values, returning the
result as a duration.


### Re-exported from Data.Date:

#### `Year`

``` purescript
newtype Year
```

A year component for a date.

The constructor is private as the `Year` type is bounded to the range
-271820 to 275759, inclusive. The `toEnum` function can be used to safely
acquire a year value from an integer.

##### Instances
``` purescript
Eq Year
Ord Year
Bounded Year
Enum Year
BoundedEnum Year
Show Year
```

#### `Weekday`

``` purescript
data Weekday
  = Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  | Sunday
```

A type representing the days of the week in the Gregorian calendar.

##### Instances
``` purescript
Eq Weekday
Ord Weekday
Bounded Weekday
Enum Weekday
BoundedEnum Weekday
Show Weekday
```

#### `Month`

``` purescript
data Month
  = January
  | February
  | March
  | April
  | May
  | June
  | July
  | August
  | September
  | October
  | November
  | December
```

A month component for a date in the Gregorian calendar.

##### Instances
``` purescript
Eq Month
Ord Month
Bounded Month
Enum Month
BoundedEnum Month
Show Month
```

#### `Day`

``` purescript
newtype Day
```

A day component for a date.

The constructor is private as the `Day` type is bounded to the range
1 to 31, inclusive. The `toEnum` function can be used to safely
acquire a day value from an integer.

##### Instances
``` purescript
Eq Day
Ord Day
Bounded Day
Enum Day
BoundedEnum Day
Show Day
```

#### `Date`

``` purescript
data Date
```

A date value in the Gregorian calendar.

##### Instances
``` purescript
Eq Date
Ord Date
Bounded Date
Show Date
Enum Date
```

#### `year`

``` purescript
year :: Date -> Year
```

The year component of a date value.

#### `weekday`

``` purescript
weekday :: Date -> Weekday
```

The weekday for a date value.

#### `month`

``` purescript
month :: Date -> Month
```

The month component of a date value.

#### `exactDate`

``` purescript
exactDate :: Year -> Month -> Day -> Maybe Date
```

Constructs a date from year, month, and day components. The result will be
`Nothing` if the provided values result in an invalid date.

#### `day`

``` purescript
day :: Date -> Day
```

The day component of a date value.

#### `canonicalDate`

``` purescript
canonicalDate :: Year -> Month -> Day -> Date
```

Constructs a date from year, month, and day components. The resulting date
components may not be identical to the input values, as the date will be
canonicalised according to the Gregorian calendar. For example, date
values for the invalid date 2016-02-31 will be corrected to 2016-03-02.

### Re-exported from Data.Time:

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

#### `setSecond`

``` purescript
setSecond :: Second -> Time -> Time
```

Alters the second component of a time value.

#### `setMinute`

``` purescript
setMinute :: Minute -> Time -> Time
```

Alters the minute component of a time value.

#### `setMillisecond`

``` purescript
setMillisecond :: Millisecond -> Time -> Time
```

Alters the millisecond component of a time value.

#### `setHour`

``` purescript
setHour :: Hour -> Time -> Time
```

Alters the hour component of a time value.

#### `second`

``` purescript
second :: Time -> Second
```

The second component of a time value.

#### `minute`

``` purescript
minute :: Time -> Minute
```

The minute component of a time value.

#### `millisecond`

``` purescript
millisecond :: Time -> Millisecond
```

The millisecond component of a time value.

#### `hour`

``` purescript
hour :: Time -> Hour
```

The hour component of a time value.


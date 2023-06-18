## Module Data.Date

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

#### `canonicalDate`

``` purescript
canonicalDate :: Year -> Month -> Day -> Date
```

Constructs a date from year, month, and day components. The resulting date
components may not be identical to the input values, as the date will be
canonicalised according to the Gregorian calendar. For example, date
values for the invalid date 2016-02-31 will be corrected to 2016-03-02.

#### `exactDate`

``` purescript
exactDate :: Year -> Month -> Day -> Maybe Date
```

Constructs a date from year, month, and day components. The result will be
`Nothing` if the provided values result in an invalid date.

#### `year`

``` purescript
year :: Date -> Year
```

The year component of a date value.

#### `month`

``` purescript
month :: Date -> Month
```

The month component of a date value.

#### `day`

``` purescript
day :: Date -> Day
```

The day component of a date value.

#### `weekday`

``` purescript
weekday :: Date -> Weekday
```

The weekday for a date value.

#### `diff`

``` purescript
diff :: forall d. Duration d => Date -> Date -> d
```

Calculates the difference between two dates, returning the result as a
duration.

#### `isLeapYear`

``` purescript
isLeapYear :: Year -> Boolean
```

Checks whether a year is a leap year according to the proleptic Gregorian
calendar.

#### `lastDayOfMonth`

``` purescript
lastDayOfMonth :: Year -> Month -> Day
```

Get the final day of a month and year, accounting for leap years.

#### `adjust`

``` purescript
adjust :: Days -> Date -> Maybe Date
```

Adjusts a date with a Duration in days. The number of days must
already be an integer and fall within the valid range of values
for the Int type.


### Re-exported from Data.Date.Component:

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


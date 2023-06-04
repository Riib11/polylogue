## Module Data.Date.Component

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



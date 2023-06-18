## Module Data.JSDate

A module providing a type and operations for the native JavaScript `Date`
object.

The `JSDate` type and associated functions are provided for interop
purposes with JavaScript, but for working with dates in PureScript it is
recommended that `DateTime` representation is used instead - `DateTime`
offers greater type safety, a more PureScript-friendly interface, and has
a `Generic` instance.

#### `JSDate`

``` purescript
data JSDate
```

The type of JavaScript `Date` objects.

##### Instances
``` purescript
Eq JSDate
Ord JSDate
Show JSDate
```

#### `readDate`

``` purescript
readDate :: Foreign -> F JSDate
```

Attempts to read a `Foreign` value as a `JSDate`.

#### `isValid`

``` purescript
isValid :: JSDate -> Boolean
```

Checks whether a date value is valid. When a date is invalid, the majority
of the functions return `NaN`, `"Invalid Date"`, or throw an exception.

#### `fromDateTime`

``` purescript
fromDateTime :: DateTime -> JSDate
```

Converts a `DateTime` value into a native JavaScript date object. The
resulting date value is guaranteed to be valid.

#### `toDateTime`

``` purescript
toDateTime :: JSDate -> Maybe DateTime
```

Attempts to construct a `DateTime` value for a `JSDate`. `Nothing` is
returned only when the date value is an invalid date.

#### `toDate`

``` purescript
toDate :: JSDate -> Maybe Date
```

Attempts to construct a `Date` value for a `JSDate`, ignoring any time
component of the `JSDate`. `Nothing` is returned only when the date value
is an invalid date.

#### `fromInstant`

``` purescript
fromInstant :: Instant -> JSDate
```

Creates a `JSDate` from an `Instant` value.

#### `toInstant`

``` purescript
toInstant :: JSDate -> Maybe Instant
```

Attempts to construct an `Instant` for a `JSDate`. `Nothing` is returned
only when the date value is an invalid date.

#### `jsdate`

``` purescript
jsdate :: { day :: Number, hour :: Number, millisecond :: Number, minute :: Number, month :: Number, second :: Number, year :: Number } -> JSDate
```

Constructs a new `JSDate` from UTC component values. If any of the values
are `NaN` the resulting date will be invalid.

#### `jsdateLocal`

``` purescript
jsdateLocal :: { day :: Number, hour :: Number, millisecond :: Number, minute :: Number, month :: Number, second :: Number, year :: Number } -> Effect JSDate
```

Constructs a new `JSDate` from component values using the current machine's
locale. If any of the values are `NaN` the resulting date will be invalid.

#### `now`

``` purescript
now :: Effect JSDate
```

Gets a `JSDate` value for the date and time according to the current
machine's clock.

Unless a `JSDate` is required specifically, consider using the functions in
`Effect.Now` instead.

#### `parse`

``` purescript
parse :: String -> Effect JSDate
```

Attempts to parse a date from a string. The behavior of this function is
implementation specific until ES5, so may not always have the same
behavior for a given string. For this reason, it is **strongly** encouraged
that you avoid this function if at all possible.

If you must use it, the RFC2822 and ISO8601 date string formats should
parse consistently.

This function is effectful because if no time zone is specified in the
string the current locale's time zone will be used instead.

#### `getTime`

``` purescript
getTime :: JSDate -> Number
```

Returns the date as a number of milliseconds since 1970-01-01 00:00:00 UTC.

#### `getUTCDate`

``` purescript
getUTCDate :: JSDate -> Number
```

Returns the day of the month for a date, according to UTC.

#### `getUTCDay`

``` purescript
getUTCDay :: JSDate -> Number
```

Returns the day of the week for a date, according to UTC.

#### `getUTCFullYear`

``` purescript
getUTCFullYear :: JSDate -> Number
```

Returns the year for a date, according to UTC.

#### `getUTCHours`

``` purescript
getUTCHours :: JSDate -> Number
```

Returns the hours for a date, according to UTC.

#### `getUTCMilliseconds`

``` purescript
getUTCMilliseconds :: JSDate -> Number
```

Returns the milliseconds for a date, according to UTC.

#### `getUTCMinutes`

``` purescript
getUTCMinutes :: JSDate -> Number
```

Returns the minutes for a date, according to UTC.

#### `getUTCMonth`

``` purescript
getUTCMonth :: JSDate -> Number
```

Returns the month for a date, according to UTC.

#### `getUTCSeconds`

``` purescript
getUTCSeconds :: JSDate -> Number
```

Returns the seconds for a date, according to UTC.

#### `getDate`

``` purescript
getDate :: JSDate -> Effect Number
```

Returns the day of the month for a date, according to the current
machine's date/time locale.

#### `getDay`

``` purescript
getDay :: JSDate -> Effect Number
```

Returns the day of the week for a date, according to the current
machine's date/time locale.

#### `getFullYear`

``` purescript
getFullYear :: JSDate -> Effect Number
```

Returns the year for a date, according to the current machine's date/time
locale.

#### `getHours`

``` purescript
getHours :: JSDate -> Effect Number
```

Returns the hour for a date, according to the current machine's date/time
locale.

#### `getMilliseconds`

``` purescript
getMilliseconds :: JSDate -> Effect Number
```

Returns the milliseconds for a date, according to the current machine's
date/time locale.

#### `getMinutes`

``` purescript
getMinutes :: JSDate -> Effect Number
```

Returns the minutes for a date, according to the current machine's
date/time locale.

#### `getMonth`

``` purescript
getMonth :: JSDate -> Effect Number
```

Returns the month for a date, according to the current machine's
date/time locale.

#### `getSeconds`

``` purescript
getSeconds :: JSDate -> Effect Number
```

Returns the seconds for a date, according to the current machine's
date/time locale.

#### `getTimezoneOffset`

``` purescript
getTimezoneOffset :: JSDate -> Effect Number
```

Returns the time-zone offset for a date, according to the current machine's
date/time locale.

#### `toDateString`

``` purescript
toDateString :: JSDate -> String
```

Returns the date portion of a date value as a human-readable string.

#### `toISOString`

``` purescript
toISOString :: JSDate -> Effect String
```

Converts a date value to an ISO 8601 Extended format date string.

#### `toString`

``` purescript
toString :: JSDate -> String
```

Returns a string representing for a date value.

#### `toTimeString`

``` purescript
toTimeString :: JSDate -> String
```

Returns the time portion of a date value as a human-readable string.

#### `toUTCString`

``` purescript
toUTCString :: JSDate -> String
```

Returns the date as a string using the UTC timezone.

#### `fromTime`

``` purescript
fromTime :: Number -> JSDate
```

Returns the date at a number of milliseconds since 1970-01-01 00:00:00 UTC.



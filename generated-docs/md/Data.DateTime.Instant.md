## Module Data.DateTime.Instant

#### `Instant`

``` purescript
newtype Instant
```

An instant is a duration in milliseconds relative to the Unix epoch
(1970-01-01 00:00:00 UTC).

The constructor is private as the `Instant` range matches that of the
`DateTime` type.

##### Instances
``` purescript
Eq Instant
Ord Instant
Bounded Instant
Show Instant
```

#### `instant`

``` purescript
instant :: Milliseconds -> Maybe Instant
```

Attempts to create an `Instant` from a `Milliseconds` duration. The
minimum acceptable value equates to the `bottom` `DateTime` and the maximum
acceptable value equates to the `top` `DateTime`.

#### `unInstant`

``` purescript
unInstant :: Instant -> Milliseconds
```

Lowers an `Instant` to a `Milliseconds` duration.

#### `fromDateTime`

``` purescript
fromDateTime :: DateTime -> Instant
```

Creates an `Instant` from a `DateTime` value.

#### `fromDate`

``` purescript
fromDate :: Date -> Instant
```

Creates an `Instant` from a `Date` value, using the assumed time 00:00:00.

#### `toDateTime`

``` purescript
toDateTime :: Instant -> DateTime
```

Creates a `DateTime` value from an `Instant`.

#### `diff`

``` purescript
diff :: forall d. Duration d => Instant -> Instant -> d
```

Calculates the difference between two instants, returning the result as a duration.
For example:
```
do
  start <- liftEffect Now.now
  aLongRunningAff
  end <- liftEffect Now.now
  let
    hours :: Duration.Hours
    hours = Instant.diff end start
  log ("A long running Aff took " <> show hours)
```



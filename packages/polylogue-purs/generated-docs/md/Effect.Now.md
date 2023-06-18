## Module Effect.Now

#### `now`

``` purescript
now :: Effect Instant
```

Gets an `Instant` value for the date and time according to the current
machine’s clock.

#### `nowDateTime`

``` purescript
nowDateTime :: Effect DateTime
```

Gets a `DateTime` value for the date and time according to the current
machine’s clock.

#### `nowDate`

``` purescript
nowDate :: Effect Date
```

Gets the date according to the current machine’s clock.

#### `nowTime`

``` purescript
nowTime :: Effect Time
```

Gets the time according to the current machine’s clock.

#### `getTimezoneOffset`

``` purescript
getTimezoneOffset :: Effect Minutes
```

Gets the time zone difference, in minutes, from current local (host system settings) to UTC using `now`.



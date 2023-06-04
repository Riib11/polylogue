## Module Data.DateTime.Gen

#### `genDateTime`

``` purescript
genDateTime :: forall m. MonadGen m => m DateTime
```

Generates a random `DateTime` between 1st Jan 1900 00:00:00 and
31st Dec 2100 23:59:59, inclusive.


### Re-exported from Data.Date.Gen:

#### `genYear`

``` purescript
genYear :: forall m. MonadGen m => m Year
```

Generates a random `Year` in the range 1900-2100, inclusive.

#### `genWeekday`

``` purescript
genWeekday :: forall m. MonadGen m => m Weekday
```

Generates a random `Weekday` component.

#### `genMonth`

``` purescript
genMonth :: forall m. MonadGen m => m Month
```

Generates a random `Month` component.

#### `genDay`

``` purescript
genDay :: forall m. MonadGen m => m Day
```

Generates a random `Day` component.

#### `genDate`

``` purescript
genDate :: forall m. MonadGen m => m Date
```

Generates a random `Date` between 1st Jan 1900 and 31st Dec 2100,
inclusive.

### Re-exported from Data.Time.Gen:

#### `genTime`

``` purescript
genTime :: forall m. MonadGen m => m Time
```

Generates a random `Time` between 00:00:00 and 23:59:59, inclusive.

#### `genSecond`

``` purescript
genSecond :: forall m. MonadGen m => m Second
```

Generates a random `Second` component.

#### `genMinute`

``` purescript
genMinute :: forall m. MonadGen m => m Minute
```

Generates a random `Minute` component.

#### `genMillisecond`

``` purescript
genMillisecond :: forall m. MonadGen m => m Millisecond
```

Generates a random `Millisecond` component.

#### `genHour`

``` purescript
genHour :: forall m. MonadGen m => m Hour
```

Generates a random `Hour` component.


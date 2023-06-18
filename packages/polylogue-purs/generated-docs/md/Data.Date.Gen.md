## Module Data.Date.Gen

#### `genDate`

``` purescript
genDate :: forall m. MonadGen m => m Date
```

Generates a random `Date` between 1st Jan 1900 and 31st Dec 2100,
inclusive.


### Re-exported from Data.Date.Component.Gen:

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


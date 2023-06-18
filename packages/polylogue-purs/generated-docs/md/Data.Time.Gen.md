## Module Data.Time.Gen

#### `genTime`

``` purescript
genTime :: forall m. MonadGen m => m Time
```

Generates a random `Time` between 00:00:00 and 23:59:59, inclusive.


### Re-exported from Data.Time.Component.Gen:

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


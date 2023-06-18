## Module Data.Time.Duration.Gen

#### `genMilliseconds`

``` purescript
genMilliseconds :: forall m. MonadGen m => m Milliseconds
```

Generates a random `Milliseconds` duration, up to 10 minutes.

#### `genSeconds`

``` purescript
genSeconds :: forall m. MonadGen m => m Seconds
```

Generates a random `Seconds` duration, up to 10 minutes.

#### `genMinutes`

``` purescript
genMinutes :: forall m. MonadGen m => m Minutes
```

Generates a random `Seconds` duration, up to 10 hours.

#### `genHours`

``` purescript
genHours :: forall m. MonadGen m => m Hours
```

Generates a random `Hours` duration, up to 10 days.

#### `genDays`

``` purescript
genDays :: forall m. MonadGen m => m Days
```

Generates a random `Days` duration, up to 6 weeks.



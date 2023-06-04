## Module Data.Interval.Duration

#### `Duration`

``` purescript
newtype Duration
  = Duration (Map DurationComponent Number)
```

##### Instances
``` purescript
Eq Duration
Ord Duration
Newtype Duration _
Show Duration
Semigroup Duration
Monoid Duration
```

#### `DurationComponent`

``` purescript
data DurationComponent
  = Second
  | Minute
  | Hour
  | Day
  | Week
  | Month
  | Year
```

##### Instances
``` purescript
Eq DurationComponent
Ord DurationComponent
Show DurationComponent
```

#### `year`

``` purescript
year :: Number -> Duration
```

#### `month`

``` purescript
month :: Number -> Duration
```

#### `week`

``` purescript
week :: Number -> Duration
```

#### `day`

``` purescript
day :: Number -> Duration
```

#### `hour`

``` purescript
hour :: Number -> Duration
```

#### `minute`

``` purescript
minute :: Number -> Duration
```

#### `second`

``` purescript
second :: Number -> Duration
```

#### `millisecond`

``` purescript
millisecond :: Number -> Duration
```



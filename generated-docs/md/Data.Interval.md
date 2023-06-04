## Module Data.Interval

#### `Interval`

``` purescript
data Interval d a
  = StartEnd a a
  | DurationEnd d a
  | StartDuration a d
  | DurationOnly d
```

##### Instances
``` purescript
(Eq d, Eq a) => Eq (Interval d a)
(Ord d, Ord a) => Ord (Interval d a)
(Show d, Show a) => Show (Interval d a)
Functor (Interval d)
Bifunctor Interval
Foldable (Interval d)
Bifoldable Interval
Traversable (Interval d)
Bitraversable Interval
Extend (Interval d)
```

#### `RecurringInterval`

``` purescript
data RecurringInterval d a
  = RecurringInterval (Maybe Int) (Interval d a)
```

##### Instances
``` purescript
(Eq d, Eq a) => Eq (RecurringInterval d a)
(Ord d, Ord a) => Ord (RecurringInterval d a)
(Show d, Show a) => Show (RecurringInterval d a)
Functor (RecurringInterval d)
Bifunctor RecurringInterval
Foldable (RecurringInterval d)
Bifoldable RecurringInterval
Traversable (RecurringInterval d)
Bitraversable RecurringInterval
Extend (RecurringInterval d)
```


### Re-exported from Data.Interval.Duration:

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

#### `year`

``` purescript
year :: Number -> Duration
```

#### `week`

``` purescript
week :: Number -> Duration
```

#### `second`

``` purescript
second :: Number -> Duration
```

#### `month`

``` purescript
month :: Number -> Duration
```

#### `minute`

``` purescript
minute :: Number -> Duration
```

#### `millisecond`

``` purescript
millisecond :: Number -> Duration
```

#### `hour`

``` purescript
hour :: Number -> Duration
```

#### `day`

``` purescript
day :: Number -> Duration
```


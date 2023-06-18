## Module Data.Enum

#### `Enum`

``` purescript
class (Ord a) <= Enum a  where
  succ :: a -> Maybe a
  pred :: a -> Maybe a
```

Type class for enumerations.

Laws:
- Successor: `all (a < _) (succ a)`
- Predecessor: `all (_ < a) (pred a)`
- Succ retracts pred: `pred >=> succ >=> pred = pred`
- Pred retracts succ: `succ >=> pred >=> succ = succ`
- Non-skipping succ: `b <= a || any (_ <= b) (succ a)`
- Non-skipping pred: `a <= b || any (b <= _) (pred a)`

The retraction laws can intuitively be understood as saying that `succ` is
the opposite of `pred`; if you apply `succ` and then `pred` to something,
you should end up with what you started with (although of course this
doesn't apply if you tried to `succ` the last value in an enumeration and
therefore got `Nothing` out).

The non-skipping laws can intuitively be understood as saying that `succ`
shouldn't skip over any elements of your type. For example, _without_ the
non-skipping laws, it would be permissible to write an `Enum Int` instance
where `succ x = Just (x+2)`, and similarly `pred x = Just (x-2)`.

##### Instances
``` purescript
Enum Boolean
Enum Int
Enum Char
Enum Unit
Enum Ordering
(BoundedEnum a) => Enum (Maybe a)
(BoundedEnum a, BoundedEnum b) => Enum (Either a b)
(Enum a, BoundedEnum b) => Enum (Tuple a b)
```

#### `BoundedEnum`

``` purescript
class (Bounded a, Enum a) <= BoundedEnum a  where
  cardinality :: Cardinality a
  toEnum :: Int -> Maybe a
  fromEnum :: a -> Int
```

Type class for finite enumerations.

This should not be considered a part of a numeric hierarchy, as in Haskell.
Rather, this is a type class for small, ordered sum types with
statically-determined cardinality and the ability to easily compute
successor and predecessor elements like `DayOfWeek`.

Laws:

- ```succ bottom >>= succ >>= succ ... succ [cardinality - 1 times] == top```
- ```pred top    >>= pred >>= pred ... pred [cardinality - 1 times] == bottom```
- ```forall a > bottom: pred a >>= succ == Just a```
- ```forall a < top:  succ a >>= pred == Just a```
- ```forall a > bottom: fromEnum <$> pred a = pred (fromEnum a)```
- ```forall a < top:  fromEnum <$> succ a = succ (fromEnum a)```
- ```e1 `compare` e2 == fromEnum e1 `compare` fromEnum e2```
- ```toEnum (fromEnum a) = Just a```

##### Instances
``` purescript
BoundedEnum Boolean
BoundedEnum Char
BoundedEnum Unit
BoundedEnum Ordering
```

#### `toEnumWithDefaults`

``` purescript
toEnumWithDefaults :: forall a. BoundedEnum a => a -> a -> Int -> a
```

Like `toEnum` but returns the first argument if `x` is less than
`fromEnum bottom` and the second argument if `x` is greater than
`fromEnum top`.

``` purescript
toEnumWithDefaults False True (-1) -- False
toEnumWithDefaults False True 0    -- False
toEnumWithDefaults False True 1    -- True
toEnumWithDefaults False True 2    -- True
```

#### `Cardinality`

``` purescript
newtype Cardinality a
  = Cardinality Int
```

A type for the size of finite enumerations.

##### Instances
``` purescript
Newtype (Cardinality a) _
Eq (Cardinality a)
Ord (Cardinality a)
Show (Cardinality a)
```

#### `enumFromTo`

``` purescript
enumFromTo :: forall a u. Enum a => Unfoldable1 u => a -> a -> u a
```

Returns a contiguous sequence of elements from the first value to the
second value (inclusive).

``` purescript
enumFromTo 0 3 = [0, 1, 2, 3]
enumFromTo 'c' 'a' = ['c', 'b', 'a']
```

The example shows `Array` return values, but the result can be any type
with an `Unfoldable1` instance.

#### `enumFromThenTo`

``` purescript
enumFromThenTo :: forall f a. Unfoldable f => Functor f => BoundedEnum a => a -> a -> a -> f a
```

Returns a sequence of elements from the first value, taking steps
according to the difference between the first and second value, up to
(but not exceeding) the third value.

``` purescript
enumFromThenTo 0 2 6 = [0, 2, 4, 6]
enumFromThenTo 0 3 5 = [0, 3]
```

Note that there is no `BoundedEnum` instance for integers, they're just
being used here for illustrative purposes to help clarify the behaviour.

The example shows `Array` return values, but the result can be any type
with an `Unfoldable1` instance.

#### `upFrom`

``` purescript
upFrom :: forall a u. Enum a => Unfoldable u => a -> u a
```

Produces all successors of an `Enum` value, excluding the start value.

#### `upFromIncluding`

``` purescript
upFromIncluding :: forall a u. Enum a => Unfoldable1 u => a -> u a
```

Produces all successors of an `Enum` value, including the start value.

`upFromIncluding bottom` will return all values in an `Enum`.

#### `downFrom`

``` purescript
downFrom :: forall a u. Enum a => Unfoldable u => a -> u a
```

Produces all predecessors of an `Enum` value, excluding the start value.

#### `downFromIncluding`

``` purescript
downFromIncluding :: forall a u. Enum a => Unfoldable1 u => a -> u a
```

Produces all predecessors of an `Enum` value, including the start value.

`downFromIncluding top` will return all values in an `Enum`, in reverse
order.

#### `defaultSucc`

``` purescript
defaultSucc :: forall a. (Int -> Maybe a) -> (a -> Int) -> a -> Maybe a
```

Provides a default implementation for `succ`, given a function that maps
integers to values in the `Enum`, and a function that maps values in the
`Enum` back to integers. The integer mapping must agree in both directions
for this to implement a law-abiding `succ`.

If a `BoundedEnum` instance exists for `a`, the `toEnum` and `fromEnum`
functions can be used here:

``` purescript
succ = defaultSucc toEnum fromEnum
```

#### `defaultPred`

``` purescript
defaultPred :: forall a. (Int -> Maybe a) -> (a -> Int) -> a -> Maybe a
```

Provides a default implementation for `pred`, given a function that maps
integers to values in the `Enum`, and a function that maps values in the
`Enum` back to integers. The integer mapping must agree in both directions
for this to implement a law-abiding `pred`.

If a `BoundedEnum` instance exists for `a`, the `toEnum` and `fromEnum`
functions can be used here:

``` purescript
pred = defaultPred toEnum fromEnum
```

#### `defaultCardinality`

``` purescript
defaultCardinality :: forall a. Bounded a => Enum a => Cardinality a
```

Provides a default implementation for `cardinality`.

Runs in `O(n)` where `n` is `fromEnum top`

#### `defaultToEnum`

``` purescript
defaultToEnum :: forall a. Bounded a => Enum a => Int -> Maybe a
```

Provides a default implementation for `toEnum`.

- Assumes `fromEnum bottom = 0`.
- Cannot be used in conjuction with `defaultSucc`.

Runs in `O(n)` where `n` is `fromEnum a`.

#### `defaultFromEnum`

``` purescript
defaultFromEnum :: forall a. Enum a => a -> Int
```

Provides a default implementation for `fromEnum`.

- Assumes `toEnum 0 = Just bottom`.
- Cannot be used in conjuction with `defaultPred`.

Runs in `O(n)` where `n` is `fromEnum a`.



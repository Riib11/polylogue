## Module Data.Enum.Generic

#### `GenericEnum`

``` purescript
class GenericEnum a  where
  genericPred' :: a -> Maybe a
  genericSucc' :: a -> Maybe a
```

##### Instances
``` purescript
GenericEnum NoArguments
(Enum a) => GenericEnum (Argument a)
(GenericEnum a) => GenericEnum (Constructor name a)
(GenericEnum a, GenericTop a, GenericEnum b, GenericBottom b) => GenericEnum (Sum a b)
(GenericEnum a, GenericTop a, GenericBottom a, GenericEnum b, GenericTop b, GenericBottom b) => GenericEnum (Product a b)
```

#### `genericPred`

``` purescript
genericPred :: forall a rep. Generic a rep => GenericEnum rep => a -> Maybe a
```

A `Generic` implementation of the `pred` member from the `Enum` type class.

#### `genericSucc`

``` purescript
genericSucc :: forall a rep. Generic a rep => GenericEnum rep => a -> Maybe a
```

A `Generic` implementation of the `succ` member from the `Enum` type class.

#### `GenericBoundedEnum`

``` purescript
class GenericBoundedEnum a  where
  genericCardinality' :: Cardinality a
  genericToEnum' :: Int -> Maybe a
  genericFromEnum' :: a -> Int
```

##### Instances
``` purescript
GenericBoundedEnum NoArguments
(BoundedEnum a) => GenericBoundedEnum (Argument a)
(GenericBoundedEnum a) => GenericBoundedEnum (Constructor name a)
(GenericBoundedEnum a, GenericBoundedEnum b) => GenericBoundedEnum (Sum a b)
(GenericBoundedEnum a, GenericBoundedEnum b) => GenericBoundedEnum (Product a b)
```

#### `genericCardinality`

``` purescript
genericCardinality :: forall a rep. Generic a rep => GenericBoundedEnum rep => Cardinality a
```

A `Generic` implementation of the `cardinality` member from the
`BoundedEnum` type class.

#### `genericToEnum`

``` purescript
genericToEnum :: forall a rep. Generic a rep => GenericBoundedEnum rep => Int -> Maybe a
```

A `Generic` implementation of the `toEnum` member from the `BoundedEnum`
type class.

#### `genericFromEnum`

``` purescript
genericFromEnum :: forall a rep. Generic a rep => GenericBoundedEnum rep => a -> Int
```

A `Generic` implementation of the `fromEnum` member from the `BoundedEnum`
type class.



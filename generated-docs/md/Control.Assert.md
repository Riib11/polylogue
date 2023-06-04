## Module Control.Assert

#### `Assertion`

``` purescript
type Assertion a b = { check :: a -> String \/ b, label :: String }
```

#### `pureAssertion`

``` purescript
pureAssertion :: forall a. Assertion a a
```

#### `emptyAssertion`

``` purescript
emptyAssertion :: forall a. String -> Assertion a Void
```

#### `assert`

``` purescript
assert :: forall a b c. Assertion a b -> a -> (Partial => b -> c) -> c
```

#### `assertI`

``` purescript
assertI :: forall a b. Assertion a b -> a -> b
```

#### `contract`

``` purescript
contract :: forall a b c d. Assertion a b -> a -> (Partial => b -> c) -> Assertion c d -> d
```

#### `assertA`

``` purescript
assertA :: forall f a b. Applicative f => Assertion a b -> a -> f b
```



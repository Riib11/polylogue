## Module Control.Assert.Assertions

#### `just`

``` purescript
just :: forall a. Assertion (Maybe a) a
```

#### `equal`

``` purescript
equal :: forall a. Show a => Eq a => Assertion (a /\ a) Unit
```

#### `permutedArrays`

``` purescript
permutedArrays :: forall a. Show a => Eq a => Assertion ((Array a) /\ (Array a)) Unit
```

#### `anyInArray`

``` purescript
anyInArray :: forall a. Show a => String -> (a -> Boolean) -> Assertion (Array a) a
```

#### `memberOfArray`

``` purescript
memberOfArray :: forall a. Show a => Eq a => Assertion (a /\ (Array a)) Int
```



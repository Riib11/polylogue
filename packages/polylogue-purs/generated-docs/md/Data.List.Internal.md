## Module Data.List.Internal

#### `Set`

``` purescript
data Set k
```

#### `emptySet`

``` purescript
emptySet :: forall k. Set k
```

#### `insertAndLookupBy`

``` purescript
insertAndLookupBy :: forall k. (k -> k -> Ordering) -> k -> Set k -> { found :: Boolean, result :: Set k }
```

Insert or replace a key/value pair in a map



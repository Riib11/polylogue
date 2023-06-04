## Module Data.UUID

#### `UUID`

``` purescript
newtype UUID
```

##### Instances
``` purescript
Show UUID
Eq UUID
Ord UUID
```

#### `emptyUUID`

``` purescript
emptyUUID :: UUID
```

#### `genUUID`

``` purescript
genUUID :: Effect UUID
```

Generates a v4 UUID

#### `parseUUID`

``` purescript
parseUUID :: String -> Maybe UUID
```

Validates a String as a v4 UUID

#### `genv3UUID`

``` purescript
genv3UUID :: String -> UUID -> UUID
```

#### `genv5UUID`

``` purescript
genv5UUID :: String -> UUID -> UUID
```

#### `toString`

``` purescript
toString :: UUID -> String
```



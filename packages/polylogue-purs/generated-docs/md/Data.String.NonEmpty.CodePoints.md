## Module Data.String.NonEmpty.CodePoints

#### `fromCodePointArray`

``` purescript
fromCodePointArray :: Array CodePoint -> Maybe NonEmptyString
```

#### `fromNonEmptyCodePointArray`

``` purescript
fromNonEmptyCodePointArray :: NonEmptyArray CodePoint -> NonEmptyString
```

#### `singleton`

``` purescript
singleton :: CodePoint -> NonEmptyString
```

#### `cons`

``` purescript
cons :: CodePoint -> String -> NonEmptyString
```

#### `snoc`

``` purescript
snoc :: CodePoint -> String -> NonEmptyString
```

#### `fromFoldable1`

``` purescript
fromFoldable1 :: forall f. Foldable1 f => f CodePoint -> NonEmptyString
```

#### `toCodePointArray`

``` purescript
toCodePointArray :: NonEmptyString -> Array CodePoint
```

#### `toNonEmptyCodePointArray`

``` purescript
toNonEmptyCodePointArray :: NonEmptyString -> NonEmptyArray CodePoint
```

#### `codePointAt`

``` purescript
codePointAt :: Int -> NonEmptyString -> Maybe CodePoint
```

#### `indexOf`

``` purescript
indexOf :: Pattern -> NonEmptyString -> Maybe Int
```

#### `indexOf'`

``` purescript
indexOf' :: Pattern -> Int -> NonEmptyString -> Maybe Int
```

#### `lastIndexOf`

``` purescript
lastIndexOf :: Pattern -> NonEmptyString -> Maybe Int
```

#### `lastIndexOf'`

``` purescript
lastIndexOf' :: Pattern -> Int -> NonEmptyString -> Maybe Int
```

#### `uncons`

``` purescript
uncons :: NonEmptyString -> { head :: CodePoint, tail :: Maybe NonEmptyString }
```

#### `length`

``` purescript
length :: NonEmptyString -> Int
```

#### `take`

``` purescript
take :: Int -> NonEmptyString -> Maybe NonEmptyString
```

#### `takeWhile`

``` purescript
takeWhile :: (CodePoint -> Boolean) -> NonEmptyString -> Maybe NonEmptyString
```

#### `drop`

``` purescript
drop :: Int -> NonEmptyString -> Maybe NonEmptyString
```

#### `dropWhile`

``` purescript
dropWhile :: (CodePoint -> Boolean) -> NonEmptyString -> Maybe NonEmptyString
```

#### `countPrefix`

``` purescript
countPrefix :: (CodePoint -> Boolean) -> NonEmptyString -> Int
```

#### `splitAt`

``` purescript
splitAt :: Int -> NonEmptyString -> { after :: Maybe NonEmptyString, before :: Maybe NonEmptyString }
```



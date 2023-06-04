## Module Data.CodePoint.Unicode.Internal.Casing

#### `CaseRec`

``` purescript
type CaseRec = { code :: Int, fold :: Int, foldFull :: Array Int, lower :: Array Int, title :: Array Int, upper :: Array Int }
```

#### `rules`

``` purescript
rules :: Array CaseRec
```

#### `zeroRec`

``` purescript
zeroRec :: Int -> CaseRec
```

#### `recCmp`

``` purescript
recCmp :: CaseRec -> CaseRec -> Ordering
```

#### `findRule`

``` purescript
findRule :: Int -> CaseRec
```

#### `fold`

``` purescript
fold :: Int -> Int
```

#### `foldFull`

``` purescript
foldFull :: Int -> Array Int
```

#### `lower`

``` purescript
lower :: Int -> Array Int
```

#### `title`

``` purescript
title :: Int -> Array Int
```

#### `upper`

``` purescript
upper :: Int -> Array Int
```



## Module Text.Pretty

#### `Pretty`

``` purescript
class Pretty a  where
  pretty :: a -> String
```

##### Instances
``` purescript
Pretty String
Pretty Int
Pretty Boolean
(Pretty a) => Pretty (List a)
(Pretty a) => Pretty (Array a)
(Pretty a) => Pretty (Maybe a)
(Pretty a, Pretty b) => Pretty (Tuple a b)
```

#### `appendSpaced`

``` purescript
appendSpaced :: String -> String -> String
```

#### `(<+>)`

``` purescript
infixr 5 appendSpaced as <+>
```

#### `indent`

``` purescript
indent :: String -> String
```

#### `surround`

``` purescript
surround :: String -> String -> String -> String
```

#### `quotes`

``` purescript
quotes :: String -> String
```

#### `quotes2`

``` purescript
quotes2 :: String -> String
```

#### `parens`

``` purescript
parens :: String -> String
```

#### `brackets`

``` purescript
brackets :: String -> String
```

#### `braces`

``` purescript
braces :: String -> String
```

#### `braces2`

``` purescript
braces2 :: String -> String
```

#### `cursor`

``` purescript
cursor :: String -> String
```

#### `angles`

``` purescript
angles :: String -> String
```

#### `ticks`

``` purescript
ticks :: String -> String
```

#### `commas`

``` purescript
commas :: Array String -> String
```

#### `newlines`

``` purescript
newlines :: Array String -> String
```

#### `bullets`

``` purescript
bullets :: Array String -> String
```



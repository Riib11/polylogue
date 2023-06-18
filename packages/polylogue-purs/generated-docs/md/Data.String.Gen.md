## Module Data.String.Gen

#### `genString`

``` purescript
genString :: forall m. MonadRec m => MonadGen m => m Char -> m String
```

Generates a string using the specified character generator.

#### `genUnicodeString`

``` purescript
genUnicodeString :: forall m. MonadRec m => MonadGen m => m String
```

Generates a string using characters from the Unicode basic multilingual
plain.

#### `genAsciiString`

``` purescript
genAsciiString :: forall m. MonadRec m => MonadGen m => m String
```

Generates a string using the ASCII character set, excluding control codes.

#### `genAsciiString'`

``` purescript
genAsciiString' :: forall m. MonadRec m => MonadGen m => m String
```

Generates a string using the ASCII character set.

#### `genDigitString`

``` purescript
genDigitString :: forall m. MonadRec m => MonadGen m => m String
```

Generates a string made up of numeric digits.

#### `genAlphaString`

``` purescript
genAlphaString :: forall m. MonadRec m => MonadGen m => m String
```

Generates a string using characters from the basic Latin alphabet.

#### `genAlphaLowercaseString`

``` purescript
genAlphaLowercaseString :: forall m. MonadRec m => MonadGen m => m String
```

Generates a string using lowercase characters from the basic Latin alphabet.

#### `genAlphaUppercaseString`

``` purescript
genAlphaUppercaseString :: forall m. MonadRec m => MonadGen m => m String
```

Generates a string using uppercase characters from the basic Latin alphabet.



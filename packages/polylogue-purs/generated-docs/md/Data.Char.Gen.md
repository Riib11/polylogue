## Module Data.Char.Gen

#### `genUnicodeChar`

``` purescript
genUnicodeChar :: forall m. MonadGen m => m Char
```

Generates a character of the Unicode basic multilingual plane.

#### `genAsciiChar`

``` purescript
genAsciiChar :: forall m. MonadGen m => m Char
```

Generates a character in the ASCII character set, excluding control codes.

#### `genAsciiChar'`

``` purescript
genAsciiChar' :: forall m. MonadGen m => m Char
```

Generates a character in the ASCII character set.

#### `genDigitChar`

``` purescript
genDigitChar :: forall m. MonadGen m => m Char
```

Generates a character that is a numeric digit.

#### `genAlpha`

``` purescript
genAlpha :: forall m. MonadGen m => m Char
```

Generates a character from the basic latin alphabet.

#### `genAlphaLowercase`

``` purescript
genAlphaLowercase :: forall m. MonadGen m => m Char
```

Generates a lowercase character from the basic latin alphabet.

#### `genAlphaUppercase`

``` purescript
genAlphaUppercase :: forall m. MonadGen m => m Char
```

Generates an uppercase character from the basic latin alphabet.



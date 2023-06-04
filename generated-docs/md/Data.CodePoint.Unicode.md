## Module Data.CodePoint.Unicode

#### `isAscii`

``` purescript
isAscii :: CodePoint -> Boolean
```

Selects the first 128 characters of the Unicode character set,
corresponding to the ASCII character set.

#### `isAsciiLower`

``` purescript
isAsciiLower :: CodePoint -> Boolean
```

Selects ASCII lower-case letters,
i.e. characters satisfying both `isAscii` and `isLower`.

#### `isAsciiUpper`

``` purescript
isAsciiUpper :: CodePoint -> Boolean
```

Selects ASCII upper-case letters,
i.e. characters satisfying both `isAscii` and `isUpper`.

#### `isLatin1`

``` purescript
isLatin1 :: CodePoint -> Boolean
```

Selects the first 256 characters of the Unicode character set,
corresponding to the ISO 8859-1 (Latin-1) character set.

#### `isLower`

``` purescript
isLower :: CodePoint -> Boolean
```

Selects lower-case alphabetic Unicode characters (letters).

#### `isUpper`

``` purescript
isUpper :: CodePoint -> Boolean
```

Selects upper-case or title-case alphabetic Unicode characters (letters).
Title case is used by a small number of letter ligatures like the
single-character form of /Lj/.

#### `isAlpha`

``` purescript
isAlpha :: CodePoint -> Boolean
```

Selects alphabetic Unicode characters (lower-case, upper-case and
title-case letters, plus letters of caseless scripts and modifiers letters).

#### `isAlphaNum`

``` purescript
isAlphaNum :: CodePoint -> Boolean
```

Selects alphabetic or numeric digit Unicode characters.

Note that numeric digits outside the ASCII range are selected by this
function but not by `isDigit`.  Such digits may be part of identifiers
but are not used by the printer and reader to represent numbers.

#### `isLetter`

``` purescript
isLetter :: CodePoint -> Boolean
```

Selects alphabetic Unicode characters (lower-case, upper-case and
title-case letters, plus letters of caseless scripts and
modifiers letters).

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `UppercaseLetter`
- `LowercaseLetter`
- `TitlecaseLetter`
- `ModifierLetter`
- `OtherLetter`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table)
part of the Unicode standard. The same document defines what is
and is not a "Letter".

*Examples*

Basic usage:

```
>>> isLetter (codePointFromChar 'a')
true
>>> isLetter (codePointFromChar 'A')
true
>>> isLetter (codePointFromChar '0')
false
>>> isLetter (codePointFromChar '%')
false
>>> isLetter (codePointFromChar '♥')
false
>>> isLetter (codePointFromChar '\x1F')
false
```

Ensure that 'isLetter' and 'isAlpha' are equivalent.

```
>>> chars = enumFromTo bottom top :: Array CodePoint
>>> letters = map isLetter chars
>>> alphas = map isAlpha chars
>>> letters == alphas
true
```

#### `isDigit`

``` purescript
isDigit :: Warn (Text "\'isDigit\' is deprecated, use \'isDecDigit\', \'isHexDigit\', or \'isOctDigit\' instead") => CodePoint -> Boolean
```

#### `isDecDigit`

``` purescript
isDecDigit :: CodePoint -> Boolean
```

Selects ASCII decimal digits, i.e. `0..9`.

#### `isOctDigit`

``` purescript
isOctDigit :: CodePoint -> Boolean
```

Selects ASCII octal digits, i.e. `0..7`.

#### `isHexDigit`

``` purescript
isHexDigit :: CodePoint -> Boolean
```

Selects ASCII hexadecimal digits,
i.e. `0..9, A..F, a..f`.

#### `isControl`

``` purescript
isControl :: CodePoint -> Boolean
```

Selects control characters, which are the non-printing characters of
the Latin-1 subset of Unicode.

#### `isPrint`

``` purescript
isPrint :: CodePoint -> Boolean
```

Selects printable Unicode characters
(letters, numbers, marks, punctuation, symbols and spaces).

#### `isSpace`

``` purescript
isSpace :: CodePoint -> Boolean
```

Returns `true` for any Unicode space character, and the control
characters `\t`, `\n`, `\r`, `\f`, `\v`.

`isSpace` includes non-breaking space.

#### `isSymbol`

``` purescript
isSymbol :: CodePoint -> Boolean
```

Selects Unicode symbol characters, including mathematical and
currency symbols.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `MathSymbol`
- `CurrencySymbol`
- `ModifierSymbol`
- `OtherSymbol`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table),
part of the Unicode standard. The same document defines what is
and is not a "Symbol".

*Examples*

Basic usage:

```
>>> isSymbol (codePointFromChar 'a')
false
>>> isSymbol (codePointFromChar '6')
false
>>> isSymbol (codePointFromChar '=')
true
```

The definition of \"math symbol\" may be a little
counter-intuitive depending on one's background:

```
>>> isSymbol (codePointFromChar '+')
true
>>> isSymbol (codePointFromChar '-')
false
```

#### `isSeparator`

``` purescript
isSeparator :: CodePoint -> Boolean
```

Selects Unicode space and separator characters.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `Space`
- `LineSeparator`
- `ParagraphSeparator`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table)
part of the Unicode standard. The same document defines what is
and is not a "Separator".

*Examples*

Basic usage:

```
>>> isSeparator (codePointFromChar 'a')
false
>>> isSeparator (codePointFromChar '6')
false
>>> isSeparator (codePointFromChar ' ')
true
>>> isSeparator (codePointFromChar '-')
false
```

Warning: newlines and tab characters are not considered
separators.

```
>>> isSeparator (codePointFromChar '\n')
false
>>> isSeparator (codePointFromChar '\t')
false
```

But some more exotic characters are (like HTML's @&nbsp;@):

```
>>> isSeparator (codePointFromChar '\xA0')
true
```

#### `isPunctuation`

``` purescript
isPunctuation :: CodePoint -> Boolean
```

Selects Unicode punctuation characters, including various kinds
of connectors, brackets and quotes.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `ConnectorPunctuation`
- `DashPunctuation`
- `OpenPunctuation`
- `ClosePunctuation`
- `InitialQuote`
- `FinalQuote`
- `OtherPunctuation`

These classes are defined in the
[Unicode Character Database])http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table)
part of the Unicode standard. The same document defines what is
and is not a "Punctuation".

*Examples*

Basic usage:

```
>>> isPunctuation (codePointFromChar 'a')
false
>>> isPunctuation (codePointFromChar '7')
false
>>> isPunctuation (codePointFromChar '♥')
false
>>> isPunctuation (codePointFromChar '"')
true
>>> isPunctuation (codePointFromChar '?')
true
>>> isPunctuation (codePointFromChar '—')
true
```

#### `isMark`

``` purescript
isMark :: CodePoint -> Boolean
```

Selects Unicode mark characters, for example accents and the
like, which combine with preceding characters.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `NonSpacingMark`
- `SpacingCombiningMark`
- `EnclosingMark`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table),
part of the Unicode standard. The same document defines what is
and is not a "Mark".

*Examples*

Basic usage:

```
>>> isMark (codePointFromChar 'a')
false
>>> isMark (codePointFromChar '0')
false
```

Combining marks such as accent characters usually need to follow
another character before they become printable:

```
>>> map isMark (toCodePointArray "ò")
[false,true]
```

Puns are not necessarily supported:

```
>>> isMark (codePointFromChar '✓')
false
```

#### `isNumber`

``` purescript
isNumber :: CodePoint -> Boolean
```

Selects Unicode numeric characters, including digits from various
scripts, Roman numerals, et cetera.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

* `DecimalNumber`
* `LetterNumber`
* `OtherNumber`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table),
part of the Unicode standard. The same document defines what is
and is not a "Number".

*Examples*

Basic usage:

```
>>> isNumber (codePointFromChar 'a')
false
>>> isNumber (codePointFromChar '%')
false
>>> isNumber (codePointFromChar '3')
true
```

ASCII @\'0\'@ through @\'9\'@ are all numbers:

```
>>> and $ map (isNumber <<< codePointFromChar) (enumFromTo '0' '9' :: Array Char)
true
```

Unicode Roman numerals are \"numbers\" as well:

```
>>> isNumber (codePointFromChar 'Ⅸ')
true
```

#### `digitToInt`

``` purescript
digitToInt :: Warn (Text "\'digitToInt\' is deprecated, use \'decDigitToInt\', \'hexDigitToInt\', or \'octDigitToInt\' instead") => CodePoint -> Maybe Int
```

#### `hexDigitToInt`

``` purescript
hexDigitToInt :: CodePoint -> Maybe Int
```

Convert a single digit `Char` to the corresponding `Just Int` if its argument
satisfies `isHexDigit` (one of `0..9, A..F, a..f`). Anything else converts to `Nothing`

```
>>> import Data.Traversable

>>> traverse (hexDigitToInt <<< codePointFromChar) ['0','1','2','3','4','5','6','7','8','9']
(Just [0,1,2,3,4,5,6,7,8,9])

>>> traverse (hexDigitToInt <<< codePointFromChar) ['a','b','c','d','e','f']
(Just [10,11,12,13,14,15])

>>> traverse (hexDigitToInt <<< codePointFromChar) ['A','B','C','D','E','F']
(Just [10,11,12,13,14,15])

>>> hexDigitToInt (codePointFromChar 'G')
Nothing
```

#### `decDigitToInt`

``` purescript
decDigitToInt :: CodePoint -> Maybe Int
```

Convert a single digit `Char` to the corresponding `Just Int` if its argument
satisfies `isDecDigit` (one of `0..9`). Anything else converts to `Nothing`

```
>>> import Data.Traversable

>>> traverse decDigitToInt ['0','1','2','3','4','5','6','7','8','9']
(Just [0,1,2,3,4,5,6,7,8,9])

>>> decDigitToInt 'a'
Nothing
```

#### `octDigitToInt`

``` purescript
octDigitToInt :: CodePoint -> Maybe Int
```

Convert a single digit `Char` to the corresponding `Just Int` if its argument
satisfies `isOctDigit` (one of `0..7`). Anything else converts to `Nothing`

```
>>> import Data.Traversable

>>> traverse octDigitToInt ['0','1','2','3','4','5','6','7']
(Just [0,1,2,3,4,5,6,7])

>>> octDigitToInt '8'
Nothing
```

#### `toLower`

``` purescript
toLower :: CodePoint -> Array CodePoint
```

Convert a code point to the corresponding lower-case sequence of code points.
Any other character is returned unchanged.

#### `toUpper`

``` purescript
toUpper :: CodePoint -> Array CodePoint
```

Convert a code point to the corresponding upper-case sequence of code points.
Any other character is returned unchanged.

#### `toTitle`

``` purescript
toTitle :: CodePoint -> Array CodePoint
```

Convert a code point to the corresponding title-case or upper-case
sequence of code points.  (Title case differs from upper case only for a
small number of ligature characters.)
Any other character is returned unchanged.

#### `caseFold`

``` purescript
caseFold :: CodePoint -> Array CodePoint
```

Convert a code point to the corresponding case-folded sequence of code
points, for implementing caseless matching.
Any other character is returned unchanged.

#### `toLowerSimple`

``` purescript
toLowerSimple :: CodePoint -> CodePoint
```

Convert a code point to the corresponding lower-case code point, if any.
Any other character is returned unchanged.

#### `toUpperSimple`

``` purescript
toUpperSimple :: CodePoint -> CodePoint
```

Convert a code point to the corresponding upper-case code point, if any.
Any other character is returned unchanged.

#### `toTitleSimple`

``` purescript
toTitleSimple :: CodePoint -> CodePoint
```

Convert a code point to the corresponding title-case or upper-case
code point, if any.  (Title case differs from upper case only for a small
number of ligature characters.)
Any other character is returned unchanged.

#### `caseFoldSimple`

``` purescript
caseFoldSimple :: CodePoint -> CodePoint
```

Convert a code point to the corresponding case-folded code point.
Any other character is returned unchanged.

#### `GeneralCategory`

``` purescript
data GeneralCategory
  = UppercaseLetter
  | LowercaseLetter
  | TitlecaseLetter
  | ModifierLetter
  | OtherLetter
  | NonSpacingMark
  | SpacingCombiningMark
  | EnclosingMark
  | DecimalNumber
  | LetterNumber
  | OtherNumber
  | ConnectorPunctuation
  | DashPunctuation
  | OpenPunctuation
  | ClosePunctuation
  | InitialQuote
  | FinalQuote
  | OtherPunctuation
  | MathSymbol
  | CurrencySymbol
  | ModifierSymbol
  | OtherSymbol
  | Space
  | LineSeparator
  | ParagraphSeparator
  | Control
  | Format
  | Surrogate
  | PrivateUse
  | NotAssigned
```

Unicode General Categories (column 2 of the UnicodeData table) in
the order they are listed in the Unicode standard (the Unicode
Character Database, in particular).

*Examples*

Basic usage:

```
>>> :t OtherLetter
OtherLetter :: GeneralCategory
```

`Eq` instance:

```
>>> UppercaseLetter == UppercaseLetter
true
>>> UppercaseLetter == LowercaseLetter
false
```

`Ord` instance:

```
>>> NonSpacingMark <= MathSymbol
true
```

`Enum` instance (TODO: this is not implemented yet):

```
>>> enumFromTo ModifierLetter SpacingCombiningMark
[ModifierLetter,OtherLetter,NonSpacingMark,SpacingCombiningMark]
```

`Show` instance:

```
>>> show EnclosingMark
"EnclosingMark"
```

`Bounded` instance:

```
>>> bottom :: GeneralCategory
UppercaseLetter
>>> top :: GeneralCategory
NotAssigned
```

##### Instances
``` purescript
Show GeneralCategory
Eq GeneralCategory
Ord GeneralCategory
Bounded GeneralCategory
```

#### `unicodeCatToGeneralCat`

``` purescript
unicodeCatToGeneralCat :: UnicodeCategory -> GeneralCategory
```

#### `generalCatToInt`

``` purescript
generalCatToInt :: GeneralCategory -> Int
```

#### `generalCatToUnicodeCat`

``` purescript
generalCatToUnicodeCat :: GeneralCategory -> UnicodeCategory
```

#### `generalCategory`

``` purescript
generalCategory :: CodePoint -> Maybe GeneralCategory
```

The Unicode general category of the character.

*Examples*

Basic usage:

```
>>> generalCategory (codePointFromChar 'a')
Just LowercaseLetter
>>> generalCategory (codePointFromChar 'A')
Just UppercaseLetter
>>> generalCategory (codePointFromChar '0')
Just DecimalNumber
>>> generalCategory (codePointFromChar '%')
Just OtherPunctuation
>>> generalCategory (codePointFromChar '♥')
Just OtherSymbol
>>> generalCategory (codePointFromChar '\31')
Just Control
>>> generalCategory (codePointFromChar ' ')
Just Space
```



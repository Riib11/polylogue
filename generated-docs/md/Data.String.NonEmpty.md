## Module Data.String.NonEmpty


### Re-exported from Data.String.NonEmpty.CodePoints:

#### `uncons`

``` purescript
uncons :: NonEmptyString -> { head :: CodePoint, tail :: Maybe NonEmptyString }
```

#### `toNonEmptyCodePointArray`

``` purescript
toNonEmptyCodePointArray :: NonEmptyString -> NonEmptyArray CodePoint
```

#### `toCodePointArray`

``` purescript
toCodePointArray :: NonEmptyString -> Array CodePoint
```

#### `takeWhile`

``` purescript
takeWhile :: (CodePoint -> Boolean) -> NonEmptyString -> Maybe NonEmptyString
```

#### `take`

``` purescript
take :: Int -> NonEmptyString -> Maybe NonEmptyString
```

#### `splitAt`

``` purescript
splitAt :: Int -> NonEmptyString -> { after :: Maybe NonEmptyString, before :: Maybe NonEmptyString }
```

#### `snoc`

``` purescript
snoc :: CodePoint -> String -> NonEmptyString
```

#### `singleton`

``` purescript
singleton :: CodePoint -> NonEmptyString
```

#### `length`

``` purescript
length :: NonEmptyString -> Int
```

#### `lastIndexOf'`

``` purescript
lastIndexOf' :: Pattern -> Int -> NonEmptyString -> Maybe Int
```

#### `lastIndexOf`

``` purescript
lastIndexOf :: Pattern -> NonEmptyString -> Maybe Int
```

#### `indexOf'`

``` purescript
indexOf' :: Pattern -> Int -> NonEmptyString -> Maybe Int
```

#### `indexOf`

``` purescript
indexOf :: Pattern -> NonEmptyString -> Maybe Int
```

#### `fromNonEmptyCodePointArray`

``` purescript
fromNonEmptyCodePointArray :: NonEmptyArray CodePoint -> NonEmptyString
```

#### `fromFoldable1`

``` purescript
fromFoldable1 :: forall f. Foldable1 f => f CodePoint -> NonEmptyString
```

#### `fromCodePointArray`

``` purescript
fromCodePointArray :: Array CodePoint -> Maybe NonEmptyString
```

#### `dropWhile`

``` purescript
dropWhile :: (CodePoint -> Boolean) -> NonEmptyString -> Maybe NonEmptyString
```

#### `drop`

``` purescript
drop :: Int -> NonEmptyString -> Maybe NonEmptyString
```

#### `countPrefix`

``` purescript
countPrefix :: (CodePoint -> Boolean) -> NonEmptyString -> Int
```

#### `cons`

``` purescript
cons :: CodePoint -> String -> NonEmptyString
```

#### `codePointAt`

``` purescript
codePointAt :: Int -> NonEmptyString -> Maybe CodePoint
```

### Re-exported from Data.String.NonEmpty.Internal:

#### `NonEmptyString`

``` purescript
newtype NonEmptyString
```

A string that is known not to be empty.

You can use this constructor to create a `NonEmptyString` that isn't
non-empty, breaking the guarantee behind this newtype. It is
provided as an escape hatch mainly for the `Data.NonEmpty.CodeUnits`
and `Data.NonEmpty.CodePoints` modules. Use this at your own risk
when you know what you are doing.

##### Instances
``` purescript
Eq NonEmptyString
Ord NonEmptyString
Semigroup NonEmptyString
Show NonEmptyString
```

#### `NonEmptyReplacement`

``` purescript
newtype NonEmptyReplacement
  = NonEmptyReplacement NonEmptyString
```

A newtype used in cases to specify a non-empty replacement for a pattern.

##### Instances
``` purescript
Eq NonEmptyReplacement
Ord NonEmptyReplacement
Semigroup NonEmptyReplacement
Show NonEmptyReplacement
```

#### `MakeNonEmpty`

``` purescript
class MakeNonEmpty (s :: Symbol)  where
  nes :: Proxy s -> NonEmptyString
```

A helper class for defining non-empty string values at compile time.

``` purescript
something :: NonEmptyString
something = nes (Proxy :: Proxy "something")
```

##### Instances
``` purescript
(Fail (Text "Cannot create an NonEmptyString from an empty Symbol")) => MakeNonEmpty ""
(IsSymbol s) => MakeNonEmpty s
```

#### `unsafeFromString`

``` purescript
unsafeFromString :: Partial => String -> NonEmptyString
```

A partial version of `fromString`.

#### `trim`

``` purescript
trim :: NonEmptyString -> Maybe NonEmptyString
```

Removes whitespace from the beginning and end of a string, including
[whitespace characters](http://www.ecma-international.org/ecma-262/5.1/#sec-7.2)
and [line terminators](http://www.ecma-international.org/ecma-262/5.1/#sec-7.3).
If the string is entirely made up of whitespace the result will be Nothing.

```purescript
trim (NonEmptyString "   Hello  \n World\n\t    ") == Just (NonEmptyString "Hello  \n World")
trim (NonEmptyString "   \n") == Nothing
```

#### `toUpper`

``` purescript
toUpper :: NonEmptyString -> NonEmptyString
```

Returns the argument converted to uppercase.

```purescript
toUpper (NonEmptyString "Hello") == NonEmptyString "HELLO"
```

#### `toString`

``` purescript
toString :: NonEmptyString -> String
```

Converts a `NonEmptyString` back into a standard `String`.

#### `toLower`

``` purescript
toLower :: NonEmptyString -> NonEmptyString
```

Returns the argument converted to lowercase.

```purescript
toLower (NonEmptyString "hElLo") == NonEmptyString "hello"
```

#### `stripSuffix`

``` purescript
stripSuffix :: Pattern -> NonEmptyString -> Maybe NonEmptyString
```

If the string ends with the given suffix, return the portion of the
string left after removing it. If the suffix does not match or there is no
remainder, the result will be `Nothing`.

```purescript
stripSuffix (Pattern ".exe") (NonEmptyString "purs.exe") == Just (NonEmptyString "purs")
stripSuffix (Pattern ".exe") (NonEmptyString "purs") == Nothing
stripSuffix (Pattern "Hello!") (NonEmptyString "Hello!") == Nothing
```

#### `stripPrefix`

``` purescript
stripPrefix :: Pattern -> NonEmptyString -> Maybe NonEmptyString
```

If the string starts with the given prefix, return the portion of the
string left after removing it. If the prefix does not match or there is no
remainder, the result will be `Nothing`.

```purescript
stripPrefix (Pattern "http:") (NonEmptyString "http://purescript.org") == Just (NonEmptyString "//purescript.org")
stripPrefix (Pattern "http:") (NonEmptyString "https://purescript.org") == Nothing
stripPrefix (Pattern "Hello!") (NonEmptyString "Hello!") == Nothing
```

#### `replaceAll`

``` purescript
replaceAll :: Pattern -> NonEmptyReplacement -> NonEmptyString -> NonEmptyString
```

Replaces all occurences of the pattern with the replacement string.

```purescript
replaceAll (Pattern "<=") (NonEmptyReplacement "≤") (NonEmptyString "a <= b <= c") == NonEmptyString "a ≤ b ≤ c"
```

#### `replace`

``` purescript
replace :: Pattern -> NonEmptyReplacement -> NonEmptyString -> NonEmptyString
```

Replaces the first occurence of the pattern with the replacement string.

```purescript
replace (Pattern "<=") (NonEmptyReplacement "≤") (NonEmptyString "a <= b <= c") == NonEmptyString "a ≤ b <= c"
```

#### `prependString`

``` purescript
prependString :: String -> NonEmptyString -> NonEmptyString
```

Prepends a string to this non-empty string. Since one of the strings is
non-empty we know the result will be too.

```purescript
prependString "be" (NonEmptyString "fore") == NonEmptyString "before"
prependString "" (NonEmptyString "fore") == NonEmptyString "fore"
```

#### `localeCompare`

``` purescript
localeCompare :: NonEmptyString -> NonEmptyString -> Ordering
```

Compare two strings in a locale-aware fashion. This is in contrast to
the `Ord` instance on `String` which treats strings as arrays of code
units:

```purescript
NonEmptyString "ä" `localeCompare` NonEmptyString "b" == LT
NonEmptyString "ä" `compare` NonEmptyString "b" == GT
```

#### `joinWith1`

``` purescript
joinWith1 :: forall f. Foldable1 f => NonEmptyString -> f String -> NonEmptyString
```

Joins possibly empty strings in a non-empty container together as a new
non-empty string, inserting a non-empty string as a separator between them.
The result is guaranteed to be non-empty.

```purescript
-- array syntax is used for demonstration here, it would need to be a real `Foldable1`
joinWith1 (NonEmptyString ", ") ["apple", "banana"] == NonEmptyString "apple, banana"
joinWith1 (NonEmptyString "/") ["a", "b", "", "c", ""] == NonEmptyString "a/b//c/"
```

#### `joinWith`

``` purescript
joinWith :: forall f. Foldable f => String -> f NonEmptyString -> String
```

Joins the strings in a container together as a new string, inserting the
first argument as separator between them. The result is not guaranteed to
be non-empty.

```purescript
joinWith ", " [NonEmptyString "apple", NonEmptyString "banana"] == "apple, banana"
joinWith ", " [] == ""
```

#### `join1With`

``` purescript
join1With :: forall f. Foldable1 f => String -> f NonEmptyString -> NonEmptyString
```

Joins non-empty strings in a non-empty container together as a new
non-empty string, inserting a possibly empty string as separator between
them. The result is guaranteed to be non-empty.

```purescript
-- array syntax is used for demonstration here, it would need to be a real `Foldable1`
join1With ", " [NonEmptyString "apple", NonEmptyString "banana"] == NonEmptyString "apple, banana"
join1With "" [NonEmptyString "apple", NonEmptyString "banana"] == NonEmptyString "applebanana"
```

#### `fromString`

``` purescript
fromString :: String -> Maybe NonEmptyString
```

Creates a `NonEmptyString` from a `String`, returning `Nothing` if the
input is empty.

```purescript
fromString "" = Nothing
fromString "hello" = Just (NES.unsafeFromString "hello")
```

#### `contains`

``` purescript
contains :: Pattern -> NonEmptyString -> Boolean
```

Checks whether the pattern appears in the given string.

```purescript
contains (Pattern "needle") (NonEmptyString "haystack with needle") == true
contains (Pattern "needle") (NonEmptyString "haystack") == false
```

#### `appendString`

``` purescript
appendString :: NonEmptyString -> String -> NonEmptyString
```

Appends a string to this non-empty string. Since one of the strings is
non-empty we know the result will be too.

```purescript
appendString (NonEmptyString "Hello") " world" == NonEmptyString "Hello world"
appendString (NonEmptyString "Hello") "" == NonEmptyString "Hello"
```

### Re-exported from Data.String.Pattern:

#### `Pattern`

``` purescript
newtype Pattern
  = Pattern String
```

A newtype used in cases where there is a string to be matched.

```purescript
pursPattern = Pattern ".purs"
--can be used like this:
contains pursPattern "Test.purs"
   == true
```


##### Instances
``` purescript
Eq Pattern
Ord Pattern
Newtype Pattern _
Show Pattern
```


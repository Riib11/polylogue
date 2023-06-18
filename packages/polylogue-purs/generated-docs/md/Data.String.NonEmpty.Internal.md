## Module Data.String.NonEmpty.Internal

While most of the code in this module is safe, this module does
export a few partial functions and the `NonEmptyString` constructor.
While the partial functions are obvious from the `Partial` constraint in
their type signature, the `NonEmptyString` constructor can be overlooked
when searching for issues in one's code. See the constructor's
documentation for more information.

#### `NonEmptyString`

``` purescript
newtype NonEmptyString
  = NonEmptyString String
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

#### `unsafeFromString`

``` purescript
unsafeFromString :: Partial => String -> NonEmptyString
```

A partial version of `fromString`.

#### `toString`

``` purescript
toString :: NonEmptyString -> String
```

Converts a `NonEmptyString` back into a standard `String`.

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

#### `contains`

``` purescript
contains :: Pattern -> NonEmptyString -> Boolean
```

Checks whether the pattern appears in the given string.

```purescript
contains (Pattern "needle") (NonEmptyString "haystack with needle") == true
contains (Pattern "needle") (NonEmptyString "haystack") == false
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

#### `replace`

``` purescript
replace :: Pattern -> NonEmptyReplacement -> NonEmptyString -> NonEmptyString
```

Replaces the first occurence of the pattern with the replacement string.

```purescript
replace (Pattern "<=") (NonEmptyReplacement "≤") (NonEmptyString "a <= b <= c") == NonEmptyString "a ≤ b <= c"
```

#### `replaceAll`

``` purescript
replaceAll :: Pattern -> NonEmptyReplacement -> NonEmptyString -> NonEmptyString
```

Replaces all occurences of the pattern with the replacement string.

```purescript
replaceAll (Pattern "<=") (NonEmptyReplacement "≤") (NonEmptyString "a <= b <= c") == NonEmptyString "a ≤ b ≤ c"
```

#### `toLower`

``` purescript
toLower :: NonEmptyString -> NonEmptyString
```

Returns the argument converted to lowercase.

```purescript
toLower (NonEmptyString "hElLo") == NonEmptyString "hello"
```

#### `toUpper`

``` purescript
toUpper :: NonEmptyString -> NonEmptyString
```

Returns the argument converted to uppercase.

```purescript
toUpper (NonEmptyString "Hello") == NonEmptyString "HELLO"
```

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

#### `liftS`

``` purescript
liftS :: forall r. (String -> r) -> NonEmptyString -> r
```



## Module Data.String.NonEmpty.CodeUnits

#### `fromCharArray`

``` purescript
fromCharArray :: Array Char -> Maybe NonEmptyString
```

Creates a `NonEmptyString` from a character array `String`, returning
`Nothing` if the input is empty.

```purescript
fromCharArray [] = Nothing
fromCharArray ['a', 'b', 'c'] = Just (NonEmptyString "abc")
```

#### `fromNonEmptyCharArray`

``` purescript
fromNonEmptyCharArray :: NonEmptyArray Char -> NonEmptyString
```

#### `singleton`

``` purescript
singleton :: Char -> NonEmptyString
```

Creates a `NonEmptyString` from a character.

#### `cons`

``` purescript
cons :: Char -> String -> NonEmptyString
```

Creates a `NonEmptyString` from a string by prepending a character.

```purescript
cons 'a' "bc" = NonEmptyString "abc"
cons 'a' "" = NonEmptyString "a"
```

#### `snoc`

``` purescript
snoc :: Char -> String -> NonEmptyString
```

Creates a `NonEmptyString` from a string by appending a character.

```purescript
snoc 'c' "ab" = NonEmptyString "abc"
snoc 'a' "" = NonEmptyString "a"
```

#### `fromFoldable1`

``` purescript
fromFoldable1 :: forall f. Foldable1 f => f Char -> NonEmptyString
```

Creates a `NonEmptyString` from a `Foldable1` container carrying
characters.

#### `toCharArray`

``` purescript
toCharArray :: NonEmptyString -> Array Char
```

Converts the `NonEmptyString` into an array of characters.

```purescript
toCharArray (NonEmptyString "Hello☺\n") == ['H','e','l','l','o','☺','\n']
```

#### `toNonEmptyCharArray`

``` purescript
toNonEmptyCharArray :: NonEmptyString -> NonEmptyArray Char
```

Converts the `NonEmptyString` into a non-empty array of characters.

#### `charAt`

``` purescript
charAt :: Int -> NonEmptyString -> Maybe Char
```

Returns the character at the given index, if the index is within bounds.

```purescript
charAt 2 (NonEmptyString "Hello") == Just 'l'
charAt 10 (NonEmptyString "Hello") == Nothing
```

#### `toChar`

``` purescript
toChar :: NonEmptyString -> Maybe Char
```

Converts the `NonEmptyString` to a character, if the length of the string
is exactly `1`.

```purescript
toChar "H" == Just 'H'
toChar "Hi" == Nothing
```

#### `indexOf`

``` purescript
indexOf :: Pattern -> NonEmptyString -> Maybe Int
```

Returns the index of the first occurrence of the pattern in the
given string. Returns `Nothing` if there is no match.

```purescript
indexOf (Pattern "c") (NonEmptyString "abcdc") == Just 2
indexOf (Pattern "c") (NonEmptyString "aaa") == Nothing
```

#### `indexOf'`

``` purescript
indexOf' :: Pattern -> Int -> NonEmptyString -> Maybe Int
```

Returns the index of the first occurrence of the pattern in the
given string, starting at the specified index. Returns `Nothing` if there is
no match.

```purescript
indexOf' (Pattern "a") 2 (NonEmptyString "ababa") == Just 2
indexOf' (Pattern "a") 3 (NonEmptyString "ababa") == Just 4
```

#### `lastIndexOf`

``` purescript
lastIndexOf :: Pattern -> NonEmptyString -> Maybe Int
```

Returns the index of the last occurrence of the pattern in the
given string. Returns `Nothing` if there is no match.

```purescript
lastIndexOf (Pattern "c") (NonEmptyString "abcdc") == Just 4
lastIndexOf (Pattern "c") (NonEmptyString "aaa") == Nothing
```

#### `lastIndexOf'`

``` purescript
lastIndexOf' :: Pattern -> Int -> NonEmptyString -> Maybe Int
```

Returns the index of the last occurrence of the pattern in the
given string, starting at the specified index and searching
backwards towards the beginning of the string.

Starting at a negative index is equivalent to starting at 0 and
starting at an index greater than the string length is equivalent
to searching in the whole string.

Returns `Nothing` if there is no match.

```purescript
lastIndexOf' (Pattern "a") (-1) (NonEmptyString "ababa") == Just 0
lastIndexOf' (Pattern "a") 1 (NonEmptyString "ababa") == Just 0
lastIndexOf' (Pattern "a") 3 (NonEmptyString "ababa") == Just 2
lastIndexOf' (Pattern "a") 4 (NonEmptyString "ababa") == Just 4
lastIndexOf' (Pattern "a") 5 (NonEmptyString "ababa") == Just 4
```

#### `uncons`

``` purescript
uncons :: NonEmptyString -> { head :: Char, tail :: Maybe NonEmptyString }
```

Returns the first character and the rest of the string.

```purescript
uncons "a" == { head: 'a', tail: Nothing }
uncons "Hello World" == { head: 'H', tail: Just (NonEmptyString "ello World") }
```

#### `length`

``` purescript
length :: NonEmptyString -> Int
```

Returns the number of characters the string is composed of.

```purescript
length (NonEmptyString "Hello World") == 11
```

#### `take`

``` purescript
take :: Int -> NonEmptyString -> Maybe NonEmptyString
```

Returns the first `n` characters of the string. Returns `Nothing` if `n` is
less than 1.

```purescript
take 5 (NonEmptyString "Hello World") == Just (NonEmptyString "Hello")
take 0 (NonEmptyString "Hello World") == Nothing
```

#### `takeRight`

``` purescript
takeRight :: Int -> NonEmptyString -> Maybe NonEmptyString
```

Returns the last `n` characters of the string. Returns `Nothing` if `n` is
less than 1.

```purescript
take 5 (NonEmptyString "Hello World") == Just (NonEmptyString "World")
take 0 (NonEmptyString "Hello World") == Nothing
```

#### `takeWhile`

``` purescript
takeWhile :: (Char -> Boolean) -> NonEmptyString -> Maybe NonEmptyString
```

Returns the longest prefix of characters that satisfy the predicate.
`Nothing` is returned if there is no matching prefix.

```purescript
takeWhile (_ /= ':') (NonEmptyString "http://purescript.org") == Just (NonEmptyString "http")
takeWhile (_ == 'a') (NonEmptyString "xyz") == Nothing
```

#### `drop`

``` purescript
drop :: Int -> NonEmptyString -> Maybe NonEmptyString
```

Returns the string without the first `n` characters. Returns `Nothing` if
more characters are dropped than the string is long.

```purescript
drop 6 (NonEmptyString "Hello World") == Just (NonEmptyString "World")
drop 20 (NonEmptyString "Hello World") == Nothing
```

#### `dropRight`

``` purescript
dropRight :: Int -> NonEmptyString -> Maybe NonEmptyString
```

Returns the string without the last `n` characters. Returns `Nothing` if
more characters are dropped than the string is long.

```purescript
dropRight 6 (NonEmptyString "Hello World") == Just (NonEmptyString "Hello")
dropRight 20 (NonEmptyString "Hello World") == Nothing
```

#### `dropWhile`

``` purescript
dropWhile :: (Char -> Boolean) -> NonEmptyString -> Maybe NonEmptyString
```

Returns the suffix remaining after `takeWhile`.

```purescript
dropWhile (_ /= '.') (NonEmptyString "Test.purs") == Just (NonEmptyString ".purs")
```

#### `countPrefix`

``` purescript
countPrefix :: (Char -> Boolean) -> NonEmptyString -> Int
```

Returns the number of contiguous characters at the beginning of the string
for which the predicate holds.

```purescript
countPrefix (_ /= 'o') (NonEmptyString "Hello World") == 4
```

#### `splitAt`

``` purescript
splitAt :: Int -> NonEmptyString -> { after :: Maybe NonEmptyString, before :: Maybe NonEmptyString }
```

Returns the substrings of a split at the given index, if the index is
within bounds.

```purescript
splitAt 2 (NonEmptyString "Hello World") == Just { before: Just (NonEmptyString "He"), after: Just (NonEmptyString "llo World") }
splitAt 10 (NonEmptyString "Hi") == Nothing
```



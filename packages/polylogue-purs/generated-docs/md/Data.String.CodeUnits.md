## Module Data.String.CodeUnits

#### `stripPrefix`

``` purescript
stripPrefix :: Pattern -> String -> Maybe String
```

If the string starts with the given prefix, return the portion of the
string left after removing it, as a `Just` value. Otherwise, return `Nothing`.

```purescript
stripPrefix (Pattern "http:") "http://purescript.org" == Just "//purescript.org"
stripPrefix (Pattern "http:") "https://purescript.org" == Nothing
```

#### `stripSuffix`

``` purescript
stripSuffix :: Pattern -> String -> Maybe String
```

If the string ends with the given suffix, return the portion of the
string left after removing it, as a `Just` value. Otherwise, return
`Nothing`.

```purescript
stripSuffix (Pattern ".exe") "psc.exe" == Just "psc"
stripSuffix (Pattern ".exe") "psc" == Nothing
```

#### `contains`

``` purescript
contains :: Pattern -> String -> Boolean
```

Checks whether the pattern appears in the given string.

```purescript
contains (Pattern "needle") "haystack with needle" == true
contains (Pattern "needle") "haystack" == false
```

#### `singleton`

``` purescript
singleton :: Char -> String
```

Returns a string of length `1` containing the given character.

```purescript
singleton 'l' == "l"
```


#### `fromCharArray`

``` purescript
fromCharArray :: Array Char -> String
```

Converts an array of characters into a string.

```purescript
fromCharArray ['H', 'e', 'l', 'l', 'o'] == "Hello"
```

#### `toCharArray`

``` purescript
toCharArray :: String -> Array Char
```

Converts the string into an array of characters.

```purescript
toCharArray "Hello☺\n" == ['H','e','l','l','o','☺','\n']
```

#### `charAt`

``` purescript
charAt :: Int -> String -> Maybe Char
```

Returns the character at the given index, if the index is within bounds.

```purescript
charAt 2 "Hello" == Just 'l'
charAt 10 "Hello" == Nothing
```


#### `toChar`

``` purescript
toChar :: String -> Maybe Char
```

Converts the string to a character, if the length of the string is
exactly `1`.

```purescript
toChar "l" == Just 'l'
toChar "Hi" == Nothing -- since length is not 1
```

#### `uncons`

``` purescript
uncons :: String -> Maybe { head :: Char, tail :: String }
```

Returns the first character and the rest of the string,
if the string is not empty.

```purescript
uncons "" == Nothing
uncons "Hello World" == Just { head: 'H', tail: "ello World" }
```


#### `length`

``` purescript
length :: String -> Int
```

Returns the number of characters the string is composed of.

```purescript
length "Hello World" == 11
```


#### `countPrefix`

``` purescript
countPrefix :: (Char -> Boolean) -> String -> Int
```

Returns the number of contiguous characters at the beginning
of the string for which the predicate holds.

```purescript
countPrefix (_ /= ' ') "Hello World" == 5 -- since length "Hello" == 5
```


#### `indexOf`

``` purescript
indexOf :: Pattern -> String -> Maybe Int
```

Returns the index of the first occurrence of the pattern in the
given string. Returns `Nothing` if there is no match.

```purescript
indexOf (Pattern "c") "abcdc" == Just 2
indexOf (Pattern "c") "aaa" == Nothing
```


#### `indexOf'`

``` purescript
indexOf' :: Pattern -> Int -> String -> Maybe Int
```

Returns the index of the first occurrence of the pattern in the
given string, starting at the specified index. Returns `Nothing` if there is
no match.

```purescript
indexOf' (Pattern "a") 2 "ababa" == Just 2
indexOf' (Pattern "a") 3 "ababa" == Just 4
```


#### `lastIndexOf`

``` purescript
lastIndexOf :: Pattern -> String -> Maybe Int
```

Returns the index of the last occurrence of the pattern in the
given string. Returns `Nothing` if there is no match.

```purescript
lastIndexOf (Pattern "c") "abcdc" == Just 4
lastIndexOf (Pattern "c") "aaa" == Nothing
```


#### `lastIndexOf'`

``` purescript
lastIndexOf' :: Pattern -> Int -> String -> Maybe Int
```

Returns the index of the last occurrence of the pattern in the
given string, starting at the specified index and searching
backwards towards the beginning of the string.

Starting at a negative index is equivalent to starting at 0 and
starting at an index greater than the string length is equivalent
to searching in the whole string.

Returns `Nothing` if there is no match.

```purescript
lastIndexOf' (Pattern "a") (-1) "ababa" == Just 0
lastIndexOf' (Pattern "a") 1 "ababa" == Just 0
lastIndexOf' (Pattern "a") 3 "ababa" == Just 2
lastIndexOf' (Pattern "a") 4 "ababa" == Just 4
lastIndexOf' (Pattern "a") 5 "ababa" == Just 4
```


#### `take`

``` purescript
take :: Int -> String -> String
```

Returns the first `n` characters of the string.

```purescript
take 5 "Hello World" == "Hello"
```


#### `takeRight`

``` purescript
takeRight :: Int -> String -> String
```

Returns the last `n` characters of the string.

```purescript
takeRight 5 "Hello World" == "World"
```


#### `takeWhile`

``` purescript
takeWhile :: (Char -> Boolean) -> String -> String
```

Returns the longest prefix (possibly empty) of characters that satisfy
the predicate.

```purescript
takeWhile (_ /= ':') "http://purescript.org" == "http"
```


#### `drop`

``` purescript
drop :: Int -> String -> String
```

Returns the string without the first `n` characters.

```purescript
drop 6 "Hello World" == "World"
```


#### `dropRight`

``` purescript
dropRight :: Int -> String -> String
```

Returns the string without the last `n` characters.

```purescript
dropRight 6 "Hello World" == "Hello"
```


#### `dropWhile`

``` purescript
dropWhile :: (Char -> Boolean) -> String -> String
```

Returns the suffix remaining after `takeWhile`.

```purescript
dropWhile (_ /= '.') "Test.purs" == ".purs"
```


#### `slice`

``` purescript
slice :: Int -> Int -> String -> String
```

Returns the substring at indices `[begin, end)`.
If either index is negative, it is normalised to `length s - index`,
where `s` is the input string. `""` is returned if either
index is out of bounds or if `begin > end` after normalisation.

```purescript
slice 0 0   "purescript" == ""
slice 0 1   "purescript" == "p"
slice 3 6   "purescript" == "esc"
slice (-4) (-1) "purescript" == "rip"
slice (-4) 3  "purescript" == ""
```

#### `splitAt`

``` purescript
splitAt :: Int -> String -> { after :: String, before :: String }
```

Splits a string into two substrings, where `before` contains the
characters up to (but not including) the given index, and `after` contains
the rest of the string, from that index on.

```purescript
splitAt 2 "Hello World" == { before: "He", after: "llo World"}
splitAt 10 "Hi" == { before: "Hi", after: ""}
```

Thus the length of `(splitAt i s).before` will equal either `i` or
`length s`, if that is shorter. (Or if `i` is negative the length will be
0.)

In code:
```purescript
length (splitAt i s).before == min (max i 0) (length s)
(splitAt i s).before <> (splitAt i s).after == s
splitAt i s == {before: take i s, after: drop i s}
```



## Module Data.String.Common

#### `null`

``` purescript
null :: String -> Boolean
```

Returns `true` if the given string is empty.

```purescript
null "" == true
null "Hi" == false
```

#### `localeCompare`

``` purescript
localeCompare :: String -> String -> Ordering
```

Compare two strings in a locale-aware fashion. This is in contrast to
the `Ord` instance on `String` which treats strings as arrays of code
units:

```purescript
"ä" `localeCompare` "b" == LT
"ä" `compare` "b" == GT
```

#### `replace`

``` purescript
replace :: Pattern -> Replacement -> String -> String
```

Replaces the first occurence of the pattern with the replacement string.

```purescript
replace (Pattern "<=") (Replacement "≤") "a <= b <= c" == "a ≤ b <= c"
```

#### `replaceAll`

``` purescript
replaceAll :: Pattern -> Replacement -> String -> String
```

Replaces all occurences of the pattern with the replacement string.

```purescript
replaceAll (Pattern "<=") (Replacement "≤") "a <= b <= c" == "a ≤ b ≤ c"
```

#### `split`

``` purescript
split :: Pattern -> String -> Array String
```

Returns the substrings of the second string separated along occurences
of the first string.

```purescript
split (Pattern " ") "hello world" == ["hello", "world"]
```

#### `toLower`

``` purescript
toLower :: String -> String
```

Returns the argument converted to lowercase.

```purescript
toLower "hElLo" == "hello"
```

#### `toUpper`

``` purescript
toUpper :: String -> String
```

Returns the argument converted to uppercase.

```purescript
toUpper "Hello" == "HELLO"
```

#### `trim`

``` purescript
trim :: String -> String
```

Removes whitespace from the beginning and end of a string, including
[whitespace characters](http://www.ecma-international.org/ecma-262/5.1/#sec-7.2)
and [line terminators](http://www.ecma-international.org/ecma-262/5.1/#sec-7.3).

```purescript
trim "   Hello  \n World\n\t    " == "Hello  \n World"
```

#### `joinWith`

``` purescript
joinWith :: String -> Array String -> String
```

Joins the strings in the array together, inserting the first argument
as separator between them.

```purescript
joinWith ", " ["apple", "banana", "orange"] == "apple, banana, orange"
```



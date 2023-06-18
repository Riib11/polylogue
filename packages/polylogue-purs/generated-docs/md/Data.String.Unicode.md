## Module Data.String.Unicode

#### `toUpper`

``` purescript
toUpper :: String -> String
```

Convert each code point in the string to its corresponding uppercase
sequence. This is the full (locale-independent) Unicode algorithm,
and may map single code points to more than one code point. For example,
`toUpper "ß" == "SS"`.

Because this matches on more rules, it may be slower than `toUpperSimple`,
but it provides more correct results.

#### `toLower`

``` purescript
toLower :: String -> String
```

Convert each code point in the string to its corresponding lower
sequence. This is the full (locale-independent) Unicode algorithm,
and may map single code points to more than one code point. For example,
`toLower "\x0130" == "\x0069\x0307"`.

Because this matches on more rules, it may be slower than `toLowerSimple`,
but it provides more correct results.

#### `caseFold`

``` purescript
caseFold :: String -> String
```

The full Unicode case folding algorithm, may increase the length of the
string by mapping individual code points to longer sequences.

#### `caselessMatch`

``` purescript
caselessMatch :: String -> String -> Boolean
```

Caseless matching, based on `caseFold`.

#### `toUpperSimple`

``` purescript
toUpperSimple :: String -> String
```

Convert each code point in the string to its corresponding uppercase
code point. This will preserve the number of code points in the string.

Note: this is not the full Unicode algorithm, see `toUpper`.

#### `toLowerSimple`

``` purescript
toLowerSimple :: String -> String
```

Convert each code point in the string to its corresponding lowercase
code point. This will preserve the number of code points in the string.

Note: this is not the full Unicode algorithm, see `toLower`.

#### `caseFoldSimple`

``` purescript
caseFoldSimple :: String -> String
```

Convert each code point in the string to its corresponding case-folded
code point. This will preserve the number of code points in the string.

Note: this is not the full Unicode algorithm, see `caseFold`.



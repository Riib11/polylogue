## Module Data.String.Regex.Unsafe

#### `unsafeRegex`

``` purescript
unsafeRegex :: String -> RegexFlags -> Regex
```

Constructs a `Regex` from a pattern string and flags. Fails with
an exception if the pattern contains a syntax error.



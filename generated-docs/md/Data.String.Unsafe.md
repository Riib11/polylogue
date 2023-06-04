## Module Data.String.Unsafe

Unsafe string and character functions.

#### `char`

``` purescript
char :: String -> Char
```

Converts a string of length `1` to a character.

**Unsafe:** throws runtime exception if length is not `1`.

#### `charAt`

``` purescript
charAt :: Int -> String -> Char
```

Returns the character at the given index.

**Unsafe:** throws runtime exception if the index is out of bounds.



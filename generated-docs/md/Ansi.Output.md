## Module Ansi.Output

Convenience functions to simplify outputting ANSI escape codes to
terminals.

#### `withGraphics`

``` purescript
withGraphics :: NonEmptyList GraphicsParam -> String -> String
```

Wrap the given text in escape codes corresponding to the given parameters.
For example:

```purescript
Console.log $ withGraphics (bold <> underline <> foreground BrightRed) "hello world"
```

would print "hello world" to the terminal, bold, underlined, and in bright
red, and then reset (so that further logging to the console uses the
normal color and style).

This function simply wraps the given text in an escape code and a reset
code, so that it is a little more comfortable to use than the functions
in `Ansi.Codes`.

#### `bold`

``` purescript
bold :: NonEmptyList GraphicsParam
```

#### `dim`

``` purescript
dim :: NonEmptyList GraphicsParam
```

#### `italic`

``` purescript
italic :: NonEmptyList GraphicsParam
```

#### `underline`

``` purescript
underline :: NonEmptyList GraphicsParam
```

#### `inverse`

``` purescript
inverse :: NonEmptyList GraphicsParam
```

#### `strikethrough`

``` purescript
strikethrough :: NonEmptyList GraphicsParam
```

#### `foreground`

``` purescript
foreground :: Color -> NonEmptyList GraphicsParam
```

#### `background`

``` purescript
background :: Color -> NonEmptyList GraphicsParam
```



## Module Ansi.Codes

This module defines a data type representing ANSI escape codes, as well as
functions for serialising them as Strings.

#### `prefix`

``` purescript
prefix :: String
```

The prefix for all escape codes.

#### `colorSuffix`

``` purescript
colorSuffix :: String
```

The suffix for escape codes; note that this is only required for colors.

#### `EscapeCode`

``` purescript
data EscapeCode
  = Up Int
  | Down Int
  | Forward Int
  | Back Int
  | NextLine Int
  | PreviousLine Int
  | HorizontalAbsolute Int
  | Position Int Int
  | EraseData EraseParam
  | EraseLine EraseParam
  | ScrollUp Int
  | ScrollDown Int
  | Graphics (NonEmptyList GraphicsParam)
  | SavePosition
  | RestorePosition
  | QueryPosition
  | HideCursor
  | ShowCursor
```

An ANSI escape code. Not all sequences are implemented.
See: <https://en.wikipedia.org/wiki/ANSI_escape_code>.

##### Instances
``` purescript
Generic EscapeCode _
Eq EscapeCode
Ord EscapeCode
Show EscapeCode
```

#### `escapeCodeToString`

``` purescript
escapeCodeToString :: EscapeCode -> String
```

Convert an escape code to the form recognised by terminals.

#### `EraseParam`

``` purescript
data EraseParam
  = ToEnd
  | FromBeginning
  | Entire
```

Specifies how much text to erase.

* ToEnd: erase from the cursor to the end of the line or screen.
* FromBeginning: erase to the cursor from the beginning of the line or
   screen.
* Entire: erase the entire line or screen.

##### Instances
``` purescript
Generic EraseParam _
Eq EraseParam
Ord EraseParam
Show EraseParam
```

#### `eraseParamToString`

``` purescript
eraseParamToString :: EraseParam -> String
```

#### `GraphicsParam`

``` purescript
data GraphicsParam
  = Reset
  | PMode RenderingMode
  | PForeground Color
  | PBackground Color
```

A graphics parameter, controls how text appears; for example, bold,
underlined, foreground color, background color.

##### Instances
``` purescript
Generic GraphicsParam _
Eq GraphicsParam
Ord GraphicsParam
Show GraphicsParam
```

#### `graphicsParamToString`

``` purescript
graphicsParamToString :: GraphicsParam -> String
```

#### `RenderingMode`

``` purescript
data RenderingMode
  = Bold
  | Dim
  | Italic
  | Underline
  | Inverse
  | Strikethrough
```

##### Instances
``` purescript
Generic RenderingMode _
Eq RenderingMode
Ord RenderingMode
Show RenderingMode
```

#### `codeForRenderingMode`

``` purescript
codeForRenderingMode :: RenderingMode -> Int
```

#### `Color`

``` purescript
data Color
  = Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White
  | BrightBlack
  | BrightRed
  | BrightGreen
  | BrightYellow
  | BrightBlue
  | BrightMagenta
  | BrightCyan
  | BrightWhite
```

The standard set of 16 ANSI colors.

##### Instances
``` purescript
Generic Color _
Eq Color
Ord Color
Show Color
```

#### `colorCode`

``` purescript
colorCode :: Color -> Int
```



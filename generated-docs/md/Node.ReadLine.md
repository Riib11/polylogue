## Module Node.ReadLine

This module provides a binding to the Node `readline` API.

#### `Interface`

``` purescript
data Interface
```

A handle to a console interface.

A handle can be created with the `createInterface` function.

#### `InterfaceOptions`

``` purescript
data InterfaceOptions
```

Options passed to `readline`'s `createInterface`

#### `Completer`

``` purescript
type Completer = String -> Effect { completions :: Array String, matched :: String }
```

A function which performs tab completion.

This function takes the partial command as input, and returns a collection of
completions, as well as the matched portion of the input string.

#### `LineHandler`

``` purescript
type LineHandler a = String -> Effect a
```

A function which handles each line of input.

#### `createInterface`

``` purescript
createInterface :: forall r. Readable r -> Options InterfaceOptions -> Effect Interface
```

Builds an interface with the specified options.

#### `createConsoleInterface`

``` purescript
createConsoleInterface :: Completer -> Effect Interface
```

Create an interface with the specified completion function.

#### `output`

``` purescript
output :: forall w. Option InterfaceOptions (Writable w)
```

#### `completer`

``` purescript
completer :: Option InterfaceOptions Completer
```

#### `terminal`

``` purescript
terminal :: Option InterfaceOptions Boolean
```

#### `historySize`

``` purescript
historySize :: Option InterfaceOptions Int
```

#### `noCompletion`

``` purescript
noCompletion :: Completer
```

A completion function which offers no completions.

#### `prompt`

``` purescript
prompt :: Interface -> Effect Unit
```

Prompt the user for input on the specified `Interface`.

#### `setPrompt`

``` purescript
setPrompt :: String -> Interface -> Effect Unit
```

Set the prompt.

#### `setLineHandler`

``` purescript
setLineHandler :: forall a. LineHandler a -> Interface -> Effect Unit
```

Set the current line handler function.

#### `close`

``` purescript
close :: Interface -> Effect Unit
```

Close the specified `Interface`.

#### `question`

``` purescript
question :: String -> (String -> Effect Unit) -> Interface -> Effect Unit
```

Writes a query to the output, waits
for user input to be provided on input, then invokes
the callback function



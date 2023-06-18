## Module Effect.Exception

This module defines an effect, actions and handlers for working
with JavaScript exceptions.

#### `Error`

``` purescript
data Error
```

The type of JavaScript errors

##### Instances
``` purescript
Show Error
```

#### `error`

``` purescript
error :: String -> Error
```

Create a JavaScript error, specifying a message

#### `message`

``` purescript
message :: Error -> String
```

Get the error message from a JavaScript error

#### `name`

``` purescript
name :: Error -> String
```

Get the error name when defined, or fallback to 'Error'

#### `stack`

``` purescript
stack :: Error -> Maybe String
```

Get the stack trace from a JavaScript error

#### `throwException`

``` purescript
throwException :: forall a. Error -> Effect a
```

Throw an exception

For example:

```purescript
main = do
  x <- readNumber
  when (x < 0) $ throwException $
    error "Expected a non-negative number"
```

#### `catchException`

``` purescript
catchException :: forall a. (Error -> Effect a) -> Effect a -> Effect a
```

Catch an exception by providing an exception handler.

For example:

```purescript
main = catchException Console.logShow do
  Console.log "Exceptions thrown in this block will be logged to the console"
```

#### `throw`

``` purescript
throw :: forall a. String -> Effect a
```

A shortcut allowing you to throw an error in one step. Defined as
`throwException <<< error`.

#### `try`

``` purescript
try :: forall a. Effect a -> Effect (Either Error a)
```

Runs an Eff and returns eventual Exceptions as a `Left` value. If the
computation succeeds the result gets wrapped in a `Right`.

For example:

```purescript
main :: Effect Unit
main = do
  result <- try (readTextFile UTF8 "README.md")
  case result of
    Right lines ->
      Console.log ("README: \n" <> lines )
    Left error ->
      Console.error ("Couldn't open README.md. Error was: " <> show error)
```



## Module Parsing

Types and operations for monadic parsing.

Combinators are in the `Parsing.Combinators` module.

Primitive parsers for `String` input streams are in the `Parsing.String`
module.

#### `Parser`

``` purescript
type Parser s = ParserT s Identity
```

The `Parser s` monad, where `s` is the type of the input stream.

A synonym for the `ParserT` monad transformer applied
to the `Identity` monad.

#### `runParser`

``` purescript
runParser :: forall s a. s -> Parser s a -> Either ParseError a
```

Run a parser on an input stream `s` and produce either an error or the
result `a` of the parser.

#### `ParserT`

``` purescript
newtype ParserT s m a
  = ParserT (forall r. Fn5 (ParseState s) ((Unit -> r) -> r) (m (Unit -> r) -> r) (Fn2 (ParseState s) ParseError r) (Fn2 (ParseState s) a r) r)
```

The `Parser s` monad with a monad transformer parameter `m`.

##### Instances
``` purescript
Lazy (ParserT s m a)
(Semigroup a) => Semigroup (ParserT s m a)
(Monoid a) => Monoid (ParserT s m a)
Functor (ParserT s m)
Apply (ParserT s m)
Applicative (ParserT s m)
Bind (ParserT s m)
Monad (ParserT s m)
MonadRec (ParserT s m)
(MonadState t m) => MonadState t (ParserT s m)
(MonadAsk r m) => MonadAsk r (ParserT s m)
(MonadReader r m) => MonadReader r (ParserT s m)
MonadThrow ParseError (ParserT s m)
MonadError ParseError (ParserT s m)
Alt (ParserT s m)
Plus (ParserT s m)
Alternative (ParserT s m)
MonadPlus (ParserT s m)
MonadTrans (ParserT s)
```

#### `runParserT`

``` purescript
runParserT :: forall m s a. MonadRec m => s -> ParserT s m a -> m (Either ParseError a)
```

`runParser` with a monad transfomer parameter `m`.

#### `runParserT'`

``` purescript
runParserT' :: forall m s a. MonadRec m => ParseState s -> ParserT s m a -> m (Tuple (Either ParseError a) (ParseState s))
```

Run a parser and produce either an error or the result of the parser
along with the internal state of the parser when it finishes.

#### `ParseError`

``` purescript
data ParseError
  = ParseError String Position
```

A parsing error, consisting of an error message and
the position in the input stream at which the error occurred.

##### Instances
``` purescript
Show ParseError
Eq ParseError
Ord ParseError
MonadThrow ParseError (ParserT s m)
MonadError ParseError (ParserT s m)
```

#### `parseErrorMessage`

``` purescript
parseErrorMessage :: ParseError -> String
```

Get the `Message` from a `ParseError`

#### `parseErrorPosition`

``` purescript
parseErrorPosition :: ParseError -> Position
```

Get the `Position` from a `ParseError`.

#### `Position`

``` purescript
newtype Position
  = Position { column :: Int, index :: Int, line :: Int }
```

`Position` represents the position of the parser in the input stream.

- `index` is the position offset since the start of the input. Starts
  at *0*.
- `line` is the current line in the input. Starts at *1*.
- `column` is the column of the next character in the current line that
  will be parsed. Starts at *1*.

##### Instances
``` purescript
Generic Position _
Show Position
Eq Position
Ord Position
```

#### `initialPos`

``` purescript
initialPos :: Position
```

The `Position` before any input has been parsed.

`{ index: 0, line: 1, column: 1 }`

#### `consume`

``` purescript
consume :: forall s m. ParserT s m Unit
```

Set the consumed flag.

Setting the consumed flag means that we're committed to this parsing branch
of an alternative (`<|>`), so that if this branch fails then we want to
fail the entire parse instead of trying the other alternative.

#### `position`

``` purescript
position :: forall s m. ParserT s m Position
```

Returns the current position in the stream.

#### `fail`

``` purescript
fail :: forall m s a. String -> ParserT s m a
```

Fail with a message.

#### `failWithPosition`

``` purescript
failWithPosition :: forall m s a. String -> Position -> ParserT s m a
```

Fail with a message and a position.

#### `region`

``` purescript
region :: forall m s a. (ParseError -> ParseError) -> ParserT s m a -> ParserT s m a
```

Contextualize parsing failures inside a region. If a parsing failure
occurs, then the `ParseError` will be transformed by each containing
`region` as the parser backs out the call stack.

For example, here’s a helper function `inContext` which uses `region` to
add some string context to the error messages.

```
let
  inContext :: forall s m a. (String -> String) -> ParserT s m a -> ParserT s m a
  inContext context = region \(ParseError message pos) ->
    ParseError (context message) pos

  input = "Tokyo thirty-nine million"

lmap (parseErrorHuman input 30) $ runParser input do
  inContext ("Megacity list: " <> _) do
    cityname <- inContext ("city name: " <> _) (takeWhile isLetter)
    skipSpaces
    population <- inContext ("population: " <> _) intDecimal
    pure $ Tuple cityname population
```
---
```
Megacity list: population: Expected Int at position index:6 (line:1, column:7)
      ▼
Tokyo thirty-nine million
```

#### `liftMaybe`

``` purescript
liftMaybe :: forall s m a. Monad m => (Unit -> String) -> Maybe a -> ParserT s m a
```

Lift a `Maybe a` computation into a `ParserT`, with a note for
the `ParseError` message in case of `Nothing`.

Consumes no parsing input, does not change the parser state at all.
If the `Maybe` computation is `Nothing`, then this will `fail` in the
`ParserT` monad with the given error message `String` at the current input
`Position`.

This is a “validation” function, for when we want to produce some
data from the parsing input or fail at the current
parsing position if that’s impossible.

For example, parse an integer
[`BoundedEnum`](https://pursuit.purescript.org/packages/purescript-enums/docs/Data.Enum#t:BoundedEnum)
code and validate it by turning it
into a `MyEnum`. Use `tryRethrow` to position the parse error at the
beginning of the integer in the input `String` if the `toEnum` fails.

```
runParser "3" do
  myenum :: MyEnum <- tryRethrow do
    x <- intDecimal
    liftMaybe (\_ -> "Bad MyEnum " <> show x) $ toEnum x
```

#### `liftEither`

``` purescript
liftEither :: forall s m a. Monad m => Either String a -> ParserT s m a
```

Lift an `Either String a` computation into a `ParserT`.

Consumes no parsing input, does not change the parser state at all.
If the `Either` computation is `Left String`, then this will `fail` in the
`ParserT` monad at the current input `Position`.

This is a “validation” function, for when we want to produce some
data from the parsing input or fail at the current
parsing position if that’s impossible.

#### `liftExceptT`

``` purescript
liftExceptT :: forall s m a. Monad m => ExceptT String m a -> ParserT s m a
```

Lift an `ExceptT String m a` computation into a `ParserT`.

Consumes no parsing input, does not change the parser state at all.
If the `ExceptT` computation is `Left String`, then this will `fail` in the
`ParserT` monad at the current input `Position`.

This is a “validation” function, for when we want to produce some
data from the parsing input or fail at the current
parsing position if that’s impossible.

#### `ParseState`

``` purescript
data ParseState s
  = ParseState s Position Boolean
```

The internal state of the `ParserT s m` monad.

Contains the remaining input and current position and the consumed flag.

The consumed flag is used to implement the rule for `alt` that
- If the left parser fails *without consuming any input*, then backtrack and try the right parser.
- If the left parser fails and consumes input, then fail immediately.

#### `stateParserT`

``` purescript
stateParserT :: forall s m a. (ParseState s -> Tuple a (ParseState s)) -> ParserT s m a
```

Query and modify the `ParserT` internal state.

Like the `state` member of `MonadState`.

#### `getParserT`

``` purescript
getParserT :: forall s m. ParserT s m (ParseState s)
```

Query the `ParserT` internal state.

Like the `get` member of `MonadState`.

#### `hoistParserT`

``` purescript
hoistParserT :: forall s m n a. (m ~> n) -> ParserT s m a -> ParserT s n a
```

#### `mapParserT`

``` purescript
mapParserT :: forall b n s a m. MonadRec m => Functor n => (m (Tuple (Either ParseError a) (ParseState s)) -> n (Tuple (Either ParseError b) (ParseState s))) -> ParserT s m a -> ParserT s n b
```

Change the underlying monad action `m` and result data type `a` in
a `ParserT s m` monad action.



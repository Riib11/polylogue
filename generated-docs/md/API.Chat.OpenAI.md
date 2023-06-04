## Module API.Chat.OpenAI

#### `gpt_4`

``` purescript
gpt_4 :: Model
```

#### `gpt_3p5_turbo`

``` purescript
gpt_3p5_turbo :: Model
```

#### `models`

``` purescript
models :: Array Model
```

#### `Model`

``` purescript
newtype Model
  = Model String
```

##### Instances
``` purescript
Eq Model
Ord Model
Show Model
Enum Model
Bounded Model
BoundedEnum Model
```

#### `Temperature`

``` purescript
newtype Temperature
  = Temperature Number
```

##### Instances
``` purescript
Refined Number Temperature
```

#### `user`

``` purescript
user :: Role
```

#### `system`

``` purescript
system :: Role
```

#### `assistant`

``` purescript
assistant :: Role
```

#### `roles`

``` purescript
roles :: Array Role
```

#### `Role`

``` purescript
newtype Role
  = Role String
```

##### Instances
``` purescript
Eq Role
Ord Role
Show Role
Enum Role
Bounded Role
BoundedEnum Role
```

#### `Request`

``` purescript
type Request = { messages :: Array Message, model :: Model, temperature :: Temperature }
```

#### `Message`

``` purescript
type Message = { content :: String, role :: Role }
```

#### `prettyMessage`

``` purescript
prettyMessage :: forall t84. { content :: String, role :: Role | t84 } -> String
```

#### `userMessage`

``` purescript
userMessage :: String -> Message
```

#### `assistantMessage`

``` purescript
assistantMessage :: String -> Message
```

#### `systemMessage`

``` purescript
systemMessage :: String -> Message
```

#### `Response`

``` purescript
type Response = { choices :: Array ChatChoice, created :: Number, id :: String, object :: String, usage :: { completion_tokens :: Number, prompt_tokens :: Number, total_tokens :: Number } }
```

#### `ChatChoice`

``` purescript
type ChatChoice = { finish_reason :: String, index :: Int, message :: Message }
```

#### `ChatOptions`

``` purescript
type ChatOptions = { model :: Model, temperature :: Temperature }
```

#### `defaultChatOptions`

``` purescript
defaultChatOptions :: ChatOptions
```

#### `Client`

``` purescript
data Client
```

#### `ClientConfiguration`

``` purescript
type ClientConfiguration = { apiKey :: String, organization :: String }
```

#### `_makeClient`

``` purescript
_makeClient :: ClientConfiguration -> Effect Client
```

#### `makeClient`

``` purescript
makeClient :: Maybe ClientConfiguration -> Effect Client
```

Make a client instance. If no configuration is provided, then use
environment-specified values.

#### `_createCompletion`

``` purescript
_createCompletion :: Client -> Request -> EffectFnAff Response
```

#### `createCompletion`

``` purescript
createCompletion :: forall m. MonadAff m => Client -> Request -> m Response
```

#### `Error`

``` purescript
data Error
  = EmptyResponseChoices
  | BadFinishReason String
```

##### Instances
``` purescript
Generic Error _
Show Error
```

#### `Config`

``` purescript
type Config = { chatOptions :: ChatOptions, client :: Client }
```

#### `_chat`

``` purescript
_chat :: Proxy @Symbol "chat"
```

#### `chat`

``` purescript
chat :: forall m. MonadAff m => Config -> Array Message -> ExceptT Error m Message
```



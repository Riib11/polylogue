## Module AI.Agent.Dialogue

#### `_dialogue`

``` purescript
_dialogue :: Proxy @Symbol "dialogue"
```

A dialogue agent is an agent that can have a conversation with a single
user. It maintains the history of chat messages.

#### `Agent`

``` purescript
type Agent errors m = Agent State errors Query m
```

#### `Input`

``` purescript
type Input = { history :: Array Message, system :: Maybe String }
```

#### `State`

``` purescript
type State = { history :: Array Message }
```

#### `Query`

``` purescript
data Query a
  = Prompt Message (Message -> a)
  | GetHistory (Array Message -> a)
```

##### Instances
``` purescript
Functor Query
```

#### `new`

``` purescript
new :: forall errors m. Monad m => Agent errors m -> Input -> Id State errors Query m
```

#### `define`

``` purescript
define :: forall errors m. Monad m => (NonEmptyArray Message -> M State errors m Message) -> Agent errors m
```



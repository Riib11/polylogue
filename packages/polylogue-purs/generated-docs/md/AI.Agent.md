## Module AI.Agent

#### `Agent`

``` purescript
newtype Agent (state :: Type) (errors :: Row Type) (query :: Type -> Type) (m :: Type -> Type)
```

An agent definition, `Agent` is parameterized by:
 - `state` - the state of the agent
 - `errors` - the errors that the agent can throw
 - `query` - the query that the agent can handle
 - `m` - the monad in which the agent runs

An agent definition is defined by how the agent handles queries. Each
instance of an agent, identified by an `Id`, has its own state and handles
queries indepentently of other instances of the same agent.

#### `M`

``` purescript
type M state errors m = StateT state (ExceptT (Variant errors) m)
```

`M` is an alias for the monad in an `Agent` handles queries.

#### `define`

``` purescript
define :: forall state161 errors162 query163 m164. (forall a. query163 a -> StateT state161 (ExceptT (Variant errors162) m164) a) -> Agent state161 errors162 query163 m164
```

Makes an agent definition.

#### `Id`

``` purescript
newtype Id (state :: Type) (errors :: Row Type) (query :: Type -> Type) (m :: Type -> Type)
```

`Id` is the type of agent ids, which matching parameters to the agent it is
an id for.

##### Instances
``` purescript
Eq (Id state errors query m)
Ord (Id state errors query m)
```

#### `new`

``` purescript
new :: forall state errors query m. Agent state errors query m -> state -> Id state errors query m
```

Makes a new agent instance from an agent definition, and outputs the new
instances' id.

#### `query`

``` purescript
query :: forall state errors query m a. Monad m => Id state errors query m -> query a -> ExceptT (Variant errors) m a
```

Sends a query to an agent instance, and yields the result.

#### `ask`

``` purescript
ask :: forall state errors query m a. Monad m => Id state errors query m -> ((a -> a) -> query a) -> ExceptT (Variant errors) m a
```

Queries an agent instance with an "ask"-style query, which is a query that
is intended to just get a result from the agent. For example:
```purescript
data Query a = GetState (String -> a)

getState agent_id = ask agent_id GetState
```

#### `tell`

``` purescript
tell :: forall state errors query m a. Monad m => Id state errors query m -> (Unit -> query a) -> ExceptT (Variant errors) m Unit
```

Queries an agent with a "tell"-style query, which is a query that is
intended to just prompt the agent and not get a result. For example:
```purescript
data Query a = SetState String a

setState agent_id state = tell agent_id $ SetState state
```



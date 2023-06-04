## Module AI.Agent

#### `Agent`

``` purescript
newtype Agent (state :: Type) (errors :: Row Type) (query :: Type -> Type) (m :: Type -> Type)
```

#### `M`

``` purescript
type M state errors m = StateT state (ExceptT (Variant errors) m)
```

#### `define`

``` purescript
define :: forall (state161 :: Type) (errors162 :: Row Type) (query163 :: Type -> Type) (m164 :: Type -> Type). (forall (a :: Type). query163 a -> StateT state161 (ExceptT (Variant errors162) m164) a) -> Agent state161 errors162 query163 m164
```

#### `Id`

``` purescript
newtype Id (state :: Type) (errors :: Row Type) (query :: Type -> Type) (m :: Type -> Type)
```

##### Instances
``` purescript
Eq (Id state errors query m)
Ord (Id state errors query m)
```

#### `new`

``` purescript
new :: forall (state :: Type) (errors :: Row Type) (query :: Type -> Type) (m :: Type -> Type). Agent state errors query m -> state -> Id state errors query m
```

#### `query`

``` purescript
query :: forall state errors query m a. Monad m => Id state errors query m -> query a -> ExceptT (Variant errors) m a
```

#### `ask`

``` purescript
ask :: forall (state168 :: Type) (errors169 :: Row Type) (query170 :: Type -> Type) (m171 :: Type -> Type) (a172 :: Type) (t27173 :: Type) (a174 :: t27173 -> t27173 -> Type) (t175 :: t27173). Monad m171 => Category @t27173 a174 => Id state168 errors169 query170 m171 -> (a174 t175 t175 -> query170 a172) -> ExceptT (Variant errors169) m171 a172
```

#### `tell`

``` purescript
tell :: forall (t152 :: Type) (state153 :: Type) (errors154 :: Row Type) (query155 :: Type -> Type) (m156 :: Type -> Type). Functor m156 => Monad m156 => Id state153 errors154 query155 m156 -> (Unit -> query155 t152) -> ExceptT (Variant errors154) m156 Unit
```



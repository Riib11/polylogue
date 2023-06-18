## Module Dotenv.Internal.Types

This module contains data types representing `.env` settings.

#### `Name`

``` purescript
type Name = String
```

The name of a setting name

#### `ResolvedValue`

``` purescript
type ResolvedValue = Maybe String
```

The type of a resolved value

#### `Setting`

``` purescript
type Setting v = Tuple Name v
```

The product of a setting name and the corresponding value

#### `UnresolvedValue`

``` purescript
data UnresolvedValue
  = LiteralValue String
  | VariableSubstitution String
  | CommandSubstitution String (Array String)
  | ValueExpression (Array UnresolvedValue)
```

The expressed value of a setting, which has not been resolved yet

##### Instances
``` purescript
Eq UnresolvedValue
Show UnresolvedValue
```



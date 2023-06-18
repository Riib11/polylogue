## Module Dotenv

This is the base module for the Dotenv library.

#### `Name`

``` purescript
type Name = String
```

The type of a setting name

#### `Setting`

``` purescript
type Setting = Tuple Name Value
```

The type of a setting

#### `Settings`

``` purescript
type Settings = Array Setting
```

The type of settings

#### `Value`

``` purescript
type Value = Maybe String
```

The type of a (resolved) value

#### `loadFile`

``` purescript
loadFile :: Aff Unit
```

Loads the `.env` file into the environment.

#### `loadContents`

``` purescript
loadContents :: String -> Aff Unit
```

Loads a `.env`-compatible string into the environment. This is useful when
sourcing configuration from somewhere other than a local `.env` file.



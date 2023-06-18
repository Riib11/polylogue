## Module Test.Spec.Assertions.String

#### `shouldContain`

``` purescript
shouldContain :: forall m. MonadThrow Error m => String -> String -> m Unit
```

Asserts `string` contains `subs`

```purescript
string `shouldContain` subs
```

#### `shouldNotContain`

``` purescript
shouldNotContain :: forall m. MonadThrow Error m => String -> String -> m Unit
```

Asserts `string` does not contain `subs`

```purescript
string `shouldContain` subs
```

#### `shouldStartWith`

``` purescript
shouldStartWith :: forall m. MonadThrow Error m => String -> String -> m Unit
```

Asserts `string` starts with `prefix`

```purescript
string `shouldStartWith` prefix
```

#### `shouldEndWith`

``` purescript
shouldEndWith :: forall m. MonadThrow Error m => String -> String -> m Unit
```

Asserts `string` ends with `suffix`

```purescript
string `shouldEndWith` suffix
```



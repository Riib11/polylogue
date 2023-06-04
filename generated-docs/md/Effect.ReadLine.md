## Module Effect.ReadLine

#### `ReadLine`

``` purescript
newtype ReadLine a
  = ReadLine (Effect a)
```

##### Instances
``` purescript
Functor ReadLine
Apply ReadLine
Applicative ReadLine
Bind ReadLine
Monad ReadLine
```

#### `runReadLine`

``` purescript
runReadLine :: forall a. ReadLine a -> Effect a
```

#### `readLine`

``` purescript
readLine :: ReadLine String
```



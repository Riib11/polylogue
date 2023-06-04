## Module Effect.Unsafe

#### `unsafePerformEffect`

``` purescript
unsafePerformEffect :: forall a. Effect a -> a
```

Run an effectful computation.

*Note*: use of this function can result in arbitrary side-effects.



## Module Test.Spec.Summary

#### `Summary`

``` purescript
newtype Summary
  = Count { failed :: Int, passed :: Int, pending :: Int }
```

##### Instances
``` purescript
Newtype Summary _
Semigroup Summary
Monoid Summary
```

#### `summarize`

``` purescript
summarize :: forall a. Array (Tree a Result) -> Summary
```

#### `successful`

``` purescript
successful :: forall a. Array (Tree a Result) -> Boolean
```



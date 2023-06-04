## Module Data.Profunctor.Split

#### `Split`

``` purescript
newtype Split f a b
```

##### Instances
``` purescript
Functor (Split f a)
Profunctor (Split f)
```

#### `split`

``` purescript
split :: forall f a b x. (a -> x) -> (x -> b) -> f x -> Split f a b
```

#### `unSplit`

``` purescript
unSplit :: forall f a b r. (forall x. (a -> x) -> (x -> b) -> f x -> r) -> Split f a b -> r
```

#### `liftSplit`

``` purescript
liftSplit :: forall f a. f a -> Split f a a
```

#### `lowerSplit`

``` purescript
lowerSplit :: forall f a. Invariant f => Split f a a -> f a
```

#### `hoistSplit`

``` purescript
hoistSplit :: forall f g a b. (f ~> g) -> Split f a b -> Split g a b
```



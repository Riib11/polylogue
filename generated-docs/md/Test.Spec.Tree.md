## Module Test.Spec.Tree

#### `Tree`

``` purescript
data Tree c a
  = Node (Either String c) (Array (Tree c a))
  | Leaf String (Maybe a)
```

##### Instances
``` purescript
(Show c, Show a) => Show (Tree c a)
(Eq c, Eq a) => Eq (Tree c a)
Bifunctor Tree
Foldable (Tree c)
```

#### `Item`

``` purescript
newtype Item m a
  = Item { example :: (ActionWith m a -> m Unit) -> m Unit, isFocused :: Boolean, isParallelizable :: Maybe Boolean }
```

##### Instances
``` purescript
Newtype (Item m a) _
Show (Item m a)
Eq (Item m a)
```

#### `ActionWith`

``` purescript
type ActionWith m a = a -> m Unit
```

#### `bimapTree`

``` purescript
bimapTree :: forall a b c d. (Array String -> a -> b) -> (NonEmptyArray String -> c -> d) -> Tree a c -> Tree b d
```

#### `countTests`

``` purescript
countTests :: forall c t. Array (Tree c t) -> Int
```

Count the total number of tests in a spec

#### `isAllParallelizable`

``` purescript
isAllParallelizable :: forall c m a. Tree c (Item m a) -> Boolean
```

Return true if all items in the tree are parallelizable

#### `discardUnfocused`

``` purescript
discardUnfocused :: forall c m a. Array (Tree c (Item m a)) -> Array (Tree c (Item m a))
```

If there is at least one focused element, all paths which don't
lead to a focused element will be remove. otherwise input will
be returned as unchanged.

#### `modifyAroundAction`

``` purescript
modifyAroundAction :: forall g a b. (ActionWith g a -> ActionWith g b) -> Item g a -> Item g b
```

Modify around action of an Item

#### `PathItem`

``` purescript
newtype PathItem
  = PathItem { index :: Int, name :: Maybe String }
```

##### Instances
``` purescript
Newtype PathItem _
Show PathItem
Eq PathItem
Ord PathItem
```

#### `Path`

``` purescript
type Path = Array PathItem
```

#### `parentSuiteName`

``` purescript
parentSuiteName :: Path -> Array String
```

#### `parentSuite`

``` purescript
parentSuite :: Path -> Maybe { name :: String, path :: Path }
```



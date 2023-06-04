## Module Control.Comonad.Cofree.Class

#### `ComonadCofree`

``` purescript
class (Functor f, Comonad w) <= ComonadCofree f w | w -> f where
  unwrapCofree :: forall a. w a -> f (w a)
```

Based on <http://hackage.haskell.org/package/free/docs/Control-Comonad-Cofree-Class.html>

##### Instances
``` purescript
(Functor f) => ComonadCofree f (Cofree f)
(Functor f, ComonadCofree f w) => ComonadCofree f (EnvT e w)
(Functor f, ComonadCofree f w) => ComonadCofree f (StoreT s w)
(Functor f, ComonadCofree f w, Monoid m) => ComonadCofree f (TracedT m w)
```



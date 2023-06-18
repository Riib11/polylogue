## Module Data.String.Pattern

#### `Pattern`

``` purescript
newtype Pattern
  = Pattern String
```

A newtype used in cases where there is a string to be matched.

```purescript
pursPattern = Pattern ".purs"
--can be used like this:
contains pursPattern "Test.purs"
   == true
```


##### Instances
``` purescript
Eq Pattern
Ord Pattern
Newtype Pattern _
Show Pattern
```

#### `Replacement`

``` purescript
newtype Replacement
  = Replacement String
```

A newtype used in cases to specify a replacement for a pattern.

##### Instances
``` purescript
Eq Replacement
Ord Replacement
Newtype Replacement _
Show Replacement
```



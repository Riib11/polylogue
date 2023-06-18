## Module Data.String.Regex.Flags

#### `RegexFlagsRec`

``` purescript
type RegexFlagsRec = { dotAll :: Boolean, global :: Boolean, ignoreCase :: Boolean, multiline :: Boolean, sticky :: Boolean, unicode :: Boolean }
```

#### `RegexFlags`

``` purescript
newtype RegexFlags
  = RegexFlags RegexFlagsRec
```

Flags that control matching.

##### Instances
``` purescript
Newtype RegexFlags _
Semigroup RegexFlags
Monoid RegexFlags
Eq RegexFlags
Show RegexFlags
```

#### `noFlags`

``` purescript
noFlags :: RegexFlags
```

All flags set to false.

#### `global`

``` purescript
global :: RegexFlags
```

Only global flag set to true

#### `ignoreCase`

``` purescript
ignoreCase :: RegexFlags
```

Only ignoreCase flag set to true

#### `multiline`

``` purescript
multiline :: RegexFlags
```

Only multiline flag set to true

#### `sticky`

``` purescript
sticky :: RegexFlags
```

Only sticky flag set to true

#### `unicode`

``` purescript
unicode :: RegexFlags
```

Only unicode flag set to true

#### `dotAll`

``` purescript
dotAll :: RegexFlags
```

Only dotAll flag set to true



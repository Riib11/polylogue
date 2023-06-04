## Module Node.FS.Stats

#### `Stats`

``` purescript
data Stats
  = Stats StatsObj
```

Stats wrapper to provide a usable interface to the underlying properties and methods.

##### Instances
``` purescript
Show Stats
```

#### `StatsObj`

``` purescript
type StatsObj = { atime :: JSDate, ctime :: JSDate, dev :: Number, gid :: Number, ino :: Number, isBlockDevice :: Fn0 Boolean, isCharacterDevice :: Fn0 Boolean, isDirectory :: Fn0 Boolean, isFIFO :: Fn0 Boolean, isFile :: Fn0 Boolean, isSocket :: Fn0 Boolean, mode :: Number, mtime :: JSDate, nlink :: Number, rdev :: Number, size :: Number, uid :: Number }
```

#### `isFile`

``` purescript
isFile :: Stats -> Boolean
```

#### `isDirectory`

``` purescript
isDirectory :: Stats -> Boolean
```

#### `isBlockDevice`

``` purescript
isBlockDevice :: Stats -> Boolean
```

#### `isCharacterDevice`

``` purescript
isCharacterDevice :: Stats -> Boolean
```

#### `isFIFO`

``` purescript
isFIFO :: Stats -> Boolean
```

#### `isSocket`

``` purescript
isSocket :: Stats -> Boolean
```

#### `isSymbolicLink`

``` purescript
isSymbolicLink :: Stats -> Boolean
```

#### `accessedTime`

``` purescript
accessedTime :: Stats -> DateTime
```

#### `modifiedTime`

``` purescript
modifiedTime :: Stats -> DateTime
```

#### `statusChangedTime`

``` purescript
statusChangedTime :: Stats -> DateTime
```



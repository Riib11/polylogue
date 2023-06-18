## Module Node.FS.Perms

#### `Perm`

``` purescript
newtype Perm
```

A `Perm` value specifies what is allowed to be done with a particular
file by a particular class of user &mdash; that is, whether it is
readable, writable, and/or executable. It has a `Semiring` instance, which
allows you to combine permissions:

- `(+)` adds `Perm` values together. For example, `read + write` means
  "readable and writable".
- `(*)` masks permissions. It can be thought of as selecting only the
   permissions that two `Perm` values have in common. For example:
   `(read + write) * (write + execute) == write`.

You can think also of a `Perm` value as a subset of the set
`{ read, write, execute }`; then, `(+)` and `(*)` represent set union and
intersection respectively.

##### Instances
``` purescript
Eq Perm
Ord Perm
Show Perm
Semiring Perm
```

#### `mkPerm`

``` purescript
mkPerm :: Boolean -> Boolean -> Boolean -> Perm
```

Create a `Perm` value. The arguments represent the readable, writable, and
executable permissions, in that order.

#### `none`

``` purescript
none :: Perm
```

No permissions. This is the identity of the `Semiring` operation `(+)`
for `Perm`; that is, it is the same as `zero`.

#### `read`

``` purescript
read :: Perm
```

The "readable" permission.

#### `write`

``` purescript
write :: Perm
```

The "writable" permission.

#### `execute`

``` purescript
execute :: Perm
```

The "executable" permission.

#### `all`

``` purescript
all :: Perm
```

All permissions: readable, writable, and executable. This is the identity
of the `Semiring` operation `(*)` for `Perm`; that is, it is the same as
`one`.

#### `Perms`

``` purescript
newtype Perms
```

A `Perms` value includes all the permissions information about a
particular file or directory, by storing a `Perm` value for each of the
file owner, the group, and any other users.

##### Instances
``` purescript
Eq Perms
Ord Perms
Show Perms
```

#### `mkPerms`

``` purescript
mkPerms :: Perm -> Perm -> Perm -> Perms
```

Create a `Perms` value. The arguments represent the owner's, group's, and
other users' permission sets, respectively.

#### `permsAll`

``` purescript
permsAll :: Perms
```

#### `permsReadWrite`

``` purescript
permsReadWrite :: Perms
```

#### `permsFromString`

``` purescript
permsFromString :: String -> Maybe Perms
```

Attempt to parse a `Perms` value from a `String` containing an octal
integer. For example,
`permsFromString "0644" == Just (mkPerms (read + write) read read)`.

#### `permsToString`

``` purescript
permsToString :: Perms -> String
```

Convert a `Perms` value to an octal string, in a format similar to that
accepted by `chmod`. For example:
`permsToString (mkPerms (read + write) read read) == "0644"`

#### `permsToInt`

``` purescript
permsToInt :: Perms -> Int
```

Convert a `Perms` value to an `Int`, via `permsToString`.



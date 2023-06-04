## Module Node.Platform

This module defines data type for the different platforms supported by
Node.js

#### `Platform`

``` purescript
data Platform
  = AIX
  | Darwin
  | FreeBSD
  | Linux
  | OpenBSD
  | SunOS
  | Win32
  | Android
```

See [the Node docs](https://nodejs.org/dist/latest-v6.x/docs/api/os.html#os_os_platform).

##### Instances
``` purescript
Show Platform
Eq Platform
Ord Platform
```

#### `toString`

``` purescript
toString :: Platform -> String
```

The String representation for a platform, recognised by Node.js.

#### `fromString`

``` purescript
fromString :: String -> Maybe Platform
```

Attempt to parse a `Platform` value from a string, in the format returned
by Node.js' `process.platform`.



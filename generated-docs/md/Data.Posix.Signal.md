## Module Data.Posix.Signal

#### `Signal`

``` purescript
data Signal
  = SIGABRT
  | SIGALRM
  | SIGBUS
  | SIGCHLD
  | SIGCLD
  | SIGCONT
  | SIGEMT
  | SIGFPE
  | SIGHUP
  | SIGILL
  | SIGINFO
  | SIGINT
  | SIGIO
  | SIGIOT
  | SIGKILL
  | SIGLOST
  | SIGPIPE
  | SIGPOLL
  | SIGPROF
  | SIGPWR
  | SIGQUIT
  | SIGSEGV
  | SIGSTKFLT
  | SIGSTOP
  | SIGSYS
  | SIGTERM
  | SIGTRAP
  | SIGTSTP
  | SIGTTIN
  | SIGTTOU
  | SIGUNUSED
  | SIGURG
  | SIGUSR1
  | SIGUSR2
  | SIGVTALRM
  | SIGWINCH
  | SIGXCPU
  | SIGXFSZ
```

##### Instances
``` purescript
Show Signal
Eq Signal
Ord Signal
```

#### `toString`

``` purescript
toString :: Signal -> String
```

Convert a Signal to a String. Suitable for Node.js APIs.

#### `fromString`

``` purescript
fromString :: String -> Maybe Signal
```

Try to parse a Signal from a String. Suitable for use with Node.js APIs.
This function is a partial inverse of `toString`; in code, that means, for
all `sig :: Signal`:

  `fromString (toString sig) == Just sig`




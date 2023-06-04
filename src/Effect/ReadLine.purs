module Effect.ReadLine where

import Data.Options
import Node.ReadLine
import Prelude

import Effect (Effect)
import Hole (hole)
import Node.Process (stdin, stdout)

newtype ReadLine a = ReadLine (Effect a)

derive newtype instance Functor ReadLine
derive newtype instance Apply ReadLine
derive newtype instance Applicative ReadLine
derive newtype instance Bind ReadLine
derive newtype instance Monad ReadLine

runReadLine :: forall a. ReadLine a -> Effect a
runReadLine (ReadLine a) = a

readLine :: ReadLine String
readLine = ReadLine do
  interface <- createInterface stdin 
    ( output := stdout <> 
      terminal := true  )
  prompt interface
  pure "done"


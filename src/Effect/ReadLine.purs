module Effect.ReadLine where

import Prelude

import Control.Bug (bug)
import Data.Maybe (Maybe(..))
import Data.Options ((:=))
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Ref as Ref
import Node.Process as Process
import Node.ReadLine as ReadLine

{-
TODO: do i actually need this?

newtype ReadLine a = ReadLine (Effect a)

derive newtype instance Functor ReadLine
derive newtype instance Apply ReadLine
derive newtype instance Applicative ReadLine
derive newtype instance Bind ReadLine
derive newtype instance Monad ReadLine

runReadLine :: forall a. ReadLine a -> Effect a
runReadLine (ReadLine a) = a
-}

readLine :: forall m. MonadEffect m => String -> m String
readLine promptStr = liftEffect do
  interface <- ReadLine.createInterface Process.stdin 
    ( ReadLine.output := Process.stdout <> 
      ReadLine.terminal := true )
  -- ReadLine.setPrompt promptStr ">"
  
  -- ReadLine.prompt interface
  -- ReadLine.close interface
  -- pure "done"
  
  answer_ref <- Ref.new Nothing
  ReadLine.question 
    promptStr 
    (pure >>> (_ `Ref.write` answer_ref))
    interface
  Ref.read answer_ref >>= case _ of
    Nothing -> bug "readLine: no answer"
    Just answer -> pure answer


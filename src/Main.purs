module Main where

import Data.Options
import Prelude

import AI.Agent as Agent
import AI.Agent.CommandLine as CommandLine
import Control.Monad.Except (runExceptT)
import Data.Functor.Variant as FV
import Effect as Effect
import Effect.Aff (Aff, launchAff_)
import Effect.Class.Console (log)
import Effect.Class.Console as Console
import Node.Process as Process
import Node.ReadLine as ReadLine

main :: Effect.Effect Unit
main = do
  -- _ <- ReadLine.readLine "hello!"
  launchAff_ do
    let 
      cl :: CommandLine.Agent () () () _
      cl = CommandLine.define FV.case_ 
        { interfaceOptions:
            ReadLine.output := Process.stdout <>
            ReadLine.terminal := true
        , promptString: pure "> " }
      cl_id = CommandLine.new cl {}
    void $ runExceptT do
      Agent.tell cl_id $ CommandLine.open
      reply <- Agent.query cl_id $ CommandLine.question'
        "Enter your name: "
      _ <- Agent.query cl_id $ CommandLine.question' $
        "So your name is \"" <> reply <> "\"? "
      Console.log $ "Ok bye!"
      Agent.tell cl_id $ CommandLine.close
      pure unit
    pure unit

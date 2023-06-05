module Main where

import Data.Options
import Data.Tuple.Nested
import Prelude

import AI.Agent as Agent
import AI.Agent.CommandLine as CommandLine
import Control.Monad.Except (runExceptT)
import Control.Monad.State (runStateT)
import Data.Functor.Variant as FV
import Effect as Effect
import Effect.Aff as Aff
import Effect.Class.Console (log)
import Effect.Class.Console as Console
import Node.Process as Process
import Node.ReadLine as ReadLine

main :: Effect.Effect Unit
main = Aff.launchAff_ do
  let 
    cl_cls = CommandLine.define 
        { interfaceOptions:
            ReadLine.output := Process.stdout <>
            ReadLine.terminal := true }
        Agent.empty
    cl_inst = CommandLine.new cl_cls {}
  void $ runExceptT do
    cl_inst /\ _ <- Agent.tell CommandLine.open cl_inst
    cl_inst /\ name <- Agent.ask (CommandLine.question $ "Enter your name: ") cl_inst
    cl_inst /\ _ <- Agent.ask (CommandLine.question $ "Confirm that your name is \"" <> name <> "\" [yes/no]: ") cl_inst
    cl_inst /\ _ <- Agent.tell CommandLine.close cl_inst
    Console.log "Ok bye!"
    pure unit

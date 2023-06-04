module Node.ReadLine.Aff where

import Prelude

import Effect.Aff (makeAff, nonCanceler)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (class MonadEffect, liftEffect)
import Node.ReadLine as RL

question :: forall m. MonadAff m => String -> RL.Interface -> m String
question q i = liftAff do
  makeAff \handler -> RL.question q (pure >>> handler) i $> nonCanceler

setPrompt :: forall m. MonadEffect m => String -> RL.Interface -> m Unit
setPrompt promptStr i = liftEffect do
  RL.setPrompt promptStr i

close :: forall m. MonadEffect m => RL.Interface -> m Unit
close i = liftEffect do
  RL.close i

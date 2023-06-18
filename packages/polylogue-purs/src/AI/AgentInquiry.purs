-- | A simple query type.
module AI.AgentInquiry where

import AI.Agent
import Prelude

import Data.Functor.Variant as FV
import Data.Symbol (class IsSymbol)
import Prim.Row (class Cons)
import Type.Proxy (Proxy)

-- | Inquiry

data Inquiry input output output' = Inquiry input (output -> output')
derive instance Functor (Inquiry input output)

-- defineInquiry :: forall queries_ queries input states errors queryLabel m output. IsSymbol queryLabel => Cons queryLabel (Inquiry input output) queries_ queries => Functor m => Proxy queryLabel -> (input -> AgentM states errors m output) -> Agent states errors queries_ m -> Agent states errors queries m
defineInquiry label handler = defineQuery label (\(Inquiry a k) -> k <$> handler a)

-- overrideInquiry :: forall states errors queries1 queryLabel queries2 queries3 queries4 m input output a. IsSymbol queryLabel => Cons queryLabel queries1 queries2 queries3 => Cons queryLabel (Inquiry input output) queries2 queries4 => Monad m => Functor queries1 => Proxy queryLabel -> ((queries1 a -> AgentM states errors m a) -> input -> AgentM states errors m output) -> Agent states errors queries3 m -> Agent states errors queries4 m
overrideInquiry label overrideHandler = 
  -- overrideQuery label (\super (Inquiry a k) -> k <$> overrideHandler (\(Inquiry a' k') -> ?a) a)
  overrideQuery label (\super (Inquiry a k) -> k <$> overrideHandler (\a' -> super (Inquiry a' identity)) a)

inquire :: forall label input output states errors queries_ queries m. IsSymbol label => Cons label (Inquiry input output) queries_ queries => Monad m => Proxy label -> input -> QueryF states errors queries m output
inquire label input = query label (Inquiry input identity)

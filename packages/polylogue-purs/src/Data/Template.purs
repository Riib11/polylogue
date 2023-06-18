module Data.Template where

import Prelude

import Control.Monad.Reader (ReaderT(..), runReaderT)
import Record as R

newtype Template (prms :: Row Type) (args :: Row Type) m (a :: Type) = Template
  { args :: Record args
  , evaluate :: ReaderT (Record prms) m a }

substitute prm arg (Template temp) = 
  Template temp {args = R.insert prm arg temp.args}

union args (Template temp) = Template temp {args = R.union args temp.args}

modify prm f (Template temp) = 
  Template temp {args = R.modify prm f temp.args}

inject prm (Template temp') (Template temp) = Template
  { args: R.disjointUnion temp'.args temp.args
  , evaluate: ReaderT \args -> do
      val <- runReaderT temp.evaluate args
      runReaderT temp'.evaluate (R.insert prm val args)
  }

evaluateWith (Template temp) args = runReaderT temp.evaluate (R.disjointUnion temp.args args)

evaluate temp = evaluateWith temp {}

fromFunction f = Template 
  { args: {}
  , evaluate: ReaderT f }

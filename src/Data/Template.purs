module Data.Template
  ( Template
  , substitute
  , modify
  , evaluate
  , fromFunction )
where

import Control.Monad.Reader (ReaderT(..), runReaderT)
import Data.Symbol (class IsSymbol)
import Prim.Row (class Cons, class Lacks)
import Record as R
import Type.Proxy (Proxy)

-- | A template is parametrized by the parameters that it requires and the
-- | arguments that have already instantiated a subset of those parameters.
newtype Template (prms :: Row Type) (args :: Row Type) m (a :: Type) = Template
  { args :: Record args
  , evaluate :: ReaderT (Record prms) m a
  }

-- | Substitute a single parameter in a prompt.
substitute :: forall prms args' m args prm a val. IsSymbol prm => Lacks prm args => Cons prm val args args' => 
  Proxy prm -> val -> Template prms args m a -> Template prms args' m a
substitute prm arg (Template prompt) = Template prompt {args = R.insert prm arg prompt.args}

-- | Modify a single parameter in a prompt.
modify :: forall prms args' m args args_ prm val val' c. IsSymbol prm => Cons prm val args_ args => Cons prm val' args_ args' => 
  Proxy prm -> (val -> val') -> Template prms args m c -> Template prms args' m c
modify prm f (Template prompt) = Template prompt {args = R.modify prm f prompt.args}

-- | Evaluate a prompt by finally using all its arguments to compute a string.
evaluate :: forall prms m a. Template prms prms m a -> m a
evaluate (Template prompt) = runReaderT prompt.evaluate prompt.args

fromFunction :: forall prms m a. (Record prms -> m a) -> Template prms () m a
fromFunction f = Template {args: {}, evaluate: ReaderT f}

{-# LANGUAGE Trustworthy #-}
-- | We do this just to enable access to `Coercible` and `coerce` which are
-- currently marked unsafe.
module ReCoerce (
    Coercible(..), coerce, IO(..)
  ) where

import Data.Coerce
import GHC.IO


module Sub (
    T(), mkT, undoT, castTs,
    MInt(..),

    runPlugin
  ) where

import Data.Coerce

import Types
import Sub_Evil

runPlugin :: IO ()
runPlugin = plugin (mkT 1 :: T Int) (2 :: Int)


{-# LANGUAGE Trustworthy #-}
-- | Sadly without really having an syntactic indication I'm re-exporting
-- access to the Bool SafeClass instance defined in BadSafeClassInstane!
module ReexportInstances (
        str
    ) where

import BadSafeClassInstance
import TypeClassUnsafe

str :: String
str = "this seems fine..."


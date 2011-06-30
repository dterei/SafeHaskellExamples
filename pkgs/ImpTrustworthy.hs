{-# LANGUAGE Safe #-}
module ImpTrustworthy ( MyInt ) where

-- Data.Int is trustworthy so we need to trust base
import Data.Int 

type MyInt = Int


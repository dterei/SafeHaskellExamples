{-# LANGUAGE Trustworthy #-}
{-# LANGUAGE StandaloneDeriving #-}
module Main where

import Data.Coerce
import safe Set

newtype MyInt = MyInt Int deriving (Eq, Show)

instance Ord MyInt where
  (MyInt x) <= (MyInt y) = y <= x

-- class IntIso t where
--     intIso :: Set t -> Set Int
--
-- deriving instance IntIso MInt

main :: IO ()
main =
  let ints     = [1,3,5,2] :: [Int]
      intSet   = foldr insertElement newSet ints
      myints   = coerce ints :: [MyInt]
      myintSet = foldr insertElement newSet myints
      intSet'  = coerce myintSet :: Set Int
      -- Not allowed unless MkMInt is in scope
      -- mints    = coerce ints :: [MInt]
  in do
    print intSet
    print myintSet
    print intSet'


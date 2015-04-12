{-# LANGUAGE Trustworthy #-}
{-# OPTIONS_GHC -fwarn-unsafe #-}
module Main where

import Data.Coerce
import safe Set

newtype MyInt = MyInt Int deriving (Eq, Show)

instance Ord MyInt where
  (MyInt x) <= (MyInt y) = y <= x

main :: IO ()
main =
  let ints     = [1,3,5,2] :: [Int]
      intSet   = foldr insertElement newSet ints
      myints   = coerce ints :: [MyInt]
      myintSet = foldr insertElement newSet myints
      intSet'  = coerce myintSet :: Set Int
  in do
    print intSet
    print myintSet
    print intSet'


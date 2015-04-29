{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Main where

import Data.Coerce

import Set

class SOrd a where
  badInsert :: a -> Set a -> Set a

instance SOrd Int where
  badInsert = intInsert

intInsert :: Int -> Set Int -> Set Int
intInsert = insert

-- Works fine! Newtype constructor rule only applies to casting between newtype
-- and base-type, not to types under the newtype.
mintInsert :: MInt -> Set MInt -> Set MInt
mintInsert = coerce intInsert

-- Doesn't work since newtype constructor not in scope.
setCast :: Set a -> [a]
setCast = coerce

newtype MInt = MInt Int deriving (Eq, SOrd, Show)

instance Ord MInt where
  compare (MInt x) (MInt y) = compare y x

set :: Set Int
set = foldr insert empty [1..3]

set' :: Set MInt
set' = foldr (\x y -> insert (MInt x) y) empty [1..3]

setB :: Set MInt
setB = foldr (\x y -> badInsert (MInt x) y) empty [1..3]

main :: IO ()
main = do
  print set
  print set'
  print setB


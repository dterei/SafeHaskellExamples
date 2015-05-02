{-# LANGUAGE Safe #-}
module C (ins') where

import Data.Set

import A

instance Ord U where
  compare X X = EQ
  compare X Y = GT
  compare Y X = LT
  compare Y Y = EQ

ins' :: U -> Set U -> Set U
ins' = insert


module B (ins) where

import Data.Set

import A

instance Ord U where
  compare X X = EQ
  compare X Y = LT
  compare Y X = GT
  compare Y Y = EQ

ins :: U -> Set U -> Set U
ins = insert


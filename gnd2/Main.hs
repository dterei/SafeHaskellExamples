{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
module Main where

import Set

import Data.Coerce

newtype Age = MkAge Int deriving (Eq, Show)

instance Ord Age where
  (MkAge a) `compare` (MkAge b) = b `compare` a

class HasSet a where
  getSet :: Set a

instance HasSet Int where
  getSet = insert 2 (insert 5 empty)

-- deriving instance HasSet Age
--
-- > Deriving is equivalent to the explicit instance below:
instance HasSet Age where
  getSet = coerce (getSet :: Set Int)  

good :: Set Int
good = getSet

good' :: Set Age
good' = insert (MkAge 2) (insert (MkAge 5) empty)

bad :: Set Age
bad = getSet

bad' :: Set Int
bad' = coerce good'

main :: IO ()
main = do
  print good
  print good'
  print bad
  print bad'


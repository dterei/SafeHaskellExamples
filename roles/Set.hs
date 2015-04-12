{-# LANGUAGE Safe #-}
module Set where

import Data.List (sort)

data Set a = MkSet [a]
  deriving (Show, Eq, Read)

newSet :: Ord a => Set a
newSet = MkSet []

insertElement :: Ord a => a -> Set a -> Set a
insertElement a (MkSet as) = MkSet $ sort $ a:as


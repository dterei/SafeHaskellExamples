{-# LANGUAGE RoleAnnotations #-}
module Set (
    Set(),
    insert,
    empty
  ) where

import Data.List (sort)

-- If nominal role, then BadInsert doesn't work.
-- type role Set nominal
newtype Set a = Set [a] deriving (Show)

insert :: Ord a => a -> Set a -> Set a
insert x (Set xs) = Set $ sort $ x:xs

empty :: Set a
empty = Set []


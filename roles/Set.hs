{-# LANGUAGE Trustworthy #-}
{-# LANGUAGE RoleAnnotations #-}
module Set (
    Set,
    newSet,
    insertElement,
    MInt
  ) where

import Data.Coerce
import Data.List (sort)

type role Set representational
-- type role Set nominal
data Set a = MkSet [a]
  deriving (Show, Eq, Read)

newSet :: Ord a => Set a
newSet = MkSet []

insertElement :: Ord a => a -> Set a -> Set a
insertElement a (MkSet as) = MkSet $ sort $ a:as

newtype MInt = MkMInt Int deriving (Show, Eq, Ord)
--
-- x :: Set MInt
-- x = insertElement (MkMInt 1) newSet
--
-- y :: Set Int
-- y = coerce x
--

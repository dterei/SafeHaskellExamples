{-# LANGUAGE RoleAnnotations #-}
module Types (
    T(..), mkT, undoT, castTs,
    MInt(..)
  ) where

import Data.Coerce

type role T representational
newtype T a = T a deriving (Eq, Ord, Show)

mkT :: a -> T a
mkT = T

undoT :: T a -> a
undoT (T a) = a

newtype MInt = MInt Int deriving (Eq, Ord, Show)

castTs :: [T a] -> [a]
castTs = coerce


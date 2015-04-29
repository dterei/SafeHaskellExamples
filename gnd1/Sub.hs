module Sub (
    T(..)
  ) where

newtype T = MkT Int deriving (Show, Eq, Ord)


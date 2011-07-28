{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE StandaloneDeriving #-}
module GenUse (Cerial(..), Bin(..), Tree(..)) where

import GenBin (Cerial(..), Bin(..), Private)
import GHC.Generics

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving (Show, Eq, Generic)

instance (Cerial a) => Cerial (Tree a)

deriving instance Generic (Private a)


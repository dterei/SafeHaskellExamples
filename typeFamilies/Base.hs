{-# LANGUAGE TypeFamilies, DeriveDataTypeable #-}
module Base where

import Data.Typeable

data family Fam a
data FamHolder a = FamHolder (Fam a) deriving (Typeable)


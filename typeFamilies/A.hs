{-# LANGUAGE TypeFamilies #-}
module A (a) where

import Data.Dynamic
import Base

data instance Fam () = FamA Int

genDynFam :: Int -> Dynamic
genDynFam = toDyn . FamHolder . FamA

a :: Dynamic
a = toDyn genDynFam


{-# LANGUAGE TypeFamilies #-}
module B (b) where

import Data.Dynamic
import Base

data instance Fam () = FamB String

useDynFam :: Dynamic -> String
useDynFam dyn = case fromDynamic dyn of
                    Just (FamHolder (FamB s)) -> s
                    Nothing                   -> "error"

b :: Dynamic
b = toDyn useDynFam


{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}

{- | This file is written by the attacker -}
module Main where

import X1

class IsInt t where
    isInt :: c Int -> c t

instance IsInt Int where isInt = id

deriving instance IsInt Moo

{-
-- deriving allows undefinable function.
-- we can't unwrap Int from c yet somehow newtype
-- deriving can. (since Moo ~ Int, kind of)
instance IsInt Moo where
    isInt :: c Int -> c Moo
    isInt = id
-}

main = do
    print $ myZMfun (isInt (ZI 4.0))


{-# LANGUAGE StandaloneDeriving, DeriveFunctor, DeriveDataTypeable #-}
module Main where

import Protected

deriving instance Read NatPublic
deriving instance Typeable NatPublic
-- deriving instance ClassPartPublic NatPublic


deriving instance Functor Kind2

deriving instance Read Nat
-- deriving instance Typeable Nat

{-
instance ClassPartPublic NatPublic where
    idd = id
    eqq _ _ = False
    cool _ = True
    size (NatP n) = n
-}

main = do
    let a = zero
        b = succ' $ zero
        c = succ' $ b
        -- d = NatC (-1)
    -- putStrLn $ show a
    putStrLn $ showNat b
    putStrLn $ showNat c
    return ()


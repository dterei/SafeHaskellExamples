{-# LANGUAGE StandaloneDeriving, DeriveDataTypeable #-}
module Main where

import Data.Typeable

import Protected

deriving instance Typeable Nat
{-
instance Typeable Nat where
    typeOf _ = typeOf (undefined::NInt)
-}

data NInt = NInt Int deriving Show
{-
instance Typeable NInt where
    typeOf _ = mkTyConApp (mkTyCon "NInt") [typeOf (undefined::Int)]
-}
instance Typeable NInt where
    typeOf _ = typeOf (undefined::Nat)

main = do
    let a = succ' $ zero
        Just n@(NInt z) = (cast a) :: Maybe NInt
        n' = NInt (-z)
        Just m = (cast n') :: Maybe Nat

     
    putStrLn $ showNat a
    putStrLn $ show n
    putStrLn $ showNat m
    return ()



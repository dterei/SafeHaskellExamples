module Protected (
        Nat, NatPublic(..), Kind2(..), zero, succ', showNat, ClassPartPublic(idd), Typeable()
  ) where

import Data.Typeable

class ClassPartPublic a where
    idd  :: a -> a
    eqq  :: a -> a -> Bool
    cool :: a -> Bool
    size :: a -> Int


data Nat = NatC Int
data NatPublic = NatP Int
data Kind2 a = K a

zero :: Nat
zero = NatC 0

succ' :: Nat -> Nat
succ' (NatC n) = NatC $ n + 1

showNat :: Nat -> String
showNat (NatC n) = show n


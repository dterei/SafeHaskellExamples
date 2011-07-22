{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
module GenType (Typeable(..)) where

import GHC.Generics
import Data.Typeable

--------------------------------------------------------------
-- Generic Deriving

class Typeable' f where
    typeOf :: f a -> TypeRep

instance GCerial U1 where
    typeOf U1 = undefined

instance (Typeable' a, Typeable' b) => Typeable' (a :+: b) where
    typeOf (L1 x) = undefined
    typeOf (R1 y) = undefined

instance (Typeable' a, Typeable' b) => Typeable' (a :*: b) where
    typeOf (x :*: y) = undefined

instance (Typeable' a) => Typeable' (M1 i c a) where
    typeOf (M1 x) = undefined

instance (Typeable' a) => Typeable' (K1 i a) where
    typeOf (K1 x) = undefined


{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
module GenBin (Bin(..), Cerial(..), Private) where

import GHC.Generics
import Data.Bits
import Data.Char

data Private a = Private a

-- | Binary data encoding
data Bin = O | I deriving (Show, Eq)

-- | Serialize type class
class Cerial a where
    put :: a -> [Bin]

    default put :: (Generic a, GCerial (Rep a)) => a -> [Bin]
    put = gput . from

--------------------------------------------------------------
-- Implementation Internals
--

toBits :: Bits a => a -> [Bin]
toBits x = map (\y -> if testBit x y then I else O) [0..(bitSize x)]

instance Cerial Int where
    put = toBits

instance Cerial Integer where
    put = (toBits . (fromInteger :: Integer -> Int))

instance Cerial Char where
    put = (toBits . ord)

instance Cerial Bool where
    put True  = [I]
    put False = [O]

instance Cerial a => Cerial [a] where
    put = (concat . map put)

--------------------------------------------------------------
-- Generic Deriving

class GCerial f where
    gput :: f a -> [Bin]

instance GCerial U1 where
    gput U1 = []

instance (GCerial a, GCerial b) => GCerial (a :+: b) where
    gput (L1 x) = O : gput x
    gput (R1 y) = I : gput y

instance (GCerial a, GCerial b) => GCerial (a :*: b) where
    gput (x :*: y) = gput x ++ gput y

instance (GCerial a) => GCerial (M1 i c a) where
    gput (M1 x) = gput x

instance (Cerial a) => GCerial (K1 i a) where
    gput (K1 x) = put x


{-# LANGUAGE Safe  #-}

-- | Module defining a new typeclass that has a safe interface. Also define the
-- Int and Char instances.
module TypeClassSafe where

-- | Safe interface but can still do an unsafe implementation.
class SafeClass a where
    same :: a -> a

instance SafeClass Int where
    same = id

instance SafeClass Char where
    same = id


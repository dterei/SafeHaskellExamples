{-# LANGUAGE Unsafe  #-}

-- | Module defining a new typeclass that has a unsafe interface. Also define the
-- Int and Char instances.
module TypeClassUnsafe where

import System.IO.Unsafe

-- | All implementations of this will be unsafe!
class UnsafeClass a where
    escape :: IO a -> a

instance UnsafeClass Int where
    escape = unsafePerformIO

instance UnsafeClass Char where
    escape = unsafePerformIO


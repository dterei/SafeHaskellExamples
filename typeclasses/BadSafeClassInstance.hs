{-# LANGUAGE Unsafe #-}
module BadSafeClassInstance where

import System.IO.Unsafe

import TypeClassSafe

instance SafeClass Bool where
    same n = unsafePerformIO $ print "EVIL!" >> return n


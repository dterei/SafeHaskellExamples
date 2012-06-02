{-# LANGUAGE Safe #-}

-- | Untrusted client code.
module Untrusted where

import TypeClassSafe
-- CAN'T DO
-- import TypeClassUnsafe
import ReexportInstances

run :: Int -> Int
run x = x * (same 2)

runB :: Bool -> Bool
-- runB b = not b

-- CAN'T DO (unless import ReexportInstances..., but doesn't matter what
-- modules importing Untrusted have access to)
-- XXX
runB b = not (same b)

runI :: Int -> Int
runI i = i + 4

-- CAN'T DO as while ReexportInstances gives us access to instances, we still
-- can't access the 'escape' symbol without importing something that exports it
-- (which is an explicit act unlike instances).
-- runI i = escape (bad i)

bad :: Int -> IO Int
bad n = do
    putStrLn "EVIL!"
    return n


{-# LANGUAGE Trustworthy #-}
-- | Run an unsafe plugin.
--
-- By declaring a `Coercible` constraint in the context of `runPlugin`, the
-- untrusted code can convince this module to generate a dictionary for it and
-- pass it in.
module Main where

import safe UnsafePlugin
import RIOInternal

main :: IO ()
main = do
  let lv = LValue "secret"
  putStrLn "Starting..."
  rio $ (runPlugin :: LValue -> RIO ()) lv


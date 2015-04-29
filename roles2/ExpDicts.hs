{-# LANGUAGE GADTs #-}
module Main where

import Data.Coerce

import ExpDicts_Sub

data C a where
  C :: MEQ a => C a

newtype CChar = CChar Char

instance MEQ CChar where
  meq _ _ = False

dictChar :: C Char
dictChar = C

dictCChar :: C CChar
dictCChar = C

dictChar' :: C Char
dictChar' = coerce dictCChar

expMEQ :: C a -> a -> a -> Bool
expMEQ C a b = a `meq` b

main :: IO ()
main = do
  print $ expMEQ dictChar  'a' 'a'
  print $ expMEQ dictCChar  (CChar 'a') (CChar 'a')
  print $ expMEQ dictChar' 'a' 'a'


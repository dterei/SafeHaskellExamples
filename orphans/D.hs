{-# LANGUAGE Safe #-}
module Main where

import Data.Set

import A
import B
import C

main :: IO ()
main = print test

test :: Set U
test = ins' X $ ins X $ ins Y $ empty


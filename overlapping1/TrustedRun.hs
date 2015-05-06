{-# LANGUAGE Trustworthy #-}
module Main where

import safe TrustedLib
import safe UntrustedPlug

main :: IO ()
main =
  let r = res [(1::Int)] 
  in putStrLn $ "Result: " ++ show r


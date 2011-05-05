{-# LANGUAGE TemplateHaskell #-}
module Main where

import A
import B

$(mkSimpleClass ''A)

main = do
    let b = c :: A
    putStrLn $ "I have a value of A :: " ++ show b


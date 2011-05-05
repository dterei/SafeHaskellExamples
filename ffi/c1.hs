{-# LANGUAGE Safe #-}
{-# LANGUAGE ForeignFunctionInterface #-}
module Main where

import Foreign.C

foreign import ccall "sinyy" c_sin :: CDouble -> CDouble

sinx :: Double -> Double
sinx d = realToFrac $ c_sin $ realToFrac d

x :: Double
x = 0.8932

main :: IO ()
main = do
    putStrLn "Hello World"
    putStrLn $ "Sin of " ++ (show x) ++ " is "  ++ (show $ sinx x)


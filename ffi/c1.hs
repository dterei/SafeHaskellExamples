{-# LANGUAGE Safe #-}
{-# LANGUAGE ForeignFunctionInterface #-}
module Main where

import Foreign.C

foreign import ccall "sinyy" c_sinOK :: CDouble -> IO CDouble
foreign import ccall "sinyy" c_sinBad :: CDouble -> CDouble

sinx :: Double -> Double
sinx d = realToFrac $ c_sinBad $ realToFrac d

x :: Double
x = 0.8932

main :: IO ()
main = do
    putStrLn "Hello World"
    putStrLn $ "Sin of " ++ (show x) ++ " is "  ++ (show $ sinx x)


module Main where

import Data.Dynamic
import qualified A as A (a)
import qualified B as B (b)

main :: IO ()
main = do
    let a = fromDyn A.a $ error "A.a" :: Int -> Dynamic
    let b = fromDyn B.b $ error "B.b" :: Dynamic -> String
    print $ b $ a $ 5

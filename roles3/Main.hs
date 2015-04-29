module Main where

import Data.Coerce

import Sub
import Sub_Evil

-- Can't write since T constructor not in scope!
-- castTs' :: [T a] -> [a]
-- castTs' = coerce

-- Can write since MInt constructor in scope!
castMInts :: [MInt] -> [Int]
castMInts = coerce

main :: IO ()
main = do
  let x  = mkT 1 :: T Int
      xs = [mkT 1, mkT 2, mkT 3] :: [T Int]
      ys = castTs  xs :: [Int]
      zs = coerce ([1..3] :: [Int]) :: [MInt]
  putStrLn $ "X : " ++ show x
  putStrLn $ "XS: " ++ show xs
  putStrLn $ "YS: " ++ show ys
  putStrLn $ "ZS: " ++ show zs
  runPlugin
  return ()

-- Can't call as can't produce coercion dict.
-- runPlugin' :: IO ()
-- runPlugin' = plugin (mkT 1 :: T Int) (2 :: Int)


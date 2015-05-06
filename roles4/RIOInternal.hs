{-# LANGUAGE Unsafe #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module RIOInternal (
    RIO(..), rPutStrLn, LValue(..), unlabel
  ) where

-- | RIO is our restricted IO monad to limit the plugins capabilities.
newtype RIO a = UnsafeRIO { rio :: IO a  }
  deriving (Functor, Applicative, Monad)

rPutStrLn :: String -> RIO ()
rPutStrLn s = UnsafeRIO $ putStrLn s

-- | LValue is a labeled value, requiring raising the security level of code
-- that unwraps it to access the value.
newtype LValue = LValue String

unlabel :: LValue -> RIO String
unlabel (LValue v) = UnsafeRIO $ do
  putStrLn $ "--> Security level: high!"
  return v


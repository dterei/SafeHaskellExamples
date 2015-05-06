{-# LANGUAGE Trustworthy #-}
-- | Re-export a safe interface for plugins.
module RIO (
    RIO(), rPutStrLn, LValue(), unlabel
  ) where

import RIOInternal


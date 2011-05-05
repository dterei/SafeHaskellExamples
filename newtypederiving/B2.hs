-- | We only expose an interface that allows positive Nats to be created.
module B2 (
        Nat, zero, sucx, showNat
  ) where

data Nat = NatC Int

zero :: Nat
zero = NatC 0

sucx :: Nat -> Nat
sucx (NatC n) = NatC $ n + 1

showNat :: Nat -> String
showNat (NatC n) = "Nat " ++ show n


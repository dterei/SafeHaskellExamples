# Defaulting

The idea is to use the Haskell defaulting mechanism to create values
of types you shouldn't be able to.

The defaulting mechanism in Haskell is a way to decide how numeric
literals should be resolved in Haskell source code. e.g., What is the
type of 'bad' below?

bad = 1

Haskell specifies that it can default to any type that is an instance
of the 'Num' typeclass. Which one it defaults to is determined by the
default list:

'defaut (Integer, Double)'

That can appear once in a Haskell module and is local to that module.
For more info see here:

http://www.haskell.org/onlinereport/haskell2010/haskellch4.html#x10-790004.3.4

So if there is a type G that is an instance of the Num typeclass and G
is abstracted by module boundaries, can we create illegal values of
type G through defaulting?

## Result

No. Defaulting works by translating code like:

bad :: G
bad = -1

into:

bad :: G
bad = negate $ fromInteger (1 :: Integer)

So the code is completely controlled by the trusted user, it is code
that could have been written without defaulting.


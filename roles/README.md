# GND & Roles

GHC 7.10 and later include a new implementation of GND that fixes the
type-safety issues of previous versions.

However, it also introduces a new concept of representation equality, that is,
two types that have the same in-memory representation. This is to allow 'safe'
casting from one type to another when they have representational equality,
allowing newtypes to finally have no performance overhead.

For example, before representational equality was introduced, the following
code exacted a performance penalty:

```
newtype N = MkN { unN :: Int }

nsToInts :: [N] = [Int]
nsToInts = map unN
```

Even though it's equivalent to `id`, GHC keeps a typed intermediate
representation and can't optimize across the type conversion.

## Data.Coerce

The `Data.Coerce` package defines a new type-class:

```
class Coercible a b

coerce :: Coercible * a b => a -> b
```

The `Coercible` type-class can't be instantiated by hand, instead GHC will
infer and generate them for two types with the same run-time representation.

GHC generate three kinds of instances. First, the trivial base case:

```
instance a a
```

Secondly, two instance exist for every `newtype NT = MkNT T`:

```
instance Coercible a T => Coercible a NT
instance Coercible T b => Coercible NT b
```

These two instances are only available if the `MkNT` constructor is in scope.

Thirdly, for every type constructor there is an instance that allows coercion
under the type. For example, let D be a type constructor (`data` or `newtype`)
with three type arguments, which have roles nominal, representational, and
phantom respectively. Then there is an instance of the form:

```
instance Coercible b b' => Coercible (D a b c) (D a b' c')
```

This means that by default, as a library author of a type constructor like `Set
a`, users of your library will have access to `coerce :: Set T -> Set NT`.

To prevent this, you need to set the role of Set's type parameter to nominal by
writing:

```
type role Set nominal
```

## Roles

The goal of the roles system is to track when two types have the same
underlying representation. For example:

```
newtype Age = MkAge Int

type family Inspect x
type instance Inspect Age = Int
type instance Inspect Int = Bool

class BadIdea a where { bad :: a -> Inspect a }
instance BadIdea Int where { bad = (> 0) }
deriving instance BadIdea Age -- not allowed!
```

If the derived instance was allowed, the type would be
`bad :: Age -> Instpect Age`, which is equivalent to `bad :: Age -> Int`, and
so if we simply used the `BadIdea Int` dictionary, then we'd produce a `Bool`
when an `Int` is expected. Roles track how type variables are used to make sure
such things can't happen!

A role declares how a type parameter affects the equality of a type constructor
when we have two applications that differ only in one parameter. For example:

```
x :: T Age Bool c
y :: T Int Bool c
```

Do `x` and `y` have representational equality? The role for the first type
parameter of `T` determines this.

There are three roles: representational, nominal and phantom.

### Representational

```
data Simple a = MkSimple a -- a has role representational
```

The most common, and default, case is representational. This role allows
coercion between the outer type when we the inner types are equal. For example:

```
newtype MyInt = MkMyInt Int

toMyInt :: Simple Int -> Simple MkMyInt
toMyInt = coerce
```

### Nominal

```
type family F
type instance F Int = Bool
type instance F Age = Char

data Complex a = MkComplex (F a) -- a has role nominal
```

Inferred when a type parameter may no longer have equivalent run-time
representation despite the arguments having equality.

### Phantom

```
data Phant a = MkPhant Bool -- a has role phantom
```

Inferred when the type parameter doesn't affect the run-time representation of
the outer type.

### Role Annotations (-XRoleAnnotations)

```
type role T nominal _ representational
data T a b c = MkT a b
```

Roles have an ordering, `nominal > representational > phantom`, and annotations
can only declare a type parameter to be a higher or equal role to the one
inferred.

### Roles & Safe Haskell

Roles are an unfourtunate mechanism for control right now. Since
representational is the default role for most type constructors, to enforce
invariants on abstract data types, library authors need to set their type
constructors to have nominal roles.

This requires that library authors understand roles to enforce what they expect
to happen according to Haskell2010 semantics. It also prevents them using
`coerce` internally and gaining the optimization, which is insulting as they
can write the code that coerce is semantically equivalent to.

It seems a different approach is needed, of either:

1) Require that all constructors are in scope when calling `coerce`. There is
some precendence for this as 7.10 requires that a newtype's constructor is in
scope to use `coerce`.

**NO**: This was requirement wasn't place of data types since some types (like
`IORef`) don't even have constructors that can be in scope.

2) Allow specifying internal + external role annotations.

3) Change the default to be nominal when all the constructors aren't exported,
and allow weakening of this to referential with role annotations.


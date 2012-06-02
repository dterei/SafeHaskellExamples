# TypeClass & Safe Haskell

The issue here is, how does the scoping of typeclasses affect Safe
Haskell?

 - Type Classes have unusual scoping, first there is the class
   definition and then there are the instances. Given the instances
   are associated with Types, access to a type kind of gives access to
   an instance.
 - Instance definition can't be restricted in an import list or
   export list. Importing a class that defines an instance gives you
   them.

So in this sense they seem nearly global. This seems a tricky thing to
code with in Safe Haskell. The problem would be that the TCB has
access to some dangerous instances and this gives some untrusted code
it's importing access to them. So you would need to require that the
whole code base has no unsafe typeclass instances...

## Safe & Unsafe typeclasses

As type classes define an interface we can think of them as safe or
unsafe. For example:

### Safe Type Class

    ~~~~ {.haskell}
    class SafeClass a where
        same :: a -> a
    ~~~~

All instances *should* be equivalent to id for the function same. Note
though that a perfectly valid instance that we wouldn't want untrusted
code accessing is this:

    ~~~~ {.haskell}
    import System.IO.Unsafe
    import TypeClassSafe
    
    instance SafeClass Bool where
        same n = unsafePerformIO $ print "EVIL!" >> return n
    ~~~~

So while a typeclass interface may be safe that doesn't mean all
instances are safe and should be allowed to be used by unsafe code...

### Unsafe Type Class

    ~~~~ {.haskell}
    class SafeClass a where
        escape :: IO a -> a
    ~~~~

All instances *should* be equivalent to unsafePerformIO for the
function escape. We shouldn't allow untrusted code to access this
typeclass or any instances. (Note though that only really instances
are dangerous as you need a concrete instance on a type to use but
allow access to the typeclass and no instances is pointless and
introduces more chance of mistakes.)

### Mixed Type Class

    ~~~~ {.haskell}
    class MixedClass a where
        yep :: a -> a
        nup :: IO a -> a
    ~~~~

If you export the entire type class then they are the same as an
unsafe type class. However it seems that it isn't very well known that
typeclasses can be export controlled like any other symbols. E.g.

    ~~~~ {.haskell}
    module SafeExport ( MixedClass(yep) ) where
    ...
    ~~~~

Would allow you to export MixedClass as a Safe Type class. Be careful
no one else re-exports MixedClass though with the 'nup' symbol...

## So how bad is this stuff?

This all is tricky as the scoping of typeclasses isn't very well
presented in Haskell code, especially as import and export lists don't
mention them, they just flow implicitly.

However, there isn't a problem for Safe Haskell here. The scoping
rules basically are sane and work fine.

1. You can only access instances of a typeclass that are somehow
   defined in a transitive dependency of yours. So say a unsafe module
   M exists and you don't want M accessing the instances defined in
   the module X. Marking X as Unsafe should generally be sufficient.
   You are free in module Main to safe import M and import X and be
   assured this doesn't give X access to the instances in X.

2. You need access to the method names of a type class to call them.
   This comes by importing the module that defines the typeclass (or
   one that re-exports it or some of the methods). Importing a module
   M that defines an instance of a typeclass but (re-)export the
   typeclass itself doesn't give you the ability to use functions of
   that type class, you still need to import the typeclass functions
   through some other module.

So this is all good news. However the bad part is that it's *hard to
reason about and restrict access to instances!* If any module in the
transitive import graph of a module defines some instances, you have
access to them. Export and Import lists can't change this. So some
untrusted code may very well have access to instances through a
Trustworthy module you define that has access to those instances...

The good news is that the 2) property holds and is easier to control
and reason about. That is, you need access to the symbols/function of
a typeclass to use them still, having access to instances doesn't
matter. These symbols are regular functions basically so are
controlled as usual through import and export lists and so are
explicit and thus easier to reason about. This means that *controlling
untrusted codes access to an unsafe typeclass is fairly easy*. However
unsafe instances of safe type classes is very hard to reason about and
track. Luckily there is very little reason to have unsafe instances of
safe typeclasses and exploiting them is difficult as the unsafeness is
probably fairly controlled (e.g some logging output). But in general
be very careful about defining such instances as it will be hard to
ensure that untrusted code doesn't get access to them...


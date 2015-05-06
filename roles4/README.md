# Roles, Constructor Restriction & Safefy

Newtype's generate three `Coercible` instances. Consider:

        newtype MInt = MInt Int

This would first generate two unwrapping instances:

        Coercible Int a => MInt a
        Coercible a Int => a MInt

And secondly, lifting instances. However, in this type (without any type
abstraction), we don't have such instances.

To make use of the unwrapping instances, GHC requires that the constructor,
`MInt`, be in scope.

## Result

This is unsafe as you can convince someone else with access to the constructors
(when you don't have access), to generate the appropriate dictionary and pass
it to you.

## Solution?

Unsafe to refer to `Coercible` constraints.


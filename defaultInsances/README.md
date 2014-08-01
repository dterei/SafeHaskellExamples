# Defaulting and Instances

Can the default selection affect which instance is chosen? For
example, assume the default ordering (from most specific to least) is
Int, Float, Double for Num. Then if we have this code:

>class C a where
>  f :: a -> String
>
>instance C Float where
>  f _ = "float"
>
>test :: String
>test = f 7
>

Firstly, assuming this worked (i.e., compiled) by defaulting `7` to
`Float` and chosing the `C Float` instance, could we change the
behavior by introducing a `C Int` instance? I.e., the above would
output: `float`. What about the following:

>instance C Int where
>  f _ = "int"
> 

Would that change the output to `int`?

## Result

No! GHC won't accept the program to begin with, declaring it ambiguous
as it doesn't know how to default `7`. The best you can manage is with
IncoherentInstances you can add a instace `C a` and have that
selected, which is fine.


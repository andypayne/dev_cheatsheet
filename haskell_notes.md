# Haskell


## GHCI - Repl

```shell
ghci

GHCi, version 8.8.3: https://www.haskell.org/ghc/  :? for help
Loaded package environment from
/home/user/.ghc/x86_64-linux-8.8.3/environments/default
Prelude>
```

To load a file named `source_file.hs` (extension optional):
```
Prelude> :l source_file
[1 of 1] Compiling Main             ( haskell-tutorial.hs, interpreted )
Ok, one module loaded.
*Main>
```

To reload the code:
```
*Main> :r
```

To get the type declaration of a function:
```
*Main> :t sum
sum :: (Foldable t, Num a) => t a -> a

*Main> :t sqrt
sqrt :: Floating a => a -> a

*Main> :t (+)
(+) :: Num a => a -> a -> a

*Main> :t truncate
truncate :: (RealFrac a, Integral b) => a -> b
```

Show the difference between two exponentiation operators:
```
*Main> :t (^)
(^) :: (Integral b, Num a) => a -> b -> a
*Main> :t (**)
(**) :: Floating a => a -> a -> a
*Main>
```

Show docs:
```
Prelude> :info (->)
data (->) (a :: TYPE q) (b :: TYPE r)   -- Defined in ‘GHC.Prim’
infixr -1 ->
instance Applicative ((->) a) -- Defined in ‘GHC.Base’
instance Functor ((->) r) -- Defined in ‘GHC.Base’
instance Monad ((->) r) -- Defined in ‘GHC.Base’
instance Monoid b => Monoid (a -> b) -- Defined in ‘GHC.Base’
instance Semigroup b => Semigroup (a -> b) -- Defined in ‘GHC.Base’
Prelude>
```

The bind operator:
```
Prelude> :t (>>=)
(>>=) :: Monad m => m a -> (a -> m b) -> m b
```

## ghcid

[ghcid](https://github.com/ndmitchell/ghcid) is a simple way to see errors as
you're editing.

Install with stack:

```shell
stack install ghcid
```

Then run in a terminal while editing:
```
ghcid "--command=ghci file.hs"
```


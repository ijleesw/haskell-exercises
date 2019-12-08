# Expression Tree

An implementation of expression tree in Haskell. Supports evaluation and differentiation.



## Usage

```bash
$ ghci expression-tree.hs

*Main> mytree = log_ (add_ (Var 'x') (mul_ (Var 'y') (Value 2)))        -- log (x + 2y)
*Main> eval_ mytree [('x', 1.5), ('y', 2.7)]
1.9315214116032138
*Main> diff_ mytree [('x', 1.5), ('y', 2.7)] 'y'
0.2898550724637681

*Main> mytree2 = exp_ ( mul_ (Var 'x') ( log_ ( Var 'x' ) ) )           -- e^(x log x) = x^x
*Main> eval_ mytree2 [('x',2.5)]
9.882117688026186
*Main> diff_ mytree2 [('x',2.5)] 'x'
18.937010536854235
```

import Data.List

pos :: (Eq a) => a -> [a] -> Int
pos i xs = maybe (-1) id (i `elemIndex` xs)

-------------------------------------------------------------------

data OP = Add | Sub | Mul | Div 
        | Exp | Log
    deriving (Eq)


data Tree = Var Char | Value Double | Branch OP [Tree]


add_ :: Tree -> Tree -> Tree
add_ a b = Branch Add [a, b]


sub_ :: Tree -> Tree -> Tree
sub_ a b = Branch Sub [a, b]


mul_ :: Tree -> Tree -> Tree
mul_ a b = Branch Mul [a, b]


div_ :: Tree -> Tree -> Tree
div_ a b = Branch Div [a, b]


exp_ :: Tree -> Tree
exp_ a = Branch Exp [a]


log_ :: Tree -> Tree
log_ a = Branch Log [a]



eval_ :: Tree -> [(Char, Double)] -> Double

eval_ (Value c) _       = c
eval_ (Var a) xs        = (snd $ xs !! (pos a [fst y | y <- xs]))
eval_ (Branch op [left, right]) xs
    | op == Add         = (eval_ left xs) + (eval_ right xs)
    | op == Sub         = (eval_ left xs) - (eval_ right xs)
    | op == Mul         = (eval_ left xs) * (eval_ right xs)
    | op == Div         = (eval_ left xs) / (eval_ right xs)
eval_ (Branch op [one]) xs
    | op == Exp         = exp (eval_ one xs)
    | op == Log         = log (eval_ one xs)



diff_ :: Tree -> [(Char, Double)] -> Char -> Double

diff_ (Value c) _ _     = 0
diff_ (Var a) _ x       = if a == x then 1 else 0
diff_ (Branch op [left, right]) at x
    | op == Add         = (diff_ left at x) + (diff_ right at x)
    | op == Sub         = (diff_ left at x) - (diff_ right at x)
    | op == Mul         = (diff_ left at x) * (eval_ right at) + (eval_ left at) * (diff_ right at x)
    | op == Div         = ( (diff_ left at x) * (eval_ right at) - (eval_ left at) * (diff_ right at x) ) 
                         / ( (eval_ right at) ^ 2 )
diff_ (Branch op [one]) at x
    | op == Exp         = exp (eval_ one at) * (diff_ one at x)
    | op == Log         = 1 / (eval_ one at) * (diff_ one at x)


import Prelude hiding (pred, succ)

class CNum a where
    zero :: a
    isZero :: a -> Bool
    pred :: a -> a
    succ :: a -> a

val :: (CNum a) => a -> Int
val x = if isZero x then 0 else 1 + val (pred x)

instance CNum [a] where
    zero = []

    isZero [] = True
    isZero _ = False

    pred (x:xs) = xs
    succ xs = undefined : xs

add :: (CNum a) => a -> a -> a
add x y = if isZero x then y else succ (add (pred x) y)

mult :: (CNum a) => a -> a -> a
mult x y = if isZero x then zero else add y (mult (pred x) y)

fact :: (CNum a) => a -> a
fact x = if isZero x then succ zero else mult x (fact (pred x))

fromInt :: CNum a => Int -> a
fromInt 0 = zero
fromInt x = succ (fromInt (x-1))

fromInt' :: Int -> [Bool]
fromInt' = fromInt


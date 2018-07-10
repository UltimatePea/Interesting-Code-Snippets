module PrimeFactorization where
import Data.Maybe
import Control.Monad.Trans.State

-- primes copied from https://stackoverflow.com/questions/3596502/lazy-list-of-prime-numbers
primes :: [Integer]
primes = 2: 3: sieve (tail primes) [5,7..]
 where 
  sieve (p:ps) xs = h ++ sieve ps [x | x <- t, x `rem` p /= 0]  
                                -- or:  filter ((/=0).(`rem`p)) t
                  where (h,~(_:t)) = span (< p*p) xs



divide :: Integer -> Integer -> Maybe Integer
divide d n | n `mod` d == 0 = Just $ n `div` d
divide d n | otherwise      = Nothing

iterateM :: Monad m => (a -> m a) -> m a -> [m a]
iterateM f x = x : iterateM f (x >>= f)



divideList :: Integer -> Integer -> [Maybe Integer]
divideList d n = iterateM (divide d) (return n)
                 

--                           v #factor v remainder
divideUntil :: Integer -> Integer -> (Integer, Integer)
divideUntil d n = let l = takeWhile (/= Nothing) (divideList d n)
                  in (toInteger (length l - 1), fromJust (last l))


divideUntil' :: Integer -> State Integer Integer
divideUntil' d = state (divideUntil d)

primeFactors :: Integer -> [Integer]
primeFactors n = eval n (map divideUntil' primes) 
    where eval :: Integer -> [State Integer Integer] -> [Integer]  -- the 2nd arg is infinite
          eval 1 _ = []
          eval n (s:ss) = let (a, n') = runState s n 
                          in a : eval n' ss


prettyPrintPrimeFactors :: Integer -> String
prettyPrintPrimeFactors n = let factors = primeFactors n
                            in " 1" ++ 
        foldr (\(factor,exponent) str -> 
                    if exponent /= 0
                    then " * " ++ show factor ++ "^" ++ show exponent ++ str
                    else str) " " (zip primes factors)





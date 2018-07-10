import Data.List
import PrimeFactorization
data AST = AST { name :: String, params :: [AST]}  deriving (Eq)

instance Show AST where
    show (AST s ps) = s ++ "(" ++ intercalate ";" (map show ps) ++ ")"

operators = ["z", "s", "+", "*"]

encodeName :: String -> Integer -- we want index start with 1
encodeName str = toInteger  (1 + head (elemIndices str operators))


encodeAST :: AST -> Integer
encodeAST (AST s ps) = head primes ^ encodeName s * product (zipWith (^) primes (map encodeAST ps))

decodeName :: Int -> Maybe String
decodeName i | 0 <= i-1 && i - 1 < length operators = Just $ operators !! (i-1)
decodeName i | otherwise = Nothing

decodeAST :: Integer -> Maybe AST
decodeAST n | n <= 1 = Nothing  -- this indicates an error, guaranteed pattern match failure
decodeAST n = let (hd:tl) = primeFactors n
              in do 
                    s <- decodeName (fromInteger hd)
                    ps <- mapM decodeAST tl
                    return (AST s ps)

listAST  = filter (\(idx, ast) -> ast /= Nothing) $ zip [1..] (map decodeAST [1..])

printListAST = mapM_ (\(idx, ast) -> putStrLn (show idx ++ ": " ++ show ast)) listAST

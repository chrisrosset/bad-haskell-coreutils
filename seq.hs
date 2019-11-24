-- seq - print a sequence of numbers
-- seq LAST
-- seq FIRST LAST
-- seq FIRST INCREMENT LAST
-- Arguments must be integers.
-- FIRST and INCREMENT default to 1 if omitted.


module Main where

import Data.Maybe
import Data.List
import Text.Read
import qualified System.Environment

data Sequence = Sequence { first :: Int
                         , incr :: Int
                         , last :: Int
                         }

parseArgs :: [String] -> Either String Sequence
parseArgs [] = Left "seq: missing operand"
parseArgs [lst] = parseArgs ["1.0", "1.0", lst]
parseArgs [fst, lst] = parseArgs [fst, "1.0", lst]
parseArgs whole@[str1, str2, str3] = case zip whole $ map readMaybe whole of
    [(_, Just fst), (_, Just inc), (_, Just lst)] -> Right $ Sequence fst inc lst
    val -> Left $ "seq: invalid integral argument: " ++ firstBad
      where firstBad = fst $ head $ filter (isNothing . snd) val
parseArgs (fst:inc:lst:unk:xs) = Left $ "seq: extra operand " ++ unk

materializeSequence :: Sequence -> [Int]
materializeSequence (Sequence f i l) = takeWhile (<= l) $ iterate (+ i) f

main :: IO ()
main = do
  args <- System.Environment.getArgs
  let sequence = parseArgs args
  case sequence of
    Left err -> putStrLn err
    Right seq -> mapM_ (putStrLn . show) $ materializeSequence seq

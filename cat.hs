module Main where

import qualified Data.Text
import qualified Data.Text.IO
import System.Environment
import System.Exit

usage :: IO ()
usage = putStrLn "Usage: cat [--help] [--version] [file ..]"

parseArgs :: [String] -> [String]
parseArgs args
  | null args = ["-"]
  | any ((==) "--help") pre = ["--help"]
  | any ((==) "--version") pre = ["--version"]
  | otherwise = if length(pst) == 0 then pre else (++) pre $ tail pst
    where
      (pre, pst) = break ((==) "--") args

processName :: String -> IO (Data.Text.Text)
processName "-" = Data.Text.IO.getContents
processName fnm = Data.Text.IO.readFile fnm

processArgs :: [String] -> IO ()
processArgs ["--help"] = usage
processArgs files = do
  names <- mapM processName files
  mapM_ Data.Text.IO.putStr names

main :: IO ()
main = fmap parseArgs getArgs >>= processArgs

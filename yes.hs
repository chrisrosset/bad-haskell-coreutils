module Main where

import qualified Control.Monad
import qualified Data.Text
import qualified Data.Text.IO
import qualified System.Environment as E

-- Build the output line based on the command line arguments.
buildText :: [String] -> Data.Text.Text
buildText l = Data.Text.pack $ if null l then "yes" else unwords l

main :: IO ()
main = do
  args <- E.getArgs
  let text = buildText args
  Control.Monad.forever $ Data.Text.IO.putStrLn text

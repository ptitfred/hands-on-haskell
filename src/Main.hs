module Main where

import Example as E

import Jarvis

main :: IO ()
main = loop
  where
    loop = do
      line <- askUser "How can I help you ?"
      evalQuery line
      loop

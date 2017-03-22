module Main where

import Example as E

import Jarvis

main :: IO ()
main = do
  line <- askUser "How can I help you ?"
  evalQuery line
  main

module Main where

import System.Exit (exitSuccess)

jarvisSay :: String -> IO ()
jarvisSay s = putStrLn $ "jarvis > " ++ s  

askUser :: String -> IO String
askUser s = jarvisSay s >> getLine

evalQuery :: String -> IO ()
evalQuery query = case getWords' query of
                    ("help":_) -> jarvisSay "Type one of the following commands : help, bye"
                    ("why":_) -> jarvisSay $ "Let me think... Hum... Nope. Sorry I don't know " ++ query ++ " :("
                    ("bye":_) -> jarvisSay "See you soon !" >> exitSuccess
                    otherwise -> jarvisSay "Sorry, I didn't understand the request"

getWords :: String -> [String]
getWords s = wordsRoutine s "" []
  where
    wordsRoutine :: String -> String -> [String] -> [String]
    wordsRoutine "" currentWord acc = acc ++ [currentWord]
    wordsRoutine (x:xs) currentWord acc = if x == ' ' 
                                             then wordsRoutine xs "" (acc ++ [currentWord])
                                             else wordsRoutine xs (currentWord ++ [x]) acc

-- Alternative implementation
getWords' :: String -> [String]
getWords' "" = []
getWords' s = 
  let 
    notSpace = (/=) ' '
    wordFound = takeWhile notSpace $ s
    rest = removeLeadingSpaces . dropWhile notSpace $ s
  in
    wordFound : getWords' rest
  where
    removeLeadingSpaces :: String -> String
    removeLeadingSpaces = dropWhile (== ' ')

main :: IO ()
main = loop
  where
    loop = do
      line <- askUser "How can I help you ?"
      evalQuery line
      loop

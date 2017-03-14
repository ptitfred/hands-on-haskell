module Main where

askUser :: String -> IO String
askUser s = putStrLn s >> getLine

evalQuery :: String -> String
evalQuery query = "Not implemented yet"

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
      line <- askUser "What do you want to do ?"
      putStrLn $ evalQuery line
      loop

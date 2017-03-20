module Utils where

import Data.Maybe

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x


-- NOTE : an example for recursion
-- TODO : Implémenter la fonction `getWords` qui sépare une chaîne de caractère en un tableau de mots

-- getWords :: ???
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

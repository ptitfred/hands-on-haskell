module Utils where

import Data.Maybe

-- NOTE : an example for recursion
-- TODO : Implémenter la fonction `getWords` qui sépare une chaîne de caractère en un tableau de mots
-- getWords :: ???
-- getWords = undefined


safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

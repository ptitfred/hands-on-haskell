module Example where
--        ^
-- Déclaration de module

-- import Example (someFunction, otherFunction) where
--                   ^
-- On peut aussi choisir quelles fonctions notre module expose

import Prelude
--       ^
-- Pour importer un package : import MonPackage

-- On peut choisir d'importer quelques fonctions : import MonPackage (aFunction, anotherFunction)
-- On peut aussi faire des imports 'qualifiés' : import qualified MonPackage as P

-------------------
-- LES FONCTIONS --
-------------------

-- Déclaration de fonction
-- nomDeLaFonction :: signature
-- nomDeLaFonction parametre1 parametre2 = corps_de_la_fonction

-- Exemples

-- Fonction qui ne prend pas de paramètre
simpleFunction :: Int
simpleFunction = 23

-- Fonction qui prend 1 seul paramètre
addOne :: Int -> Int
addOne x = x + 1

addOne' :: Int -> Int
addOne' = (+ 1)

-- Fonction qui prend 2 paramètre
add :: Int -> Int -> Int
add x y = x + y

-- En fait on peut écrire
-- add :: Int -> (Int -> Int)
--               {----^-----}
--             une fonction qui prend en paramètre un Int et renvoie un Int
-- Pour résumer on peut considérer que :
-- add est une fonction qui prend un Int et renvoie une fonction qui prend en paramètre un Int et renvoie un Int

-- curryfication for free \o/

addOne'' :: Int -> Int
addOne'' = add 1

result :: Int
result = addOne'' 8

-- Ecrivons d'autres fonctions

isGreater :: Int -> Int -> Bool
isGreater x y = x > y

addS :: String -> String
addS s = s ++ "s"

-- Nos fonctions peuvent aussi prendre d'autres fonctions en paramètre
applyFunc :: (Int -> Int) -> Int -> Int
applyFunc f x = f x


------------------
-- LA RECURSION --
------------------

-- Pas de boucles for, while ou autres

factoriel :: Int -> Int
factoriel 0 = 1
factoriel n = n * factoriel (n - 1)

-- /!\ Si on veut que la recursion se termine, il faut bien réfléchir au cas de base !

---------------------------------------
-- PATTERN MATCHING ET DESTRUCTURING --
---------------------------------------

-- Le destructuring permet de déconstruire une structure de données

-- Exemple sur les tableaux

arrayDestructuring :: [Int] -> Int
arrayDestructuring [] = 0
arrayDestructuring (x:xs) = x
--                  ^ ^
--                  | |______ le reste de notre tableau
--                  |
--    le premier élément du tableau

-- Le pattern matching permet d'appliquer des implémentations différentes selon les cas rencontrés
arrayPatternMatching :: [Int] -> String
arrayPatternMatching [] = "This is empty :O"
arrayPatternMatching [x] = "You have one element !"
arrayPatternMatching (x:xs) = "You have a lot of elements !"


-- /!\ L'ORDRE DES PATTERNS EST IMPORTANT ! Le premier pattern vérifié est celui utilisé

wrongPatternMatching :: [Int] -> String
wrongPatternMatching [] = "This is empty :O"
wrongPatternMatching (x:xs) = "You have a lot of elements !"
wrongPatternMatching [x] = "You have one element !"

-- Que renvoie :
-- - wrongPatternMatching []
-- - wrongPatternMatching [1, 5]
-- - wrongPatternMatching [3]

------------------------------
-- ITERATION SUR DES LISTES --
------------------------------

-- PRINCIPE : utiliser la récursion, le pattern matching et le destructuring

applyToElements :: (Int -> Int) -> [Int] -> [Int]
applyToElements _ [] = []
applyToElements f (x:xs) = f x : applyToElements f xs


----------------------
-- LES TYPES CUSTOM --
----------------------

data Fruit
    = Apple String
    | Banana Int
    | Unknown

-- Pour définir un type on utilise `data`
-- Fruit est le nom du type : utilisé dans les signatures de fonctions ou dans d'autres types
-- Apple, Banana, Unknown sont des constructeurs

-- NOTE : les constructeurs sont des fonctions
-- Apple :: String -> Fruit
-- Banana :: Int -> Fruit
-- Unknown :: Fruit

someFruits :: [Fruit]
someFruits = [ Unknown, Banana 2, Apple "golden", Apple "the other one", Banana 6, Unknown ]


-- NOTE : On peut aussi faire du destructuring / pattern matching !

whatItIs :: Fruit -> String
whatItIs (Apple name) = "This is a " ++ name ++ " apple !"
whatItIs (Banana number) = "This is banana #" ++ (show number)
whatItIs _ = "I don't know what it is ! :O"

module Jarvis where

import System.Exit (exitSuccess)

import Utils
import Contact

-- TODO : Jarvis doit réagir différemment en fonction de la commande qu'on tape ("help", "why", "bye", "ping", ...)
-- NOTE : utiliser la fonction `getWords` qu'on a implémenté pour récupérer la commande
evalQuery :: String -> IO ()
evalQuery = undefined

-- TODO : Implémenter la fonction `pingCommand` qui utilisera le premier mot après la commande pour chercher un contact
pingCommand :: [String] -> IO ()
pingCommand = undefined



jarvisSay :: String -> IO ()
jarvisSay s = putStrLn $ "jarvis > " ++ s

askUser :: String -> IO String
askUser s = jarvisSay s >> getLine

helpCommand :: IO ()
helpCommand = jarvisSay "Type one of the following commands : help, contact, why, bye"

whyCommand :: String -> IO ()
whyCommand query = jarvisSay $ "Let me think... Hum... Nope. Sorry I don't know " ++ query ++ " :("

byeCommand :: IO ()
byeCommand = jarvisSay "See you soon !" >> exitSuccess

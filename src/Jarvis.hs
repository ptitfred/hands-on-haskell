module Jarvis where

import System.Exit (exitSuccess)

import Utils
import Contact

jarvisSay :: String -> IO ()
jarvisSay s = putStrLn $ "jarvis > " ++ s

askUser :: String -> IO String
askUser s = jarvisSay s >> getLine

evalQuery :: String -> IO ()
evalQuery query = case getWords' query of
                    ("help":_) -> jarvisSay "Type one of the following commands : help, bye"
                    ("why":_) -> whyCommand query
                    ("bye":_) -> byeCommand
                    ("ping":contacts) -> pingCommand contacts
                    otherwise -> jarvisSay "Sorry, I didn't understand the request"

helpCommand :: IO ()
helpCommand = jarvisSay "Type one of the following commands : help, contact, why, bye"

whyCommand :: String -> IO ()
whyCommand query = jarvisSay $ "Let me think... Hum... Nope. Sorry I don't know " ++ query ++ " :("

byeCommand :: IO ()
byeCommand = jarvisSay "See you soon !" >> exitSuccess

pingCommand :: [String] -> IO ()
pingCommand [] = jarvisSay "Godamit, I don't know who to ping !"
pingCommand (name:_) = case findContactByName name contactsList of
                      Nothing -> jarvisSay $ "Sorry you don't have any friends named " ++ name
                      Just (Contact _ mail) -> jarvisSay $ "I can't do it right now but here is the email " ++ mail

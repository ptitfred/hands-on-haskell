module Main where

import System.Exit (exitSuccess)

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


data Contact = Contact String String deriving Show

contactsList :: [Contact]
contactsList = [ Contact "plop" "plop@mail.com"
               , Contact "thomas" "thomas@mail.com"
               ]

findContactByName :: String -> [Contact] -> Maybe Contact
findContactByName name = safeHead . filter (\(Contact name' _) -> name' == name)

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

-- NOTE : an example for recursion
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

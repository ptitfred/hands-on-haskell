module Contact where

import Utils

data Contact = Contact String String deriving Show

contactsList :: [Contact]
contactsList = [ Contact "plop" "plop@mail.com"
               , Contact "thomas" "thomas@mail.com"
               ]

findContactByName :: String -> [Contact] -> Maybe Contact
findContactByName name = safeHead . filter (\(Contact name' _) -> name' == name)

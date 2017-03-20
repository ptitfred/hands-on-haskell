module Contact where

import Utils

-- TODO : Ecrire un type `Contact` qui devra avoir :
-- - un nom
-- - un email
data Contact = Contact String String deriving Show


contactsList :: [Contact]
contactsList = [ Contact "plop" "plop@mail.com"
               , Contact "thomas" "thomas@mail.com"
               ]

-- TODO : Ecrire une fonction `findContactByName` qui permet de trouver un contact par nom
-- Signature de la fonction : findContactByName :: String -> [Contact] -> Maybe Contact
findContactByName :: String -> [Contact] -> Maybe Contact
findContactByName name = safeHead . filter (\(Contact name' _) -> name' == name)

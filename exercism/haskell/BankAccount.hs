module BankAccount
    ( BankAccount
    , closeAccount
    , getBalance
    , incrementBalance
    , openAccount
    ) where

import Control.Concurrent.MVar
import Control.Monad (void)

type BankAccount = MVar (Maybe Integer)

closeAccount :: BankAccount -> IO ()
closeAccount account = void (swapMVar account Nothing)

getBalance :: BankAccount -> IO (Maybe Integer)
getBalance = readMVar

incrementBalance :: BankAccount -> Integer -> IO (Maybe Integer)
incrementBalance account amount = do
  n <- takeMVar account
  let new =
        do
          val <- n
          return $! val + amount
  putMVar account $! new
  return new

openAccount :: IO BankAccount
openAccount = newMVar (Just 0)

module Lib
    ( someFunc
    ) where

import System.IO
import Data.Default
import Network.Socket
import Haskell.Debug.Adapter.Control

someFunc :: IO ()
someFunc = do

  sock <- socket AF_INET Stream defaultProtocol
  let host = tupleToHostAddress (0, 0, 0, 0)
      port = 9999
      reqQ = 5

  bind sock $ SockAddrInet port host
  listen sock reqQ

  putStrLn "[INFO] start server."
  go sock

  putStrLn "[INFO] end of server."

  where
    go sock = do
      putStrLn "[INFO] wait request."
      (conn, addr) <- accept sock

      putStrLn $ "[INFO] accepted. " ++ show addr
      putStrLn "[INFO] create handle."
      hdl <- socketToHandle conn ReadWriteMode

      putStrLn "[INFO] start debugging."
      run def hdl hdl

      putStrLn "[INFO] end of debug."
      go sock



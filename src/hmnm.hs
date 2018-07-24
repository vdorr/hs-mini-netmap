{-# OPTIONS_GHC -fwarn-incomplete-patterns -fwarn-unused-binds -fwarn-unused-imports -fno-warn-tabs #-}

import System.Console.ANSI (clearScreen)
import System.Environment (getArgs)

import System.Linux.NetInfo
import Network.MiniNetMap
import Network.MiniNetMap.Ping

--FIXME handle ctrl+c cleanly
main :: IO ()
main = do
	args <- getArgs
	let active = take 1 args == ["--active"]

	let pingHook
		| active = \nis body -> withPingNewSubnets nis $
			\ps ->
				pingAll ps --ping everything once on start
				>> body
		| otherwise = \_ body -> body

	withNetInfo $ \netInfoSock -> do
		pingHook netInfoSock $  do
			newsLoop netInfoSock $ \(event, ifMap) -> do
				clearScreen
				putStrLn "--------------------------------------------------------------------------------"
				dumpIfMap putStrLn ifMap
				return Nothing


#!/usr/bin/env runhaskell
{-
 - Script to convert a list of colors to an HTML page showing those colors in a grid.
 - 
 - Input: a list of colors (one per line) in any format that is valid in CSS
 - Output: HTML
 -
 -}
module Main where

import System.IO
import System.Environment
import Control.Monad
import Data.List

main = do
    args <- getArgs
    writeHeader
    colors <- liftM (nub . filter (not . null) . lines) getContents
    let pp = if "--sort" `elem` args then sort else id
    mapM_ writeColor (pp colors)
    writeFooter

writeHeader :: IO ()
writeHeader = putStrLn $ unlines $
    [ "<!DOCTYPE html>"
    , "<html>"
    , "  <head>"
    , "    <meta charset=\"UTF-8\">"
    , "    <title>Color palette</title>"
    , "  </head>"
    , "  <body>"
    , "  <ul style='margin-left:0;list-style:none;'>"
    ]

writeFooter :: IO ()
writeFooter = putStrLn $ unlines $
    [ "  </ul>"
    , "  </body>"
    , "</html>"
    ]

writeColor :: String -> IO ()
writeColor color = putStrLn $ unlines $
        [ "    <li style='width:220px;display:inline-block;padding-left:10px;padding-right:10px;'>"
        , "      <div style='display:table-cell;vertical-align:center;border:1px solid black;width:100px;height:100px;background-color:" ++ color ++ ";'></div>"
        , "      <div style='display:table-cell;width:10px'></div>"
        , "      <span style='display:table-cell;font-family:Consolas;vertical-align:middle;'>" ++ color ++ "</span>"
        , "    </li>"
        ]




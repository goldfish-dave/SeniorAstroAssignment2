import Data.List

deletenth :: Int -> [String] -> [String]
deletenth n columns =
    if length columns == 30
        then take (n-1) columns ++ drop n columns
        else columns

parseLines linez = map (filter (/= ' ') . unwords . intersperse "," . deletenth 16 . words) . lines $ linez

modFile inname outname = do
    inlines <- readFile inname
    writeFile outname . unlines $ parseLines inlines

main = do
    let files = map (("table" ++) . show) [2,11,18]
    mapM_ (\filename -> modFile (filename ++ ".dat") (filename ++ ".csv")) files

module GuessingGame where
import Control.Monad (forever)
import System.Random (randomRIO)
import Text.Read (readMaybe)

guessRange :: (Int, Int)
guessRange =  (1, 10)

type Result = (Bool, String)

win :: Result
win = (True, "You win!")

tryAgain :: Result
tryAgain = (False, "Sorry, try again!")

badRange :: Result
badRange = (False, "Please enter a number in the range " ++ 
    show guessRange  ++ " inclusive.")

parseError :: Result
parseError = (False, "Please enter a number!")

checkGuess :: String -> Int -> Result
checkGuess guess answer = let guess' = (readMaybe guess :: Maybe Int) 
                              inRange x (a, b) = x `elem` [a..b] in
    case guess' of (Just guess'') -> if guess'' `inRange` guessRange
                                        then if guess'' == answer 
                                             then win
                                             else tryAgain
                                        else badRange
                   Nothing        -> parseError

guessingGame :: Int -> IO ()
guessingGame answer = do
    putStrLn $ "Guess a number between " ++ (show . fst) guessRange ++ " and " ++ (show . snd) guessRange ++ "."
    putStr "Make your guess! "
    guess <- getLine
    putStrLn $ "You guessed: " ++ guess
    let (won, response) = checkGuess guess answer
    putStrLn response
    if won then return () else guessingGame answer
    
main :: IO ()
main = do
    answer <- randomRIO guessRange
    putStrLn "Welcome to the guessing game!"
    guessingGame answer

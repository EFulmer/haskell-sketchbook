{-# LANGUAGE TemplateHaskell #-}
module FE where
import Control.Lens
import System.Random

data Character = Character { _name :: String, _klass :: String, _level :: Int,
    _stats :: Stats, _growths :: Stats }

data Stats = Stats { _hp :: Int, _pow :: Int, _skl :: Int, _spd :: Int, 
    _lck :: Int, _def :: Int, _res :: Int }

makeLenses ''Character
makeLenses ''Stats

eliwood = Character { _name = "Eliwood", _klass = "Lord", _level = 1,
    _stats = Stats { _hp = 18, _pow = 5, _skl = 5, _spd = 7, _lck = 7, 
        _def = 5, _res = 0 },
    _growths = Stats { _hp = 80, _pow = 45, _skl = 50, _spd = 50, _lck = 45,
        _def = 30, _res = 35 }
    }

levelUp :: (RandomGen g) => Character -> g -> Character
levelUp char gen = let
    rolls :: [Int]
    rolls = take 7 $ randomRs (1, 100) gen
    in
    undefined

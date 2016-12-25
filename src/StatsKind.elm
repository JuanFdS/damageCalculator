module StatsKind exposing (..)

import Pokemon exposing (..)
import Stats exposing (..)

type StatsKind = Iv | Ev | Base | Powerup

get : StatsKind -> Pokemon -> Stats
get statsKind =
  case statsKind of
    Iv -> .ivs
    Ev -> .evs
    Base -> .base
    Powerup -> .powerup
set : StatsKind -> Stats -> Pokemon -> Pokemon
set statsKind newValue pokemon =
  case statsKind of
    Iv -> { pokemon | ivs = newValue }
    Ev -> { pokemon | evs = newValue }
    Base -> { pokemon | base = newValue }
    Powerup -> { pokemon | powerup = newValue }
validValues : StatsKind -> List Int
validValues statsKind =
  case statsKind of
    Iv -> 0 <-> 31
    Ev -> 0 <-> 255
    Base -> 0 <-> 999
    Powerup -> -6 <-> 6
update : StatsKind -> (Stats -> Stats) -> Pokemon -> Pokemon
update statsKind f pokemon = (\newValue -> set statsKind newValue pokemon) <| f <| get statsKind pokemon

(<->) : Int -> Int -> List Int
(<->) a b = if (b >= a) then List.range a b else List.reverse <| List.range b a
infixr 9 <->

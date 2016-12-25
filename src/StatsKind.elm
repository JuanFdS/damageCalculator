module StatsKind exposing (..)

import Stats exposing (..)

type alias WithStats a = { a | ivs : Stats, evs : Stats, base : Stats, powerup : Stats}

type StatsKind = Iv | Ev | Base | Powerup

get : StatsKind -> WithStats a -> Stats
get statsKind =
  case statsKind of
    Iv -> .ivs
    Ev -> .evs
    Base -> .base
    Powerup -> .powerup
set : StatsKind -> Stats -> WithStats a -> WithStats a
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
    Base -> 1 <-> 255
    Powerup -> -6 <-> 6
initValue statsKind =
  case statsKind of
    Iv -> 31
    Ev -> 0
    Base -> 1
    Powerup -> 0
newStats statsKind = Stats.newWith <| initValue statsKind
update : StatsKind -> (Stats -> Stats) -> WithStats a -> WithStats a
update statsKind f pokemon = (\newValue -> set statsKind newValue pokemon) <| f <| get statsKind pokemon

(<->) : Int -> Int -> List Int
(<->) a b = if (b >= a) then List.range a b else List.reverse <| List.range b a
infixr 9 <->

module Pokemon exposing (..)

import Stats exposing (..)
import StatsKind exposing (..)

type alias Pokemon = {ivs : Stats, evs : Stats, base : Stats, powerup : Stats, level : Int}

new : Pokemon
new = {ivs = newStats Iv, evs = newStats Ev, base = newStats Base, powerup = newStats Powerup, level = 1}

finalStat stat iv ev base level =
  case stat of
    Hp -> ((2 * base + iv + (ev // 4)) * level // 100) + level + 10
    otherStats -> ((2 * base + iv + (ev // 4)) * level // 100) + 5

finalStatOf stat pokemon = let getStat f = Stats.get stat (f pokemon) in
  finalStat stat (getStat .ivs) (getStat .evs) (getStat .base) pokemon.level

finalStats : Pokemon -> Stats
finalStats pokemon = {hp = finalStatOf Hp pokemon, atk = finalStatOf Atk pokemon,
                      def = finalStatOf Def pokemon, spA = finalStatOf SpA pokemon,
                      spD = finalStatOf SpD pokemon, spe = finalStatOf Spe pokemon}

view : Pokemon -> String
view pokemon = "You got a pokemon with these stats: " ++ (toString <| finalStats pokemon)

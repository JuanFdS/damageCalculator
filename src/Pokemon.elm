module Pokemon exposing (..)

import Stats exposing (..)

type alias Pokemon = {ivs : Stats, evs : Stats, base : Stats, powerup : Stats}

new : Pokemon
new = {ivs = Stats.new, evs = Stats.new, base = Stats.new, powerup = Stats.new}

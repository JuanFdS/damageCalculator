module Stats exposing (..)

type alias Stats = { hp: Int, atk: Int, def: Int, spA : Int, spD : Int, spe : Int }
updateHp f stats = { stats | hp = f stats.hp  }
updateAtk f stats = { stats | atk = f stats.atk  }
updateDef f stats = { stats | def = f stats.def  }
updateSpA f stats = { stats | spA = f stats.spA  }
updateSpD f stats = { stats | spD = f stats.spD  }
updateSpe f stats = { stats | spe = f stats.spe  }

type Stat = Hp | Atk | Def | SpA | SpD | Spe

set : Stat -> Int -> Stats -> Stats
set stat newValue stats =
  case stat of
    Hp -> { stats | hp = newValue  }
    Atk -> { stats | atk = newValue  }
    Def -> { stats | def = newValue  }
    SpA -> { stats | spA = newValue  }
    SpD -> { stats | spD = newValue  }
    Spe -> { stats | spe = newValue  }

get : Stat -> Stats -> Int
get stat =
  case stat of
    Hp -> .hp
    Atk -> .atk
    Def -> .def
    SpA -> .spA
    SpD -> .spD
    Spe -> .spe

statName : Stat -> String
statName stat =
  case stat of
    Hp -> "Hp"
    Atk -> "Atk"
    Def -> "Def"
    SpA -> "SpA"
    SpD -> "SpD"
    Spe -> "Spe"

update : Stat -> (Int -> Int) -> Stats -> Stats
update stat f stats = (\newValue -> set stat newValue stats) <| f <| get stat stats

allStats : List Stat
allStats = [Hp, Atk, Def, SpA, SpD, Spe]

statSetters : List (Int -> Stats -> Stats)
statSetters = List.map set allStats

statGetters : List (Stats -> Int)
statGetters = List.map get allStats

new : Stats
new = {hp = 0, atk = 0, def = 0, spA = 0, spD = 0, spe = 0}

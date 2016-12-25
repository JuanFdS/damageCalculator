module Stats exposing (..)

type alias Stats = { hp: Int, atk: Int, def: Int, spA : Int, spD : Int, spe : Int }
updateAtk f stats = { stats | atk = f stats.atk  }
updateHp f stats = { stats | hp = f stats.hp  }
updateDef f stats = { stats | def = f stats.def  }
updateSpA f stats = { stats | spA = f stats.spA  }
updateSpD f stats = { stats | spD = f stats.spD  }
updateSpe f stats = { stats | spe = f stats.spe  }

setAtk newValue = updateAtk (\_ -> newValue)
setHp newValue = updateHp (\_ -> newValue)
setDef newValue = updateDef (\_ -> newValue)
setSpA newValue = updateSpA (\_ -> newValue)
setSpD newValue = updateSpD (\_ -> newValue)
setSpe newValue = updateSpe (\_ -> newValue)

statSetters : List (Int -> Stats -> Stats)
statSetters = [setHp, setAtk, setDef, setSpA, setSpD, setSpe]

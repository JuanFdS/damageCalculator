module DamageCalculator exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import SpecialDropdowns exposing (..)
import Stats exposing (..)

(:=) : String -> Html msg -> Html msg
(:=) name component = div [] [text name, component]
infixr 9 :=

main = Html.beginnerProgram { model = model , view = view , update = update }

type alias Model = {ivs : Stats, evs : Stats}

type Msg = IvChange (Stats -> Stats) | EvChange (Stats -> Stats) | NoOp

model : Model
model = { ivs = {hp = 0, atk = 0, def = 0, spA = 0, spD = 0, spe = 0},
          evs = {hp = 0, atk = 0, def = 0, spA = 0, spD = 0, spe = 0}}

update : Msg -> Model -> Model
update msg model =
  case msg of
    IvChange statChange -> { model | ivs = statChange model.ivs }
    EvChange statChange -> { model | evs = statChange model.evs }
    NoOp -> model

statSetterDropdown statType maxValue statSetter = numericDropdown NoOp (statType << statSetter) (List.range 0 maxValue)

statsRelatedDropdowns statType maxValue = div [] (List.map (statSetterDropdown statType maxValue) statSetters
                                                    |> List.map2 (:=) ["HP", "Atk", "Def", "Spa", "SpD", "Spe"])

view : Model -> Html.Html Msg
view model = div [] <| [div [] [text <| "The stats on your pokemon are: " ++ toString model],
                        "IVs: " := (statsRelatedDropdowns IvChange 31),
                        "EVs: " := (statsRelatedDropdowns EvChange 255)
                       ]

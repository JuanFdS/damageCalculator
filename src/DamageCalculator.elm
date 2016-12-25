module DamageCalculator exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import SpecialDropdowns exposing (..)
import Stats exposing (..)
import StatsKind exposing (..)
import Input.Number exposing (..)
import Pokemon exposing (..)

(:=) : String -> Html msg -> Html msg
(:=) name component = div [] [text name, component]
infixr 9 :=

main = Html.beginnerProgram { model = pokemon , view = view , update = update }

type Msg = StatsChange (Pokemon -> Pokemon)

pokemon : Pokemon
pokemon = Pokemon.new

update : Msg -> Pokemon -> Pokemon
update msg pokemon =
  case msg of
    StatsChange statsChange -> statsChange pokemon

statsRelatedInput : StatsKind -> Pokemon -> Stat -> Html Msg
statsRelatedInput statsKind pokemon stat  = let valuesRange = validValues statsKind in
  Input.Number.input {maxLength = Nothing,
                      maxValue = List.maximum valuesRange,
                      minValue = List.minimum valuesRange,
                      hasFocus = Nothing,
                      onInput = StatsChange << StatsKind.update statsKind << Stats.set stat << Maybe.withDefault 0
                      } []      (pokemon    |> StatsKind.get    statsKind >> Stats.get stat >> Just)

statsRelatedInputs : StatsKind -> Pokemon -> Html Msg
statsRelatedInputs statsKind pokemon =
  div [] (List.map (statsRelatedInput statsKind pokemon) allStats
            |> List.map2 (:=) (List.map statName allStats))

view : Pokemon -> Html.Html Msg
view pokemon = div [] <| [div [] [text <| "The stats on your  are: " ++ toString pokemon],
                         "Ivs: " := statsRelatedInputs Iv pokemon,
                         "Evs: " := statsRelatedInputs Ev pokemon,
                         "Base stats: " := statsRelatedInputs Base pokemon,
                         "Powerups: " := statsRelatedInputs Powerup pokemon
                        ]

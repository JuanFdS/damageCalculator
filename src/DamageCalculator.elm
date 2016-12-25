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
(:=) name component = div [ style [("display","inline-block")]] [text name, component]
infixr 9 :=

main = Html.beginnerProgram { model = pokemon , view = view , update = update }

type Msg = StatsChange (Pokemon -> Pokemon) | LevelChange Int

pokemon : Pokemon
pokemon = Pokemon.new

update : Msg -> Pokemon -> Pokemon
update msg pokemon =
  case msg of
    StatsChange statsChange -> statsChange pokemon
    LevelChange newLevel -> { pokemon | level = newLevel }

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

levelInput pokemon = Input.Number.input {maxLength = Nothing, maxValue = Just 100, minValue = Just 1, hasFocus = Nothing,
                                 onInput = LevelChange << Maybe.withDefault 0
                               } [] (Just pokemon.level)

view : Pokemon -> Html.Html Msg
view pokemon = div [] <| [h3 [] [text <| Pokemon.view pokemon],
                         "Level: " := levelInput pokemon,
                         "Ivs: " := statsRelatedInputs Iv pokemon,
                         "Evs: " := statsRelatedInputs Ev pokemon,
                         "Base stats: " := statsRelatedInputs Base pokemon,
                         "Powerups: " := statsRelatedInputs Powerup pokemon
                        ]

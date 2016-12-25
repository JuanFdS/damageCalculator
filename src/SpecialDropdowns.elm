module SpecialDropdowns exposing (numericDropdown, textDropdown)
import Dropdown
import Result exposing (map, withDefault)
import Html exposing (Html)

type alias Decoder value error = String -> Result error value
type alias Encoder value = value -> Dropdown.Item
type alias Dropdown value msg = msg -> (value -> msg) -> List value -> Html msg

onChangeHandlingErrors : msg -> (value -> msg) -> Decoder value error -> (Maybe String) -> msg
onChangeHandlingErrors nullAction onChange decoder possibleNewValue =
  case possibleNewValue of
    Nothing -> nullAction
    Just newValue -> newValue
                       |> decoder
                       |> map onChange
                       |> withDefault nullAction

dropdown : Decoder value error -> Encoder value -> msg -> (value -> msg) -> List value -> Html msg
dropdown decoder encoder nullAction onChange values = let items = List.map encoder values in
  Dropdown.dropdown { items = items, emptyItem = Nothing, onChange = onChangeHandlingErrors nullAction onChange decoder } [] Nothing

trivialEncoder : (value -> String) -> Encoder value
trivialEncoder transformation value = Dropdown.Item (transformation value) (transformation value) True

numericDropdown : Dropdown Int msg
numericDropdown = dropdown String.toInt (trivialEncoder toString)

textDropdown : Dropdown String msg
textDropdown = dropdown Ok (trivialEncoder identity)

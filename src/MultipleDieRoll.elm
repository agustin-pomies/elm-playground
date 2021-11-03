-- Press a button to generate a random number between 1 and 6.
--
-- Read how it works:
--   https://guide.elm-lang.org/effects/random.html
--

module MultipleDieRoll exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)

-- MAIN
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL
type alias Model = { diceFaces : ThreeDices }
type alias ThreeDices = { one: Int, two: Int, three: Int }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model { one = 1, two = 1, three = 1 }
  , Cmd.none
  )

-- UPDATE
type Msg
  = Roll
  | NewRoll3 ThreeDices

roll : Random.Generator Int
roll = Random.int 1 6

roll3 : Random.Generator ThreeDices
roll3 = Random.map3 ThreeDices roll roll roll

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( model
      , Random.generate NewRoll3 roll3
      )

    NewRoll3 newRoll3 ->
      ( Model newRoll3
      , Cmd.none
      )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ Html.text (String.fromInt model.diceFaces.one) ]
    , h1 [] [ Html.text (String.fromInt model.diceFaces.two) ]
    , h1 [] [ Html.text (String.fromInt model.diceFaces.three) ]
    , button [ onClick Roll ] [ Html.text "Roll x3" ]
    ]

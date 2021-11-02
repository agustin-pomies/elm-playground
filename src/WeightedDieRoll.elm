-- Press a button to generate a random number between 1 and 6.
--
-- Read how it works:
--   https://guide.elm-lang.org/effects/random.html
--

module WeightedDieRoll exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random

-- MAIN
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL
type alias Model = { dieFace : Int }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1
  , Cmd.none
  )

-- UPDATE
type Msg
  = Roll
  | NewFace Int

roll : Random.Generator Int
roll = Random.weighted
      (0, 1)
    [ (5, 2)
    , (30, 3)
    , (25, 4)
    , (20, 5)
    , (20, 6)
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( model
      , Random.generate NewFace roll
      )

    NewFace newFace ->
      ( Model newFace
      , Cmd.none
      )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (String.fromInt model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]

-- Press a button to generate a random number between 1 and 6.
--
-- Read how it works:
--   https://guide.elm-lang.org/effects/random.html
--

module ImgDieRoll exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
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
type alias Model = { dieFace : Int }

init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )

-- UPDATE
type Msg
    = Roll
    | NewFace Int

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
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
        [ img [src (url model.dieFace), Html.Attributes.width 100, Html.Attributes.height 100] []
        , button [ onClick Roll ] [ Html.text "Roll" ]
        ]

url : Int -> String
url face = String.concat ["./dieFaces/", String.fromInt(face), ".svg"]

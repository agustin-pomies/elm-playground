-- Input a user name and password. Make sure the password matches.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/forms.html
--

module SimpleSignUp exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- MAIN
main = Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }

init : Model
init = Model "" "" ""

-- UPDATE
type Msg
  = Name String
  | Password String
  | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Password password ->
      { model | password = password }
    PasswordAgain password ->
      { model | passwordAgain = password }

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model =
  if model.password /= model.passwordAgain then
    errorMessage "Passwords do not match!"
  else if String.length model.password < 8 then
    errorMessage "Password must be at least 8 characters long!"
  else if not (String.any Char.isDigit model.password && String.any Char.isUpper model.password && String.any Char.isLower model.password) then
    errorMessage "Password must contain a lower character, an upper character and a number"
  else
    div [ style "color" "green" ] [ text "OK" ]

errorMessage : String -> Html msg
errorMessage msg = div [ style "color" "red" ] [ text msg ]

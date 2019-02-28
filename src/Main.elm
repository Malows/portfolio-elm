module Main exposing (main, view)

import Browser
import Components.Profile as Profile
import Components.Service as Services
import Components.Welcome as Welcome
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..), update)
import Model exposing (Model, init)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Welcome.view model
        , Services.view model
        , Profile.view model
        ]

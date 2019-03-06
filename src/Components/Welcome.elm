module Components.Welcome exposing (view)

import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (classList)
import Html.Events exposing (onMouseLeave, onMouseOver)
import Messages exposing (Msg(..))
import Model exposing (Model)


view : Model -> Html Msg
view { overWelcome, welcomeMessage } =
    div
        [ classList
            [ ( "welcome", True )
            , ( "welcome--hover", overWelcome )
            ]
        ]
        [ h2
            [ classList
                [ ( "welcome__message", True )
                , ( "welcome__message--hover", overWelcome )
                ]
            , onMouseLeave (ChangeWelcome False)
            , onMouseOver (ChangeWelcome True)
            ]
            [ text welcomeMessage ]
        ]

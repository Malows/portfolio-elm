module Components.Welcome exposing (view)

import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (class)
import Model exposing (Model)


view : Model -> Html msg
view { welcomeMessage } =
    div [ class "welcome" ]
        [ h2 [ class "welcome__message" ] [ text welcomeMessage ]
        ]

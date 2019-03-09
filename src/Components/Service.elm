module Components.Service exposing (view)

import Html exposing (Html, div, h4, i, p, section, span, text)
import Html.Attributes exposing (class, id)
import Model exposing (Model)
import Types exposing (Service)


stackedIcon : String -> Html msg
stackedIcon icon =
    span [ class "fa-stack", class "fa-3x" ]
        [ i
            [ class "fas"
            , class "fa-circle"
            , class "fa-stack-2x"
            , class "text-primary"
            ]
            []
        , i
            [ class "fas"
            , class ("fa-" ++ icon)
            , class "fa-stack-1x"
            , class "fa-inverse"
            ]
            []
        ]


service : Service -> Html msg
service data =
    div [ class "service" ]
        [ stackedIcon data.icon
        , h4 [ class "service__heading" ] [ text data.title ]
        , p [ class "service__description", class "text-muted" ] [ text data.body ]
        ]


view : Model -> Html msg
view { services } =
    section [ id "services" ] (List.map service services)

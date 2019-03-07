module Components.Profile exposing (view)

import Components.Knowledge exposing (knowledgeLayout)
import Html exposing (Html, a, div, h4, i, img, li, p, section, span, text, ul)
import Html.Attributes exposing (class, href, id, src)
import Messages exposing (Msg)
import Model exposing (Model)


icon : String -> Html msg
icon brand =
    span
        [ class "fa-stack"
        , class "fa-lg"
        ]
        [ i
            [ class "fas"
            , class "fa-circle"
            , class "fa-stack-2x"
            ]
            []
        , i
            [ class "fab"
            , class ("fa-" ++ brand)
            , class "fa-stack-1x"
            , class "fa-inverse"
            ]
            []
        ]


socialLink : String -> String -> Html msg
socialLink brand url =
    li
        []
        [ a [ href url ] [ icon brand ]
        ]


disambleLink : ( String, String ) -> Html msg
disambleLink link =
    socialLink (Tuple.first link) (Tuple.second link)


socialList : List ( String, String ) -> Html msg
socialList list =
    ul [ class "profile__social" ] (List.map disambleLink list)


profile : List ( String, String ) -> Html msg
profile socialContacts =
    div [ class "profile" ]
        [ img
            [ class "profile__img"
            , class "img-responsive"
            , src "img/pht.png"
            ]
            []
        , h4 [ class "profile__title" ] [ text "Juan Manuel Cruz" ]
        , p [ class "profile__subtitle", class "text-muted" ] [ text "Senior Developer" ]
        , socialList socialContacts
        ]


view : Model -> Html Msg
view model =
    section [ id "profile" ]
        [ profile model.socialContact
        , knowledgeLayout model
        ]

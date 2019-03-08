module Components.Knowledge exposing (knowledgeLayout)

import Helpers exposing (picture)
import Html exposing (Html, div, img, p, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Types exposing (Knowledge)


knowledge : Knowledge -> Html Msg
knowledge data =
    div [ class "knowledges-item", onClick (ShowKnowledge data) ]
        [ div
            [ class "knowledges-item__img" ]
            [ img
                [ class "img-responsive"
                , src data.url
                ]
                []
            ]
        , p [ class "knowledges-item__title" ] [ text data.name ]
        ]


picInDescription : String -> Html msg
picInDescription url =
    div [ class "knowledges__description__img" ] [ img [ class "img-responsive", src url ] [] ]


stringSplitter : String -> List (Html msg)
stringSplitter txt =
    String.split "\n" txt
        |> List.map (\x -> p [ class "knowledges__description__text" ] [ text x ])


knowledgeDescription : Maybe Knowledge -> Html msg
knowledgeDescription selected =
    let
        empty =
            ""

        content =
            case selected of
                Nothing ->
                    [ p [ class "knowledges__description__text" ] [ text empty ] ]

                Just item ->
                    [ picInDescription item.url ] ++ stringSplitter item.description
    in
    div [ class "knowledges__description" ] content


knowledgeLayout : Model -> Html Msg
knowledgeLayout model =
    div [ class "knowledges" ]
        [ knowledgeDescription model.selectedKnowledge
        , div [ class "knowledges__items" ] (List.map knowledge model.knowledges)
        ]

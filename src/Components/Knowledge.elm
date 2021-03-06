module Components.Knowledge exposing (knowledgeLayout)

import Helpers exposing (picture)
import Html exposing (Html, div, img, p, text)
import Html.Attributes exposing (alt, class, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Types exposing (Knowledge)


last : String -> String -> Int
last search str =
    String.indexes search str
        |> List.reverse
        |> List.head
        |> Maybe.withDefault -1


skillFromUrl : String -> String
skillFromUrl url =
    let
        firstIndex =
            last "/" url

        lastIndex =
            last "." url
    in
    if firstIndex == -1 || lastIndex == -1 then
        "skill"

    else
        String.slice (firstIndex + 1) lastIndex url


knowledge : Knowledge -> Html Msg
knowledge data =
    div [ class "knowledges-item", onClick (ShowKnowledge data) ]
        [ div
            [ class "knowledges-item__img" ]
            [ img
                [ class "img-responsive"
                , src data.url
                , alt (skillFromUrl data.url ++ "'s skills")
                ]
                []
            ]
        , p [ class "knowledges-item__title" ] [ text data.name ]
        ]


picInDescription : String -> Html msg
picInDescription url =
    div
        [ class "knowledges__description__img" ]
        [ img
            [ class "img-responsive"
            , src url
            , alt (skillFromUrl url)
            ]
            []
        ]


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

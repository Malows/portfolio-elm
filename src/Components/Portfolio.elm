module Components.Portfolio exposing (view)

import Html exposing (Html, div, h4, i, img, p, section, text)
import Html.Attributes exposing (alt, class, id, src)
import Model exposing (Model)
import Types exposing (Portfolio)


itemLink : String -> String -> Html msg
itemLink url altText =
    div
        [ class "portfolio-item__link" ]
        [ div
            [ class "portfolio-item__hover-content" ]
            [ i
                [ class "fas"
                , class "fa-plus"
                , class "fa-3x"
                ]
                []
            ]
        , img
            [ class "img-responsive"
            , class "portfolio-item__img"
            , src url
            , alt altText
            ]
            []
        ]


itemCaption : String -> String -> Html msg
itemCaption title activity =
    div
        [ class "portfolio-item__caption" ]
        [ h4
            []
            [ text title ]
        , p
            [ class "text-muted" ]
            [ text activity ]
        ]


portfolioItem : Portfolio -> Html msg
portfolioItem { activity, imgThumbnail, title } =
    div
        [ class "portfolio-item" ]
        [ itemLink imgThumbnail title
        , itemCaption title activity
        ]


view : Model -> Html msg
view { selectedPortfolio, portfolios } =
    section
        [ id "portfolio" ]
        [ div
            [ class "portfolio__items" ]
            (List.map portfolioItem portfolios)
        ]

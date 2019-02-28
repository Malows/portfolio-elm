module Components.Portfolio exposing (portfolio, portfolioHover)

import Helpers exposing (picture)
import Html exposing (Html, div, h4, i, p, text)
import Html.Attributes exposing (class)
import Types exposing (Portfolio)


portfolioHover : Html msg
portfolioHover =
    div [ class "portfolio-item__hover-container", class "bg-primary--light" ]
        [ div [ class "portfolio-item__hover-content" ]
            [ i [ class "fas", class "fa-plus", class "fa-3x" ] []
            ]
        ]


portfolio : Portfolio -> Html msg
portfolio data =
    div [ class "portfolio-item" ]
        [ div [ class "portfolio-item__link" ]
            [ portfolioHover
            , picture [ class "img-responsive" ] data.imgThumbnail "jpg"
            ]
        , div [ class "portfolio-item__caption" ]
            [ h4 [] [ text data.title ]
            , p [ class "text-muted" ] [ text data.activity ]
            ]
        ]

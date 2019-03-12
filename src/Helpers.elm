module Helpers exposing (picture, sourceMaker)

import Html exposing (Html, img, node, source)
import Html.Attributes exposing (attribute, class, src, type_)


sourceMaker : String -> String -> Html msg
sourceMaker url tipo =
    source [ attribute "srcset" url, type_ tipo ] []


defaultMaker : String -> Html msg
defaultMaker url =
    img [ src url, class "img-responsive" ] []


picture : List (Html.Attribute msg) -> String -> String -> Html msg
picture attributes partialUrl defaultExtension =
    let
        mainUrl =
            partialUrl ++ ".webp"

        fallbackUrl =
            partialUrl ++ "." ++ defaultExtension

        sourceMain =
            sourceMaker mainUrl "image/webp"

        sourceFallback =
            defaultMaker fallbackUrl
    in
    node "picture" attributes [ sourceMain, sourceFallback ]

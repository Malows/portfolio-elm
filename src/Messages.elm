module Messages exposing (Msg(..), update)

import Model exposing (Model)
import Types exposing (Knowledge, Portfolio)


type Msg
    = ShowKnowledge Knowledge
    | HideKnowledge
    | OpenPortfolio Portfolio
    | ClosePortfolio
    | ChangeWelcome Bool


knowledgesCompare : Maybe Knowledge -> Knowledge -> Bool
knowledgesCompare maybe know =
    let
        default =
            Maybe.withDefault (Knowledge "" "" "") maybe
    in
    if default.name == "" then
        True

    else
        default.name /= know.name


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowKnowledge knowledge ->
            { model
                | selectedKnowledge =
                    if knowledgesCompare model.selectedKnowledge knowledge then
                        Just knowledge

                    else
                        Nothing
            }

        ChangeWelcome value ->
            { model | overWelcome = value }

        _ ->
            model

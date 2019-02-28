module Messages exposing (Msg(..), update)

import Types exposing (Knowledge, Portfolio)
import Model exposing (Model)


type Msg
    = ShowKnowledge Knowledge
    | HideKnowledge
    | OpenPortfolio Portfolio
    | ClosePortfolio


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowKnowledge knowledge ->
            { model | selectedKnowledge = Just knowledge }

        _ ->
            model

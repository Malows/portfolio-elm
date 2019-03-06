module Messages exposing (Msg(..), update)

import Model exposing (Model)
import Types exposing (Knowledge, Portfolio)


type Msg
    = ShowKnowledge Knowledge
    | HideKnowledge
    | OpenPortfolio Portfolio
    | ClosePortfolio
    | ChangeWelcome Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowKnowledge knowledge ->
            { model | selectedKnowledge = Just knowledge }

        ChangeWelcome value ->
            { model | overWelcome = value }

        _ ->
            model

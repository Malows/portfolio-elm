module Types exposing (..)


type alias Service =
    { title : String
    , body : String
    , icon : String
    }


type alias Knowledge =
    { name : String
    , description : String
    , url : String
    }


type alias Portfolio =
    { title : String
    , img : String
    , imgThumbnail : String
    , activity : String
    , description : String
    , url : Maybe String
    }

module Bar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Route exposing (Route (..), toPath, label )

view : Route -> Html msg
view r =
    div [ class "link" ]
    [
        case r of
            Select -> 
                a [ href (toPath Slide) ] [ text (Route.label r) ]
            
            Slide ->
                a [ href (toPath Select) ] [ text (Route.label r) ]
    ]
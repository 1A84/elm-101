module Bar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Route exposing (Route (..), toString )

view : Route -> Html msg
view r =
    div [ class "link" ]
    [
        case r of
            Select -> 
                a [ href (toString Slide) ] [ text "2.0" ]
            
            Slide ->
                a [ href (toString Select) ] [ text "1.0" ]
    ]
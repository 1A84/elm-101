module Pages.Select exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D

import Shared exposing (..)



-- VIEW


view : (Shared.Msg -> msg) -> Model -> Html msg
view toMsg model =
    div [ class "container" ]
        [
        select
            [ on "change" (D.map toMsg (Shared.changeImg valueDecoder)) ]
            -- [ on "change" (Shared.update model <| valueDecoder )]
            [ option [ value "lain" ] [ text "Lain" ]
            , option [ value "audrey_tang" ] [ text "Audrey Tang" ]
            , option [ value "chino-chan" ] [ text "Chino-chan" ]
            , option [ value "none" ] [ text "None" ]
            ]
            , viewImage model
                -- node "picture" [ class "thumbnail" ] [
                --   source [ secret (model.img ++ ".jpg") ] []
                --   , source [] []
                -- ]
        ]

valueDecoder : D.Decoder String
valueDecoder =
    D.field "currentTarget" (D.field "value" D.string)

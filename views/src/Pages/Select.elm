module Pages.Select exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D

import Shared exposing (..)
import Image exposing (..)



-- VIEW


view : (Shared.Msg -> msg) -> Model -> Html msg
view toMsg model =
    div [ class "view" ]
        [
        select
            [ on "change" (D.map toMsg (Shared.changeImg valueDecoder)) ]
            -- [ on "change" (Shared.update model <| valueDecoder )]
            (List.map (\n -> option [ value (Image.toString n) ] [ text (Image.label n) ]) Shared.slide)
            , div [ class "frame" ]
            [ viewImage model ]
        ]


valueDecoder : D.Decoder String
valueDecoder =
    D.field "currentTarget" (D.field "value" D.string)

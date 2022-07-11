module Pages.Select exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D

import Shared exposing (..)



-- UPDATE


-- type Msg = NoOp


-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update _ model =
--     (model, Cmd.none)
-- type Msg = LabelChanged String
-- type Msg = LabelChanged String


-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         LabelChanged img ->
--         --     ( { model | img = img }
--         --     , Cmd.none
--         --     )
--             Shared.update (Shared.Msg img) model



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

-- ex : Model -> String
-- ex model =
--     case model.img of 
--         "lain" ->
--             model.img ++ ".jpg"

--         "audrey_tang" ->
--             model.img ++".jpeg"
        
--         "chino-chan" ->
--             model.img ++ ".jpg"

--         _ ->
--             "null"
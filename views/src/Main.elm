module Main exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D
import Json.Encode as E



-- MAIN


main : Program () Model Msg
main =
  -- Browser.sandbox { init = init, update = update, view = view }
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }



-- MODEL

type alias Model =
  { img : String
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( {img = "lain"}
  , Cmd.none
  )
  


-- UPDATE

type Msg = LabelChanged String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LabelChanged img ->
      ( { model | img = img }
      , Cmd.none
      )


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "container" ]
    [
    select
      [ on "change" (D.map LabelChanged valueDecoder)]
      [ option [ value "lain" ] [ text "Lain" ]
      , option [ value "audrey_tang" ] [ text "Audrey Tang" ]
      , option [ value "chino-chan" ] [ text "Chino-chan" ]
      , option [ value "none" ] [ text "None" ]
      ]
      , div [ class "img_wrapper" ] [
          img [ class "thumbnail", src ("/images/" ++ (ex model) ) ] []
        -- node "picture" [ class "thumbnail" ] [
        --   source [ secret (model.img ++ ".jpg") ] []
        --   , source [] []
        -- ]
      ]
    ]

valueDecoder : D.Decoder String
valueDecoder =
  D.field "currentTarget" (D.field "value" D.string)

ex : Model -> String
ex model =
  case model.img of 
    "lain" ->
      model.img ++ ".jpg"

    "audrey_tang" ->
      model.img ++".jpeg"
    
    "chino-chan" ->
      model.img ++ ".jpg"

    _ ->
      "null"
    
-- coverImage : Model -> Attribute msg
-- coverImage model =
--   let
--     li =
--       [ ("background-image", (model.img ++ ".jpg"))
--       , ("background-size", "cover")
--       ]
--     convey : (String, String) -> String
--     convey t =
--       -- Tuple.mapBoth (String.join ": ") (String.join ";") t
--       Tuple.first t ++ ": " ++ Tuple.second t
--     -- styles : List (String, String) -> Attribute msg
--     -- styles list =
--     --   style <| String.join ";" <| List.map convey list
--   in
--   -- style <| String.join ";" <| List.map Tuple.second <| String.join ": " <| List.map Tuple.first li
--   -- styles li
--   style <| String.join ";" <| List.map convey li
  
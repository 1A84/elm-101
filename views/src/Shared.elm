module Shared exposing ( Model, Msg, init, update, viewImage, changeImg )

import Url exposing ( Url, fromString )
import Url.Parser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D


-- MODEL


type alias Model =
    { img : String
    }


-- INIT


init : () -> ( Model, Cmd Msg)
init _ =
    ( { img = "lain"
    }
    , Cmd.none
    )


-- UPDATE


type Msg = LabelChanged String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        LabelChanged img ->
            ( { model | img = img }
            , Cmd.none
            )

changeImg : D.Decoder String -> D.Decoder Msg
changeImg a =
    D.map LabelChanged a

viewImage : Model -> Html msg
viewImage model =
    div [ class "img_wrapper" ] [
        img [ class "thumbnail", src ("/images/" ++ model.img ) ] []
    ]


-- type Msg = LabelChanged String


-- update : Msg -> Model -> ( Model, Cmd Msg )
--     ( { model | img = img }
--     , Cmd.none
--     )


-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         LabelChanged img ->
--             ( { model | img = img }
--             , Cmd.none
--             )

--         ChangedUrl url ->
--             if url.path /= toString model.route then
--                 ( { model | route = Route.fromUrl url }
--                 , Cmd.none
--                 )
            
--             else
--                 ( { model | route = Route.fromUrl url }, Cmd.none )
      

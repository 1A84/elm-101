module Shared exposing ( Model, Msg, init, update, viewImage, changeImg, left, right, Slide, slide, container )

import Url.Parser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D
import Maybe.Extra as MaybeNg exposing (..)
import List.Extra as List exposing (..)

import Image exposing (..)


-- MODEL


type alias Model =
    { img : Img
    }

type alias Slide = List Img

slide : Slide
slide =
    [ Lain, AudreyTang, ChinoChan, AnyaForger, ShimaRin ]

-- INIT


init : () -> ( Model, Cmd Msg)
init _ =
    ( { img = Lain
    }
    , Cmd.none
    )


-- UPDATE


type Msg
    = LabelChanged Img
    | Left Slide
    | Right Slide


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        LabelChanged img ->
            ( { model | img = img }
            , Cmd.none
            )

        Left s ->
            elemIndex model.img s
                |> MaybeNg.filter (\n -> n > 0)
                |> Maybe.map (\n -> n - 1)
                |> Maybe.map (\n -> getAt n s)
                |> MaybeNg.join
                |> MaybeNg.unwrap ( model, Cmd.none ) (\n -> ( { model | img = n }, Cmd.none))
            -- ( model - 1, Cmd.none )

        Right s ->
            elemIndex model.img s
                |> MaybeNg.filter (\n -> (List.length s) > n)
                |> Maybe.map (\n -> n + 1)
                |> Maybe.map (\n -> getAt n s)
                |> MaybeNg.join
                |> MaybeNg.unwrap ( model, Cmd.none ) (\n -> ( { model | img = n }, Cmd.none ))


changeImg : D.Decoder String -> D.Decoder Msg
changeImg a =
    D.map LabelChanged <| D.map Image.fromString a

left : Slide -> Msg
left l =
    Left l

right : Slide -> Msg
right l =
    Right l

viewImage : Model -> Html msg
viewImage model =
    div [ class "img_wrapper" ] [
        Html.img [ class "thumbnail", src ( Image.img model.img ) ] []
    ]

container : List (Html msg) -> Html msg
container lh =
    div [ class "container" ] ((\n -> n) <| lh)
    -- ]
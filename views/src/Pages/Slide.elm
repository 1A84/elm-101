module Pages.Slide exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing ( tail )
import Maybe exposing ( map )
import Maybe.Extra as MaybeNg exposing (..)
import List.Extra as List exposing (..)

import Image exposing (..)
import Shared exposing ( Model, Msg, Slide )
import Shared exposing (viewImage)
import Json.Decode exposing (maybe)
-- import String exposing (left)


-- INIT

-- slide : List Img
-- slide = [ Lain, AudreyTang, ChinoChan ]

-- type alias Model = Int



-- UPDATE
-- type alias Slide = List Img
-- init : Slide
-- init =
--     [ Lain, AudreyTang, ChinoChan ]


-- type Msg
--     = Left Slide
--     | Right Slide


-- update : Msg -> Model -> ( Model, Cmd msg)
-- update msg model =
--     case msg of
--         Left slide ->
--             -- if index_ == 0 then
--             --     ( model, Cmd.none )

--             -- else
--                 -- ( { model | img = v_ }
--                 -- , Cmd.none
--                 -- )
--             elemIndex model.img slide
--                 |> MaybeNg.filter (\n -> n /= 0)
--                 |> Maybe.map (\n -> n - 1)
--                 |> Maybe.map (\n -> getAt n slide)
--                 |> MaybeNg.join
--                 |> MaybeNg.unwrap ( model, Cmd.none ) (\n -> ( Shared.updateImg, Cmd.none))
--             -- ( model - 1, Cmd.none )

--         Right slide ->
--             -- ( model + 1, Cmd.none )
--             let 
--                 l = last slide
--             in
--             case l of
--                 Just l_ ->
--                     let index = elemIndex l_ slide
--                     in
--                     case index of
--                         Just index_ ->
--                             case (getAt (index_ + 1) slide) of
--                                 Just v ->
--                                     ({ model | img = v}, Cmd.none)
                                
--                                 _ -> (model, Cmd.none)
                        
--                         _ -> (model, Cmd.none)

--                 _ -> (model, Cmd.none)
            -- last slide
            --     |> MaybeNg.filter (\n -> n /= model.img)
            --     |> Maybe.map (\n -> elemIndex n slide)
            --     |> MaybeNg.join
            --     |> Maybe.map (\n -> n + 1)
            --     |> Maybe.map (\n -> getAt n slide)
            --     |> MaybeNg.join
            --     |> MaybeNg.unwrap ( model, Cmd.none ) (\n -> ( { model | img = n }, Cmd.none))
            -- if index_ == 0 then
                

-- left : Model -> ( Model, Cmd msg)
-- left model = 
--     case model.img of
--         "lain" -> model.length


-- VIEW


view : ( Msg -> msg) -> Shared.Model -> Slide -> Html msg
view toMsg model slide =
    div [ class "view" ]
        [ if isHead model slide then
            button [ class "slide_btn left_btn" ] [ text "|" ]

          else
            button [ class "slide_btn left_btn", onClick (toMsg (Shared.left slide) ) ] [ text "<" ]

        , viewImage model

        , if isTail model slide then
            button [ class "slide_btn right_btn" ] [ text "|" ]

          else
            button [ class "slide_btn right_btn", onClick (toMsg (Shared.right slide) ) ] [ text ">" ]

        ]



isHead : Model -> Slide -> Bool
isHead model slide =
    let
        head = getAt 0 slide
    in
    case head of
        Just head_ ->
            if head_ == model.img then
                True

            else
                False
        
        _ ->
            False


isTail : Model -> Slide -> Bool
isTail model slide =
    let
        tail = last slide
    in
    case tail of
        Just tail_ ->
            if model.img == tail_ then
                True

            else
                False
    
        _ ->
            False


left : Int -> Maybe Int
left i =
    if i == 0 then
        Nothing
    
    else Just (i + 1)

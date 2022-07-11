module Pages.Slide exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing ( tail )
import Maybe.Extra as MaybeNg exposing (..)
import List.Extra as List exposing (..)

import Image exposing (..)
import Shared exposing ( Model, Msg, Slide )
import Shared exposing (viewImage)


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

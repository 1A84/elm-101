module Key exposing (
    Direction(..), KeyCap(..)
    , keyDecoder, toKey, fromKeyCode, output, view, keyView )

import Json.Decode as D
import Html exposing (..)
import Html.Attributes exposing (..)
import Debug exposing (toString)
import Html.Events exposing (keyCode)


type Direction
    = U
    | R
    | D
    | L

type KeyCap
    = Character Char
    | Arrow Direction
    | Control String


-- keyDecoder : D.Decoder KeyCap
-- keyDecoder =
--     D.map toKey (D.field "key" D.string)
    -- D.map fromKeyCode (D.field "keyCode" D.int)

keyDecoder : D.Decoder String
keyDecoder =
    D.map (\n -> n) (D.field "key" D.string)


fromKeyCode : Int -> KeyCap
fromKeyCode n =
    case n of
        37 ->
            Arrow L

        39 ->
            Arrow R
        
        _ -> Control ""



toKey : String -> KeyCap
toKey kv =
    case kv of
        "ArrowLeft" ->
            Arrow L

        "ArrowRight" ->
            Arrow R

        "ArrowUp" ->
            Arrow U

        "ArrowDown" ->
            Arrow D

        "Left" ->
            Arrow L

        "Right" ->
            Arrow R

        "Up" ->
            Arrow U

        "Down" ->
            Arrow D
        
        _ ->
            case String.uncons kv of
                Just ( c, "") ->
                    Character c

                _ ->
                    Control kv
            
            -- case kv of
            --     "ArrowLeft" ->
            --         SharedMsg (Shared.left Shared.slide)
                
            --     "ArrowRight" ->
            --         SharedMsg (Shared.right Shared.slide)

            --     _ ->
            --         SharedMsg (Shared.right Shared.slide)


toLabel : Direction -> String
toLabel d =
    case d of
        U -> "Up"
        
        R -> "Right"

        D -> "Down"

        L -> "Left"

output : KeyCap -> String
output k =
    case k of
        Character c ->
            toString c
        
        Arrow d ->
            "Arrow" ++ (toLabel d)
        
        Control s ->
            "Control + " ++ s


view : KeyCap -> Html msg
view k =
    div []
    [ text ( output k) ]

keyView : String -> Html msg
keyView s =
    div []
    [ text s ]
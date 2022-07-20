module Key exposing (
    Direction(..), KeyCap(..)
    , keyDecoder, toKey )

import Json.Decode as D
import Html exposing (..)
import Html.Attributes exposing (..)
import Debug exposing (toString)


type Direction
    = U
    | R
    | D
    | L

type KeyCap
    = Character Char
    | Arrow Direction
    | Control String


keyDecoder : D.Decoder KeyCap
keyDecoder =
    D.map toKey (D.field "key" D.string)


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
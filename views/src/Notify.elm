module Notify exposing ( Stack, N, addNotify, view )

import Html exposing (..)


type alias Stack = ( List N )


type alias N =
    { id : Int
    , msg : String
    }


-- addN : String -> N
-- addN msg =
--     N { msg = s }


addNotify : String -> Stack -> Stack
addNotify str sck =
    List.append [N 0 str] sck


view : Stack -> Html msg
view s =
    if List.isEmpty s then
        text ""

    else
        div [] <| (List.map (\n -> div [] [ text n.msg ]) s)
        -- (\n -> div [] [ text n.msg ] <| s)


-- isEmpty : Stack -> Bool
-- isEmpty s =
--     if List.length s == 0 then
--         True
--     else
--         False
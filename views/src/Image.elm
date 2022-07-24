module Image exposing (Img (..), toString, fromString, label, img, viewLabel)

import Html exposing (..)
import Html.Attributes exposing (..)

-- type alias Img =
--     { label : Label
--     , index : Int
--     }

type Img
    = Lain
    | AudreyTang
    | ChinoChan
    | AnyaForger
    | ShimaRin

-- index : Img -> Int
-- index img =
--     case img of
--         Lain -> 0
--         AudreyTang -> 1
--         ChinoChan -> 2

toString : Img -> String
toString name =
    case name of
        Lain -> "lain"

        AudreyTang -> "audrey_tang"

        ChinoChan -> "chino-chan"

        AnyaForger -> "anya_forger"

        ShimaRin -> "shima_rin"


fromString : String -> Img
fromString str = 
    case str of
        "lain" -> Lain

        "audrey_tang" -> AudreyTang

        "chino-chan" -> ChinoChan

        "anya_forger" -> AnyaForger

        "shima_rin" -> ShimaRin

        _ -> Lain


label : Img -> String
label name =
    case name of
        Lain -> "Lain"

        AudreyTang -> "Audrey Tang"

        ChinoChan -> "Chino chan"

        AnyaForger -> "Anya Forger"

        ShimaRin -> "Shima Rin"


img : Img -> String
img l =
    "/images/" ++ toString l

viewLabel : Img -> Html msg
viewLabel i =
    h2 [ class "img_label" ] [ text (label i) ]
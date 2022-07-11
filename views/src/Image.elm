module Image exposing (Img (..), toString, fromString, label, img)

-- type alias Img =
--     { label : Label
--     , index : Int
--     }

type Img
    = Lain
    | AudreyTang
    | ChinoChan

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


fromString : String -> Img
fromString str = 
    case str of
        "lain" -> Lain

        "audrey_tang" -> AudreyTang

        "chino-chan" -> ChinoChan

        _ -> Lain


label : Img -> String
label name =
    case name of
        Lain -> "Lain"

        AudreyTang -> "Audrey Tang"

        ChinoChan -> "Chino chan"


img : Img -> String
img l =
    "/images/" ++ toString l
module Main exposing (..)

import Browser exposing (..)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Url exposing (..)
import Url.Parser exposing ( oneOf, map )

import Shared exposing (..)
import Route exposing (Route (..), toString, fromUrl)
import Bar exposing (..)
-- import Route exposing ( Route, fromUrl )
import Pages.Select as Select exposing ( view )
import Pages.Slide as Slide exposing ( view )



-- MAIN


main : Program () Model Msg
main =
    -- Browser.sandbox { init = init, update = update, view = view }
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL

type alias Model =
    { route : Route
    , shared : Shared.Model
    , key : Nav.Key
    , slide : Shared.Slide
    }

init : () -> Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key =
    let
        ( shared, sharedCmd ) =
            Shared.init ()

    in
    ({ route = fromUrl url
    , shared = shared
    , key = key
    , slide = Shared.slide
    }
    , Cmd.none
    )
  


-- UPDATE


type Msg
    = UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | SharedMsg Shared.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            if url.path /= Route.toString model.route then
                ( { model | route = fromUrl url }
                , Cmd.none
                )
            
            else
                ( { model | route = fromUrl url }, Cmd.none )

        SharedMsg sMsg ->
            let
                ( shared, sharedCmd ) =
                    Shared.update sMsg model.shared
            in
            ({ model | shared = shared }
            , Cmd.none
            )

        LinkClicked req ->
            case req of
                Browser.Internal url ->
                    -- ( { model | route = fromUrl url }
                    -- , Cmd.none
                    -- )
                    ( model, Nav.pushUrl model.key (Url.toString url))
                Browser.External href ->
                    ( model, Nav.load href)
        
        -- SlideMsg slide ->
        --     let
        --         ( slide_, slideCmd ) =
        --             Slide.update slide model.shared
        --     in
        --     ({ model | shared = slide_ }
        --     , Cmd.none
        --     )

      

-- VIEW

view : Model -> Browser.Document Msg
view model  =
    case model.route of
        Select ->
            -- Select.view model.shared
            -- div [ class "container" ]
            -- [
            { title = "Elm"
            , body = [ container [
                Bar.view model.route
                , Select.view SharedMsg model.shared
                ]
            ]
            }
            -- ]
            -- div [ class "container" ]
            --     [
            --     select
            --         [ on "change" (Shared.changeImg valueDecoder) ]
            --         -- [ on "change" (Shared.update model <| valueDecoder )]
            --         [ option [ value "lain" ] [ text "Lain" ]
            --         , option [ value "audrey_tang" ] [ text "Audrey Tang" ]
            --         , option [ value "chino-chan" ] [ text "Chino-chan" ]
            --         , option [ value "none" ] [ text "None" ]
            --         ]
            --         , viewImage model.shared
            --             -- node "picture" [ class "thumbnail" ] [
            --             --   source [ secret (model.img ++ ".jpg") ] []
            --             --   , source [] []
            --             -- ]
            --     ]

        Slide ->
            -- Select.view SharedMsg model.shared
            { title = "Elm"
            , body = [ container [ Bar.view model.route
            , Slide.view SharedMsg model.shared model.slide] ]
            }
            -- div [ class "container" ]
            --     [ Html.map <| Select.view model.shared ]
    
-- type Route
--     = Select
--     | Slide


-- fromUrl : Url -> Route
-- fromUrl url =
--     case url.path of
--         "/1.0" ->
--             Select

--         "/2.0" ->
--             Slide

--         _ ->
--             Select

-- toString : Route -> String
-- toString r =
--     case r of
--         Select ->
--             "/1.0"

--         Slide ->
--             "/2.0"

-- valueDecoder : D.Decoder String
-- valueDecoder =
--     D.field "currentTarget" (D.field "value" D.string)
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
  
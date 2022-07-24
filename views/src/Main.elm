module Main exposing (..)

import Browser exposing (..)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D

import Url exposing (..)
import Url.Parser exposing ( oneOf, map )

import Shared exposing (..)
import Route exposing (Route (..), fromUrl, toPath, label)
import Bar exposing (..)
import Keyboard exposing (..)
import Notify exposing (..)
-- import Route exposing ( Route, fromUrl )
import Pages.Select as Select exposing ( view )
import Pages.Slide as Slide exposing ( view )
import Browser.Events exposing (onKeyUp)
import Browser.Events exposing (onKeyPress)
import Dict exposing (keys)



-- MAIN


main : Program () Model Msg
main =
    -- Browser.sandbox { init = init, update = update, view = view }
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL

type alias Model =
    { route : Route
    , shared : Shared.Model
    , key : Nav.Key
    , slide : Shared.Slide
    , pressedKeys : List Key
    , notices : Notify.Stack
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
    , pressedKeys = []
    , notices = []
    }
    , Cmd.none
    )
  

-- type Key
--     = ArrowL
--     | ArrowR


subscriptions : Model -> Sub Msg
subscriptions m =
    -- Sub.none
    Sub.batch
        [ Sub.map KeyMsg Keyboard.subscriptions
        ]
    -- onKeyPress (D.succeed)


-- keyEv : Model -> Sub Msg
-- keyEv m =
--     case m.route of
--         Route.Slide ->
--             onKeyPress (D.map KeyPressed keyDecoder)

--         _ -> Sub.none





-- UPDATE


type Msg
    = NoOp
    | UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | SharedMsg Shared.Msg
    | KeyMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp -> (model, Cmd.none)

        UrlChanged url ->
            if url.path /= Route.toPath model.route then
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
        
        KeyMsg km ->
            let
                keys =
                    Keyboard.update km model.pressedKeys

                -- (shared, sharedcmd) =
                mapKey k =
                    if List.member ArrowLeft k then
                        Shared.update ( Shared.left Shared.slide ) model.shared
                    
                    else if List.member ArrowRight k then
                        Shared.update ( Shared.right Shared.slide ) model.shared

                    else (model.shared, Cmd.none)
                        -- ArrowLeft ->
                        --     Shared.update ( Shared.left Shared.slide ) model.shared

                        -- ArrowRight ->
                        --     Shared.update ( Shared.right Shared.slide ) model.shared
                                        
                        -- _ -> (model.shared, Cmd.none)
            in
            ({ model | pressedKeys = keys, shared = (\s -> s |> (\(shared, _) -> shared)) <| (mapKey keys) }, Cmd.none)
            -- ({ model | pressedkeys = keyboard.update km model.pressedkeys }, cmd.none)
            -- case kc of
            --     Arrow L ->
            --         let
            --             ( shared, sharedCmd ) =
            --                 Shared.update ( Shared.left Shared.slide ) model.shared
            --         in
            --         -- ({ model | notices = (List.append [(Notify.N 0 k)] model.notices)}, Cmd.none )
            --         ({ model | shared = shared, notices = (List.append [(Notify.N 0 (Key.output (Arrow L)))] model.notices) }
            --         , Cmd.none
            --         )
                
            --     Arrow R ->
            --         let
            --             ( shared, sharedCmd ) =
            --                 Shared.update ( Shared.right Shared.slide ) model.shared
            --         in
            --         ({ model | shared = shared }
            --         , Cmd.none
            --         )
                
            --     Character 'b' ->
            --         let
            --             ( shared, sharedCmd ) =
            --                 Shared.update ( Shared.left Shared.slide ) model.shared
            --         in
            --         ({ model | shared = shared }
            --         , Cmd.none
            --         )

            --     Character 'n' ->
            --         let
            --             ( shared, sharedCmd ) =
            --                 Shared.update ( Shared.right Shared.slide ) model.shared
            --         in
            --         ({ model | shared = shared }
            --         , Cmd.none
            --         )
                
            --     Control k ->
            --         ({ model | notices = (List.append [(Notify.N 0 k)] model.notices)}, Cmd.none )

            --     Character c ->
            --         ({ model | notices = (List.append [(Notify.N 0 (String.fromChar c) ) ] model.notices)}, Cmd.none )

            --     _ -> (model, Cmd.none)
        
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
        Route.Select ->
            -- Select.view model.shared
            -- div [ class "container" ]
            -- [
            { title = "Elm"
            , body = [
                container [
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
            , body = [
                container [
                    Bar.view model.route
                    , Slide.view SharedMsg model.shared model.slide
                    , Notify.view model.notices
                    , viewKey model.pressedKeys
                ]
            ]
            }
            -- div [ class "container" ]
            --     [ Html.map <| Select.view model.shared ]


viewKey : List Key -> Html msg
viewKey lk =
    div [ class "toasty" ] [
        div [ class "keycap_toast"]
        (List.map (\n -> div [ class "keycap_sym"] [ text (Debug.toString n) ] ) <| lk)
    ]
    


    
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
  
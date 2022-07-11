module Route exposing (Route (..), fromUrl, toPath, label)
import Url exposing (Url)


type Route
    = Select
    | Slide


fromUrl : Url -> Route
fromUrl url =
    case url.path of
        "/1.0" ->
            Select

        "/2.0" ->
            Slide

        _ ->
            Select

toPath : Route -> String
toPath r =
    case r of
        Select ->
            "/1.0"

        Slide ->
            "/2.0"

label : Route -> String
label r =
    case r of
        Select ->
            "Ver 2.0"
        Slide ->
            "Ver 1.0"
module Route exposing (Route (..), fromUrl, toString)
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

toString : Route -> String
toString r =
    case r of
        Select ->
            "/1.0"

        Slide ->
            "/2.0"
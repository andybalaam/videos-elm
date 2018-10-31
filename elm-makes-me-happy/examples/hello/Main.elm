import Browser
import Html
main =
    Browser.sandbox
        { init = 0
        , update = \_ _ -> 0
        , view = \_ -> Html.text "Hello"
        }

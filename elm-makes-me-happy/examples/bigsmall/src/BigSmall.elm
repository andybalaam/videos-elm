module BigSmall exposing (main)


import Browser
import Html exposing (button, text)
import Html.Events exposing (onClick)


main =
  Browser.sandbox
    { init = "foo"
    , update = \_ m -> String.reverse m
    , view = \m -> button [ onClick 0 ] [ text m ]
    }


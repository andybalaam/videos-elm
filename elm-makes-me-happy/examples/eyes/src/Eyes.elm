module Eyes exposing (main)

import Browser
import Browser.Events as Events
import Html exposing (Html)
import Json.Decode as D
import Svg exposing (ellipse, svg)
import Svg.Attributes
    exposing
        ( cx
        , cy
        , fill
        , height
        , rx
        , ry
        , stroke
        , strokeWidth
        , width
        )


type alias Model =
    { x : Float
    , y : Float
    , centreX : Float
    , centreY : Float
    }


type alias Flags =
    ( Float, Float )


type Msg
    = MouseChange Float Float


init : Flags -> ( Model, Cmd Msg )
init ( x, y ) =
    ( { x = x, y = y, centreX = x, centreY = y }, Cmd.none )


view : Model -> Html Msg
view m =
    let
        leftX =
            -28.0

        leftY =
            2.0

        leftXe =
            2 + leftX + 8.0 * ((m.x - m.centreX + leftX) / m.centreX)

        leftYe =
            leftY + 16.0 * ((m.y - m.centreY + leftY) / m.centreY)

        rightX =
            28.0

        rightY =
            0.0

        rightXe =
            -1 + rightX + 6.0 * ((m.x - m.centreX + rightX) / m.centreX)

        rightYe =
            rightY + 24.0 * ((m.y - m.centreY + rightY) / m.centreY)

        s =
            String.fromFloat
    in
    svg
        [ width "200"
        , height "80"
        ]
        [ ellipse
            [ cx (s (100 + leftX))
            , cy (s (40 + leftY))
            , rx "24"
            , ry "32"
            , fill "white"
            , stroke "black"
            , strokeWidth "2px"
            ]
            []
        , ellipse
            [ cx (s (100 + rightX))
            , cy (s (40 + rightY))
            , rx "24"
            , ry "36"
            , fill "white"
            , stroke "black"
            , strokeWidth "2px"
            ]
            []
        , ellipse
            [ cx (s (100 + leftXe))
            , cy (s (40 + leftYe))
            , rx "14"
            , ry "14"
            , fill "black"
            ]
            []
        , ellipse
            [ cx (s (100 + rightXe))
            , cy (s (40 + rightYe))
            , rx "14"
            , ry "14"
            , fill "black"
            ]
            []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update (MouseChange x y) model =
    ( { model
        | x = x
        , y = y
      }
    , Cmd.none
    )


mmDecoder : D.Decoder Msg
mmDecoder =
    D.map2
        (\x y -> MouseChange (toFloat x) (toFloat y))
        (D.field "x" D.int)
        (D.field "y" D.int)


subscriptions : Model -> Sub Msg
subscriptions model =
    Events.onMouseMove mmDecoder


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

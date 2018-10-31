module Eyes exposing (main)


import Browser
import Browser.Events as Events
import Html exposing (Html)
import Json.Decode as D
import Svg exposing (svg, ellipse)
import Svg.Attributes exposing
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
    (Float, Float)


type Msg =
    MouseChange Float Float


init : Flags -> ( Model, Cmd Msg )
init (x, y) =
    ({x=x, y=y, centreX=x, centreY=y}, Cmd.none)


view : Model -> Html Msg
view m =
    let
        leftX = -14.0
        leftY = 1.0
        leftXe = 1 + leftX + 4.0 * ((m.x - m.centreX + leftX) / m.centreX)
        leftYe = leftY + 8.0 * ((m.y - m.centreY + leftY) / m.centreY)

        rightX = 14.0
        rightY = 0.0
        rightXe = -1 + rightX + 3.0 * ((m.x - m.centreX + rightX) / m.centreX)
        rightYe = rightY + 12.0 * ((m.y - m.centreY + rightY) / m.centreY)

        s = String.fromFloat
    in
        svg
            [ width "100"
            , height "40"
            ]
            [ ellipse
                [ cx (s (50+leftX)), cy (s (20+leftY)), rx "12", ry "16"
                , fill "white", stroke "black", strokeWidth "2px"
                ] []
            , ellipse
                [ cx (s (50+rightX)), cy (s (20+rightY)), rx "12", ry "18"
                , fill "white", stroke "black", strokeWidth "2px"
                ] []
            , ellipse
                [ cx (s (50+leftXe)), cy (s (20+leftYe)), rx "7", ry "7"
                , fill "black"
                ] []
            , ellipse
                [ cx (s (50+rightXe)), cy (s (20+rightYe)), rx "7", ry "7"
                , fill "black"
                ] []
            ]


update : Msg -> Model -> ( Model, Cmd Msg )
update (MouseChange x y) model =
    (
        { model
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

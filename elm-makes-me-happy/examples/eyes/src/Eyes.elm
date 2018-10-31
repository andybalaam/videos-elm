module Eyes exposing (main)


import Browser
import Browser.Events as Events
import Html exposing (Html, text)
import Json.Decode as D


type alias Model =
    { x : Int
    , y : Int
    }


makeModel : Int -> Int -> Model
makeModel x y =
    { x = x, y = y }


type alias Flags =
    ()


type Msg =
    MouseChange Model


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { x = 0, y = 0 }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    text
        (  String.fromInt model.x
        ++ String.fromInt model.y
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update (MouseChange newModel) model =
    ( newModel, Cmd.none )
    

mmDecoder : D.Decoder Msg
mmDecoder =
    D.map2
        (\x y -> MouseChange (makeModel x y))
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

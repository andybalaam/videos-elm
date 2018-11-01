module Validation exposing (main)

import Browser
import Html exposing (Attribute, Html, button, div, img, input, text)
import Html.Attributes exposing (disabled, src, style, value)
import Html.Events exposing (onInput)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type IsValid
    = Empty
    | Valid
    | Invalid


type alias Model =
    { email1 : String
    , email2 : String
    }


type Msg
    = Email1Changed String
    | Email2Changed String


init : Model
init =
    { email1 = ""
    , email2 = ""
    }


view : Model -> Html Msg
view model =
    let
        row : String -> String -> IsValid -> (String -> Msg) -> Html Msg
        row caption val valid msg =
            div
                [ style "padding" "0.3em"
                , style "display" "block"
                ]
                [ text caption
                , input
                    [ value val
                    , onInput msg
                    ]
                    []
                , img
                    [ src (tickImage valid)
                    , style "width" "0.8em"
                    , style "height" "0.8em"
                    , style "margin-top" "0.3em"
                    , style "margin-left" "0.2em"
                    ]
                    []
                ]
    in
    div
        []
        [ row
            "Enter email:"
            model.email1
            (validEmail1 model)
            Email1Changed
        , row
            "Email again:"
            model.email2
            (validEmail2 model)
            Email2Changed
        , div
            []
            [ button
                [ submitDisabled model ]
                [ text "Submit" ]
            ]
        ]


validEmail1 : Model -> IsValid
validEmail1 model =
    if model.email1 == "" then
        Empty

    else if String.contains "@" model.email1 then
        Valid

    else
        Invalid


validEmail2 : Model -> IsValid
validEmail2 model =
    if model.email1 == "" then
        Empty

    else if model.email1 == model.email2 then
        Valid

    else
        Invalid


submitDisabled : Model -> Attribute Msg
submitDisabled model =
    disabled ((validEmail1 model /= Valid) || (validEmail2 model /= Valid))


tickImage : IsValid -> String
tickImage isvalid =
    case isvalid of
        Empty ->
            "blank.png"

        Valid ->
            "tick.png"

        Invalid ->
            "cross.png"


update : Msg -> Model -> Model
update msg model =
    case msg of
        Email1Changed s ->
            { model | email1 = s }

        Email2Changed s ->
            { model | email2 = s }

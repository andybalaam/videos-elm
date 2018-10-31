module Validation where

import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Html.Events exposing ( .. )
import StartApp.Simple as StartApp
import String exposing ( contains )

main =
    StartApp.start
    { model = model , view = view , update = update }


type IsValid = Empty | Valid | Invalid

type alias Model =
    { email1 : String
    , email2 : String
    }

model : Model
model =
    { email1 = ""
    , email2 = ""
    }

view address model =
    div
        []
        [ row address "Enter email:" model.email1 ( validEmail model.email1 ) Email1Changed
        , row address "Email again:" model.email2 ( if model.email2 == "" then Empty else if model.email1 == model.email2 then Valid else Invalid ) Email2Changed
        , div [] [ button [ disabled ( not ( submitEnabled model ) ) ] [ text "Submit" ] ]
        ]

row address caption val valid action =
    div
        [ style [ ( "padding",  "0.3em" ), ( "display", "block" ) ] ]
        [ text caption
        , input [ value ( Debug.watch "me1" val ), on "input" targetValue (\str -> Signal.message address (action str) ) ] []
        , img [ src ( tickImage valid ), style [ ( "width", "0.8em" ), ( "height", "0.8em" ), ( "margin-top", "0.3em" ), ( "margin-left", "0.2em" ) ] ] []
        ]


contentToValue str = Email1Changed ( Debug.watch "str" str )

enabledAttr enabled =
    if Debug.watch "enabled" enabled then [] else [ disabled True ]

submitEnabled model =
    validEmail model.email1 == Valid && model.email1 == model.email2

validEmail : String -> IsValid
validEmail string =
    if string == "" then Empty else if contains "@" string then Valid else Invalid

tickImage : IsValid -> String
tickImage isvalid =
    case isvalid of
        Empty -> "blank.png"
        Valid -> "tick.png"
        Invalid -> "cross.png"


type Action = Email1Changed String | Email2Changed String

update : Action -> Model -> Model
update action model =
    case action of
        Email1Changed s -> { model | email1 = s }
        Email2Changed s -> { model | email2 = s }



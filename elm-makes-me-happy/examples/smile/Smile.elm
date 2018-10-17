module Smile where

import List exposing ( map )
import Color exposing ( red, black )
import Graphics.Collage exposing ( .. )
import Graphics.Element exposing ( Element, show )
import Mouse
import Window


main : Signal Element
main =
    Signal.map2 scene Mouse.position Window.dimensions

scene : ( Int, Int ) -> ( Int, Int ) -> Element
scene ( x, y ) ( w, h ) =
    let
        xd = toFloat x - ( ( toFloat w ) / 2 )
        yd = toFloat y - ( ( toFloat h ) / 2 )
        smileyness = clamp -1 1 ( 1 - ( 2 * ( sqrt ( xd^2 + yd^2 ) / ( 0.5 * toFloat ( max w h ) ) ) ) )
    in
       face 20 smileyness
       --show ( sqrt ( xd^2 + yd^2 ) / ( 0.5 * toFloat ( max w h ) ) )


face : Float -> Float -> Element
face radius smileyness =
    collage
        200
        200
        [ traced
            { defaultLine
                | width = 5
                , color = red
                , join = Smooth
            }
            ( path ( map ( point radius smileyness ) [0..20] ) )
        , move ( -17, 30 ) ( filled black ( circle 8 ) )
        , move (  17, 30 ) ( filled black ( circle 8 ) )
        ]


point radius smileyness i =
    let theta = angle i in
        ( radius * cos theta
        , smileyness * radius * sin theta
        )


angle i =
    -pi * i / 20


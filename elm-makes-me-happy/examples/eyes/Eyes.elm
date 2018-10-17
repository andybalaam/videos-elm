module Eyes where

import Color exposing ( .. )
import Graphics.Element exposing ( Element )
import Graphics.Collage exposing ( .. )
import Mouse

main = Signal.map scene Mouse.position

scene ( x, y ) = collage 400 100
    [ outlined defaultLine ( circle 20 )
    , move
        ( eyePos 0.05 x -200, -1 * eyePos 0.15 y -50 )
        ( filled black ( circle 10 ) ) ]

eyePos scale x off = scale * ( off + toFloat x )


module Lib.Coordinate.Coordinates exposing
    ( fixedPosToReal
    , posToReal
    , widthToReal
    , heightToReal
    , maxHandW
    , getStartPoint
    , judgeMouse
    , fromMouseToReal
    )

{-|


# Coordinate

This module deals with the coordinate transformation.

This module is very important because it can calculate the correct position of the point you want to draw.

@docs fixedPosToReal
@docs posToReal
@docs widthToReal
@docs heightToReal
@docs maxHandW
@docs getStartPoint
@docs judgeMouse
@docs fromMouseToReal

-}

import Base exposing (GlobalData)
import MainConfig exposing (plHeight, plWidth)



{- The scale is by default 16:9 -}


plScale : Float
plScale =
    toFloat plWidth / toFloat plHeight



--- Transform Coordinates


floatpairadd : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
floatpairadd ( x, y ) ( z, w ) =
    ( x + z, y + w )


{-| fixedPosToReal

Same as posToReal, but add the initial position of canvas.

-}
fixedPosToReal : GlobalData -> ( Int, Int ) -> ( Float, Float )
fixedPosToReal gd ( x, y ) =
    floatpairadd (posToReal gd ( x, y )) ( gd.startLeft, gd.startTop )


{-| posToReal

Transform from the virtual coordinate system to the real pixel system.

-}
posToReal : GlobalData -> ( Int, Int ) -> ( Float, Float )
posToReal gd ( x, y ) =
    let
        realWidth =
            gd.realWidth

        realHeight =
            gd.realHeight
    in
    ( toFloat realWidth * (toFloat x / toFloat plWidth), toFloat realHeight * (toFloat y / toFloat plHeight) )


{-| widthToReal
Use this if you want to draw something based on the length.
-}
widthToReal : GlobalData -> Int -> Float
widthToReal gd x =
    let
        realWidth =
            gd.realWidth
    in
    toFloat realWidth * (toFloat x / toFloat plWidth)


{-| heightToReal
Theoretically this function is identical to widthToReal, but if possible you can use this to draw something based on the height (like rectangle).
-}
heightToReal : GlobalData -> Int -> Float
heightToReal gd x =
    let
        realHeight =
            gd.realHeight
    in
    toFloat realHeight * (toFloat x / toFloat plHeight)


{-| maxHandW
-}
maxHandW : ( Int, Int ) -> ( Int, Int )
maxHandW ( w, h ) =
    if toFloat w / toFloat h > plScale then
        ( floor (toFloat h * plScale), h )

    else
        ( w, floor (toFloat w / plScale) )


{-| getStartPoint
-}
getStartPoint : ( Int, Int ) -> ( Float, Float )
getStartPoint ( w, h ) =
    let
        fw =
            toFloat h * plScale

        fh =
            toFloat w / plScale
    in
    if toFloat w / toFloat h > plScale then
        ( (toFloat w - fw) / 2, 0 )

    else
        ( 0, (toFloat h - fh) / 2 )


{-| judgeMouse
Judge whether the mouse position is in the rectangle.
-}
judgeMouse : GlobalData -> ( Float, Float ) -> ( Int, Int ) -> ( Int, Int ) -> Bool
judgeMouse gd ( mx, my ) ( x, y ) ( w, h ) =
    let
        ( rpx, rpy ) =
            posToReal gd ( x, y )

        rw =
            widthToReal gd w

        rh =
            heightToReal gd h

        mpx =
            mx - gd.startLeft

        mpy =
            my - gd.startTop
    in
    if rpx <= mpx && mpx <= rpx + rw && rpy <= mpy && mpy <= rpy + rh then
        True

    else
        False


{-| fromMouseToReal
-}
fromMouseToReal : GlobalData -> ( Float, Float ) -> ( Float, Float )
fromMouseToReal gd ( px, py ) =
    ( px - gd.startLeft, py - gd.startTop )

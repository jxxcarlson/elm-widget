module Widget.Bar exposing
    ( make, toElement
    , horizontal, vertical
    , withSize, withThickness
    , withRGB, withRGBHex
    )

{-|


## Construct and render

@docs make, toElement


## Orientation

@docs horizontal, vertical


## Dimensions

@docs withSize, withThickness


## Color

@docs withRGB, withRGBHex

-}

import Element exposing (Element)
import Svg exposing (Svg)
import Svg.Attributes as SA


type Bar
    = Bar Options Float


type alias Options =
    { thickness : Float
    , size : Float
    , orientation : Orientation
    , color : Color
    }


type Color
    = HEX String
    | RGB Float Float Float


type Orientation
    = Vertical
    | Horizontal


{-| -}
make : Float -> Bar
make fraction =
    Bar defaultOptions fraction


{-| -}
withThickness : Float -> Bar -> Bar
withThickness t (Bar options fraction) =
    Bar { options | thickness = t } fraction


{-| -}
withSize : Float -> Bar -> Bar
withSize s (Bar options fraction) =
    Bar { options | size = s } fraction


{-| -}
withRGBHex : String -> Bar -> Bar
withRGBHex hex (Bar options fraction) =
    Bar { options | color = HEX hex } fraction


{-| -}
withRGB : Float -> Float -> Float -> Bar -> Bar
withRGB r g b (Bar options fraction) =
    Bar { options | color = RGB r g b } fraction


{-| -}
horizontal : Bar -> Bar
horizontal (Bar options fraction) =
    Bar { options | orientation = Horizontal } fraction


{-| -}
vertical : Bar -> Bar
vertical (Bar options fraction) =
    Bar { options | orientation = Vertical } fraction


defaultOptions =
    { thickness = 10
    , size = 180
    , orientation = Horizontal
    , color = HEX "#000"
    }


str255 : Float -> String
str255 u =
    round (256 * u)
        |> modBy 256
        |> String.fromInt


strOfRGB : Float -> Float -> Float -> String
strOfRGB r g b =
    "rgb(" ++ str255 r ++ "," ++ str255 g ++ "," ++ str255 b ++ ")"


{-| -}
toElement : Bar -> Element msg
toElement (Bar options fraction) =
    let
        color =
            case options.color of
                HEX hex ->
                    hex

                RGB r g b ->
                    strOfRGB r g b
    in
    case options.orientation of
        Horizontal ->
            Svg.svg
                [ SA.transform "scale(1,1)"
                , SA.transform "translate(25, 0)"
                , SA.height <| String.fromFloat options.thickness
                , SA.width <| String.fromFloat options.size
                ]
                [ hBar color options.thickness options.size fraction ]
                |> Element.html

        Vertical ->
            Svg.svg
                [ SA.transform "scale(1,1)"
                , SA.transform "translate(25, 0)"
                , SA.height <| String.fromFloat options.size
                , SA.width <| String.fromFloat options.thickness
                ]
                [ vBar color options.thickness options.size fraction ]
                |> Element.html


hBar : String -> Float -> Float -> Float -> Svg msg
hBar color thickness size fraction =
    Svg.rect
        [ SA.height <| String.fromFloat thickness
        , SA.width <| String.fromFloat <| fraction * size
        , SA.x <| "0"
        , SA.fill color
        ]
        []


vBar : String -> Float -> Float -> Float -> Svg msg
vBar color thickness size fraction =
    Svg.rect
        [ SA.width <| String.fromFloat thickness
        , SA.height <| String.fromFloat <| fraction * size
        , SA.x <| "0"
        , SA.fill color
        ]
        []

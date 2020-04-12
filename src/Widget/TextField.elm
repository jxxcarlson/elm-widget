module Widget.TextField exposing
    ( Role(..), Size(..), LabelPosition(..)
    , make, toElement
    , withHeight, withLabelWidth, withWidth, withLabelPosition
    )

{-|


## Types

@docs Role, Size, LabelPosition


## Construct, render

@docs make, toElement


## Options

@docs withHeight, withLabelWidth, withWidth, withLabelPosition

-}

import Element exposing (..)
import Element.Font as Font
import Element.Input as Input
import Widget.Color as Style exposing (..)


type TextField msg
    = TextField Options (String -> msg) String String


type alias Options =
    { role : Role
    , backgroundColor : Color
    , fontColor : Color
    , width : Int
    , height : Int
    , labelWidth : Size
    , labelPosition : LabelPosition
    }


{-| -}
type LabelPosition
    = LabelLeft
    | LabelAbove
    | LabelRight
    | NoLabel


{-| -}
type Role
    = Primary
    | Secondary


{-| -}
type Size
    = Bounded Int
    | Unbounded


{-| -}
make : (String -> msg) -> String -> String -> TextField msg
make msg text label =
    TextField defaultOptions msg text label


{-| -}
toElement : TextField msg -> Element msg
toElement (TextField options msg text labelText) =
    let
        baseLabelOptions =
            [ moveDown 8 ]

        labelOptions =
            case options.labelWidth of
                Unbounded ->
                    baseLabelOptions

                Bounded k ->
                    width (px k) :: baseLabelOptions
    in
    Input.text [ moveUp 3, width (px options.width), height (px options.height), Font.size 14 ]
        { onChange = msg
        , text = text
        , placeholder = Nothing
        , label = label_ options.labelPosition labelOptions labelText -- Input.labelLeft labelOptions (Element.text label)
        }


label_ labelPosition labelOptions labelText =
    case labelPosition of
        LabelLeft ->
            Input.labelLeft labelOptions (Element.text labelText)

        LabelAbove ->
            Input.labelAbove labelOptions (Element.text labelText)

        LabelRight ->
            Input.labelRight labelOptions (Element.text labelText)

        NoLabel ->
            Input.labelLeft [] (Element.text "")


defaultOptions =
    { role = Primary
    , backgroundColor = Style.darkGray
    , fontColor = Style.white
    , width = 100
    , height = 40
    , labelWidth = Unbounded
    , labelPosition = LabelLeft
    }


{-| -}
withLabelPosition : LabelPosition -> TextField msg -> TextField msg
withLabelPosition labelPosition (TextField options msg text label) =
    TextField { options | labelPosition = labelPosition } msg text label


{-| -}
withWidth : Int -> TextField msg -> TextField msg
withWidth width (TextField options msg text label) =
    TextField { options | width = width } msg text label


{-| -}
withHeight : Int -> TextField msg -> TextField msg
withHeight height (TextField options msg text label) =
    TextField { options | height = height } msg text label


{-| -}
withLabelWidth : Int -> TextField msg -> TextField msg
withLabelWidth labelWidth (TextField options msg text label) =
    TextField { options | labelWidth = Bounded labelWidth } msg text label

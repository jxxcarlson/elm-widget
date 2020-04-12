module Widget.TextField exposing
    ( Options
    , TextField(..)
    , defaultOptions
    , make
    , toElement
    , withHeight
    , withLabelWidth
    , withWidth
    )

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Widget.Style as Style exposing (..)


type TextField msg
    = TextField Options (String -> msg) String String


make : (String -> msg) -> String -> String -> TextField msg
make msg text label =
    TextField defaultOptions msg text label


toElement : TextField msg -> Element msg
toElement (TextField options msg text label) =
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
        , label = Input.labelLeft labelOptions (Element.text label)
        }


type alias Options =
    { role : Role
    , backgroundColor : Color
    , fontColor : Color
    , width : Int
    , height : Int
    , labelWidth : Size
    }


type Role
    = Primary
    | Secondary


type Size
    = Bounded Int
    | Unbounded


defaultOptions =
    { role = Primary
    , backgroundColor = Style.darkGray
    , fontColor = Style.white
    , width = 100
    , height = 40
    , labelWidth = Unbounded
    }


withWidth : Int -> TextField msg -> TextField msg
withWidth width (TextField options msg text label) =
    TextField { options | width = width } msg text label


withHeight : Int -> TextField msg -> TextField msg
withHeight height (TextField options msg text label) =
    TextField { options | height = height } msg text label


withLabelWidth : Int -> TextField msg -> TextField msg
withLabelWidth labelWidth (TextField options msg text label) =
    TextField { options | labelWidth = Bounded labelWidth } msg text label

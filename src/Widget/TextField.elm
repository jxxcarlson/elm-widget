module Widget.TextField exposing
    ( Role(..), Size(..), LabelPosition(..)
    , make, toElement
    , withHeight, withId, withLabelWidth, withWidth, withLabelPosition, withFontColor, withBackgroundColor, withRole, withTitle
    )

{-|


## Types

@docs Role, Size, LabelPosition


## Construct, render

@docs make, toElement


## Options

@docs withId, withHeight, withLabelWidth, withWidth, withLabelPosition, withFontColor, withBackgroundColor, withRole, withTitle

-}

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Widget.Color as Color exposing (..)


type TextField msg
    = TextField Options (String -> msg) String String


type alias Options =
    { role : Role
    , backgroundColor : Color
    , fontColor : Color
    , id : String
    , width : Int
    , height : Int
    , labelWidth : Size
    , labelPosition : LabelPosition
    , title : String
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
    | Password


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

        title =
            options.title
    in
    case options.role of
        Password ->
            Input.currentPassword
                [ moveUp 3
                , Background.color options.backgroundColor
                , Font.color options.fontColor
                , width (px options.width)
                , elementAttribute "id" options.id
                , height (px options.height)
                , Font.size 14
                ]
                { onChange = msg
                , text = text
                , placeholder = Nothing
                , label = label_ options.labelPosition labelOptions labelText title
                , show = False
                }

        _ ->
            Input.text
                [ Background.color options.backgroundColor
                , Font.color options.fontColor
                , moveUp 3
                , width (px options.width)
                , elementAttribute "id" options.id
                , height (px options.height)
                , Font.size 14
                , elementAttribute "autocapitalize" "off"
                ]
                { onChange = msg
                , text = text
                , placeholder = Nothing
                , label = label_ options.labelPosition labelOptions labelText title
                }


label_ labelPosition labelOptions labelText title =
    let
        titleAttr =
            Element.htmlAttribute (Html.Attributes.attribute "title" title)

        cursorAttr =
            Element.htmlAttribute (Html.Attributes.attribute "cursor" "default")
    in
    case labelPosition of
        LabelLeft ->
            Input.labelLeft labelOptions (Element.text labelText)

        LabelAbove ->
            Input.labelAbove labelOptions (Element.el [ moveUp 8, titleAttr, cursorAttr ] (Element.text labelText))

        LabelRight ->
            Input.labelRight labelOptions (Element.text labelText)

        NoLabel ->
            Input.labelLeft [] (Element.text "")


defaultOptions =
    { role = Primary
    , backgroundColor = Color.white
    , fontColor = Color.black
    , id = ""
    , width = 100
    , height = 40
    , labelWidth = Unbounded
    , labelPosition = LabelLeft
    , title = ""
    }


{-| -}
withFontColor : Color -> TextField msg -> TextField msg
withFontColor color (TextField options msg text label) =
    TextField { options | fontColor = color } msg text label

{-| -}
withId : String -> TextField msg -> TextField msg
withId id (TextField options msg text label) =
    TextField { options | id = id } msg text label

{-| -}
withBackgroundColor : Color -> TextField msg -> TextField msg
withBackgroundColor color (TextField options msg text label) =
    TextField { options | backgroundColor = color } msg text label


{-| -}
withRole : Role -> TextField msg -> TextField msg
withRole role (TextField options msg text label) =
    TextField { options | role = role } msg text label


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


{-| -}
withTitle : String -> TextField msg -> TextField msg
withTitle title (TextField options msg text label) =
    TextField { options | title = title } msg text label



-- HELPERS


elementAttribute : String -> String -> Attribute msg
elementAttribute key value =
    Element.htmlAttribute (Html.Attributes.attribute key value)


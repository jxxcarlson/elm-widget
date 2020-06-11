module Widget.Button exposing
    ( Alignment(..), Role(..), Size(..), ButtonStyle(..)
    , make, toElement
    , withAlignment, withBackgroundColor, withFontColor, withHeight, withRole, withSelected, withSelectedBackgroundColor, withSelectedFontColor, withStyle, withTitle, withWidth
    )

{-|


## Types

@docs Alignment, Role, Size, ButtonStyle


## Construct and render

@docs make, toElement


## Options

@docs withAlignment, withBackgroundColor, withFontColor, withHeight, withRole, withSelected, withSelectedBackgroundColor, withSelectedFontColor, withStyle, withTitle, withWidth

-}

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Widget.Color as Style exposing (..)


type Button msg
    = Button Options msg String


{-| -}
make : msg -> String -> Button msg
make msg label =
    Button defaultOptions msg label


type alias Options =
    { role : Role
    , variant : ButtonStyle
    , selected : Bool
    , backgroundColor : Color
    , fontColor : Color
    , selectedBackgroundColor : Color
    , selectedFontColor : Color
    , borderColor : Color
    , width : Size
    , height : Size
    , alignment : Alignment
    , title : String
    }


{-| -}
type Role
    = Primary
    | Outline


{-| -}
type ButtonStyle
    = Square
    | Rounded


{-| -}
type Alignment
    = Left
    | Center


{-| -}
type Size
    = Bounded Int
    | Unbounded


defaultOptions =
    { role = Primary
    , variant = Square
    , selected = False
    , backgroundColor = Style.darkGray
    , fontColor = Style.white
    , selectedBackgroundColor = Style.darkRed
    , selectedFontColor = Style.white
    , borderColor = Style.white
    , width = Unbounded
    , height = Bounded 30
    , alignment = Center
    , title = ""
    }


{-| -}
toElement : Button msg -> Element msg
toElement (Button options msg label) =
    if options.selected then
        button_ (buttobuttonStyleDispatcher options.role) options msg label

    else
        button_ (buttobuttonStyleDispatcher options.role) options msg label


{-| -}
withRole : Role -> Button msg -> Button msg
withRole role (Button options msg label) =
    Button { options | role = role } msg label


{-| -}
withStyle : ButtonStyle -> Button msg -> Button msg
withStyle variant (Button options msg label) =
    Button { options | variant = variant } msg label


{-| -}
withTitle : String -> Button msg -> Button msg
withTitle title (Button options msg label) =
    Button { options | title = title } msg label


{-| -}
withAlignment : Alignment -> Button msg -> Button msg
withAlignment alignment (Button options msg label) =
    Button { options | alignment = alignment } msg label


{-| -}
withWidth : Size -> Button msg -> Button msg
withWidth size (Button options msg label) =
    Button { options | width = size } msg label


{-| -}
withHeight : Size -> Button msg -> Button msg
withHeight size (Button options msg label) =
    Button { options | height = size } msg label


{-| -}
withSelected : Bool -> Button msg -> Button msg
withSelected flag (Button options msg label) =
    Button { options | selected = flag } msg label


{-| -}
withBackgroundColor : Color -> Button msg -> Button msg
withBackgroundColor color (Button options msg label) =
    Button { options | backgroundColor = color } msg label


{-| -}
withFontColor : Color -> Button msg -> Button msg
withFontColor color (Button options msg label) =
    Button { options | fontColor = color } msg label


{-| -}
withSelectedBackgroundColor : Color -> Button msg -> Button msg
withSelectedBackgroundColor color (Button options msg label) =
    Button { options | selectedBackgroundColor = color } msg label


{-| -}
withSelectedFontColor : Color -> Button msg -> Button msg
withSelectedFontColor color (Button options msg label) =
    Button { options | selectedFontColor = color } msg label


type alias InnerButton msg =
    ButtonStyleFunction msg -> Options -> msg -> String -> Element msg


button_ : InnerButton msg
button_ buttonStyleFunction options msg_ label =
    row (buttonStyleFunction options)
        [ Input.button
            [ paddingXY 8 4
            , buttonAlignment options.alignment
            ]
            { onPress = Just msg_
            , label = el [ centerX, centerY ] (text label)
            }
        ]


buttobuttonStyleDispatcher : Role -> ButtonStyleFunction msg
buttobuttonStyleDispatcher role =
    case role of
        Primary ->
            primaryButtonStyle

        Outline ->
            outlineButtonStyle


prependWidth : Size -> List (Attribute msg) -> List (Attribute msg)
prependWidth size list =
    case size of
        Unbounded ->
            list

        Bounded w ->
            (width <| px w) :: list


prependHeight : Size -> List (Attribute msg) -> List (Attribute msg)
prependHeight size list =
    case size of
        Unbounded ->
            list

        Bounded h ->
            (height <| px h) :: list


type alias ButtonStyleFunction msg =
    Options -> List (Attribute msg)


variantStyle : ButtonStyle -> Color -> List (Attribute msg)
variantStyle variant color =
    case variant of
        Square ->
            []

        Rounded ->
            [ Border.rounded 8
            , Border.color color
            ]


buttonAlignment : Alignment -> Attribute msg
buttonAlignment alignment =
    case alignment of
        Left ->
            alignLeft

        Center ->
            centerX


buttonBackgroundColor : Options -> Color
buttonBackgroundColor options =
    case options.selected of
        True ->
            options.selectedBackgroundColor

        False ->
            options.backgroundColor


buttonFontColor : Options -> Color
buttonFontColor options =
    case options.selected of
        True ->
            options.selectedFontColor

        False ->
            options.fontColor


primaryButtonStyle : ButtonStyleFunction msg
primaryButtonStyle options =
    [ paddingXY 0 2
    , Background.color (buttonBackgroundColor options)
    , Font.color (buttonFontColor options)
    , Font.size 14
    , Element.htmlAttribute (Html.Attributes.attribute "title" options.title)
    , mouseDown
        [ Background.color (rgb255 40 40 200)
        ]
    ]
        ++ variantStyle options.variant options.fontColor
        |> prependWidth options.width
        |> prependHeight options.height


outlineButtonStyle : ButtonStyleFunction msg
outlineButtonStyle options =
    [ paddingXY 0 2
    , Background.color (buttonBackgroundColor options)
    , Font.color (buttonFontColor options)
    , Font.size 14
    , Element.htmlAttribute (Html.Attributes.attribute "title" options.title)
    , Border.solid
    , Border.color (Element.rgb255 255 0 0)
    , Border.width 2
    , mouseDown [ Background.color (rgb255 40 40 200) ]
    ]
        ++ variantStyle options.variant options.fontColor
        |> prependWidth options.width
        |> prependHeight options.height

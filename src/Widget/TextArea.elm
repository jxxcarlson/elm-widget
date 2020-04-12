module Widget.TextArea exposing
    ( Options, Role(..), Size(..), TextArea(..)
    , input, toElement, withHeight, withWidth
    )

{-|


## Types

@docs Options, Role, Size, TextArea


## Construct, render, set options

@docs input, toElement, withHeight, withWidth

-}

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Widget.Style as Style exposing (..)


{-| -}
type TextArea msg
    = TextArea Options (String -> msg) String String


{-| -}
input : (String -> msg) -> String -> String -> TextArea msg
input msg text label =
    TextArea defaultOptions msg text label


{-| -}
toElement : TextArea msg -> Element msg
toElement (TextArea options msg text label) =
    Input.multiline [ width (px options.width), height (px options.height), Font.size 14 ]
        { onChange = msg
        , text = text
        , placeholder = Nothing
        , label = Input.labelAbove [] (Element.text label)
        , spellcheck = False
        }


{-| -}
type alias Options =
    { role : Role
    , selected : Bool
    , backgroundColor : Color
    , fontColor : Color
    , selectedBackgroundColor : Color
    , selectedFontColor : Color
    , width : Int
    , height : Int
    }


{-| -}
type Role
    = Primary
    | Secondary


{-| -}
type Size
    = Bounded Int
    | Unbounded


defaultOptions =
    { role = Primary
    , selected = False
    , backgroundColor = Style.darkGray
    , fontColor = Style.white
    , selectedBackgroundColor = Style.darkRed
    , selectedFontColor = Style.white
    , width = 100
    , height = 40
    }


{-| -}
withWidth : Int -> TextArea msg -> TextArea msg
withWidth width (TextArea options msg text label) =
    TextArea { options | width = width } msg text label


{-| -}
withHeight : Int -> TextArea msg -> TextArea msg
withHeight height (TextArea options msg text label) =
    TextArea { options | height = height } msg text label

module Example1 exposing (main)

{- This is a starter app which presents a text label, text field, and a button.
   What you enter in the text field is echoed in the label.  When you press the
   button, the text in the label is reverse.
   This version uses `mdgriffith/elm-ui` for the view functions.
-}

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
import Widget.Button as Button exposing (ButtonStyle(..), Role(..), Size(..))
import Widget.Style
import Widget.TextField as TextField exposing (LabelPosition(..))


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { input : String
    , output : String
    }


type Msg
    = NoOp
    | InputText String
    | ReverseText


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { input = "a stitch in time saves nine"
      , output = "a stitch in time saves nine"
      }
    , Cmd.none
    )


subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        InputText str ->
            ( { model | input = str, output = str }, Cmd.none )

        ReverseText ->
            ( { model | output = model.output |> String.reverse |> String.toLower }, Cmd.none )



--
-- VIEW
--


view : Model -> Html Msg
view model =
    Element.layoutWith { options = [ focusStyle Widget.Style.noFocus ] }
        [ Background.color <| Element.rgb 0.2 0.2 0.2 ]
        (mainColumn model)


widgetWidth =
    200


mainColumn : Model -> Element Msg
mainColumn model =
    column mainColumnStyle
        [ column [ spacing 20 ]
            [ title "Example 1"
            , row [ centerX ] [ inputText model ]
            , row [ centerX ] [ appButton ]
            , outputDisplay model
            ]
        ]


title : String -> Element msg
title str =
    row [ centerX, Font.bold ] [ text str ]


outputDisplay : Model -> Element msg
outputDisplay model =
    row [ Font.size 16, centerX, width (px widgetWidth) ]
        [ text model.output ]


inputText : Model -> Element Msg
inputText model =
    TextField.make InputText model.input ""
        |> TextField.withHeight 30
        |> TextField.withWidth widgetWidth
        |> TextField.withLabelWidth 0
        |> TextField.withLabelPosition NoLabel
        |> TextField.toElement


appButton : Element Msg
appButton =
    Button.make ReverseText "Reverse"
        |> Button.withWidth (Bounded widgetWidth)
        |> Button.withSelected False
        |> Button.withStyle Rounded
        |> Button.toElement



--
-- STYLE
--


mainColumnStyle =
    [ centerX
    , centerY
    , Background.color (rgb 0.9 0.9 0.9)
    , padding 40
    ]

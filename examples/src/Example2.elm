module Example2 exposing (main)

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
import List.Extra
import Maybe.Extra
import Widget.Bar
import Widget.Style
import Widget.TextArea as TextArea


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { data : String
    }


type Msg
    = NoOp
    | GotText String


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { data = "1, 2, 4, 8, 6, 5"
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

        GotText str ->
            ( { model | data = str }, Cmd.none )



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


windowHeight =
    400


mainColumn : Model -> Element Msg
mainColumn model =
    column mainColumnStyle
        [ column [ spacing 20 ]
            [ title "Example 2: Data"
            , row [ spacing 20 ]
                [ textInput model
                , column [ spacing 2, alignTop, scrollbarY, height (px 400), width (px 300) ]
                    (el [ Font.size 14, paddingEach { paddingData | bottom = 4 } ] (text "Graph") :: (viewData <| parseData model.data))
                ]
            ]
        ]


paddingData =
    { left = 0, right = 0, bottom = 0, top = 0 }


parseData : String -> List Float
parseData str =
    str
        |> String.split ","
        |> List.map (String.trim >> String.toFloat)
        |> Maybe.Extra.values


title : String -> Element msg
title str =
    row [ centerX, Font.size 16 ] [ text str ]


mainColumnStyle =
    [ centerX
    , centerY
    , Background.color (rgb 0.9 0.9 0.9)
    , padding 40
    ]


textInput model =
    TextArea.input GotText model.data "Enter data separated by commas"
        |> TextArea.withWidth 300
        |> TextArea.withHeight windowHeight
        |> TextArea.toElement


viewData : List Float -> List (Element msg)
viewData data =
    let
        viewDatum : ( Int, Float ) -> Element msg
        viewDatum ( k, x ) =
            row [ spacing 10 ]
                [ el [ Font.size 14 ] (text <| String.fromInt k)
                , myBar (List.Extra.maximumBy identity data |> Maybe.withDefault 1000) x
                ]
    in
    List.map viewDatum (dataItems data)


myBar maxValue value =
    Widget.Bar.make (value / maxValue)
        |> Widget.Bar.withRGBHex "#A00"
        |> Widget.Bar.toElement


dataItems : List Float -> List ( Int, Float )
dataItems data =
    List.indexedMap (\k x -> ( k, x )) data

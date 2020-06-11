# Widget

This package is a collection of configurable UI widgets 
for use with mdgriffith/elm-ui: buttons, 
text fields, bars, etc.  The API is based on 
[Brian Hick's Robot Buttons from Mars](https://www.youtube.com/watch?v=PDyWP-0H4Zo).
Below are examples of how to use each element.  See 
also the `examples` folder.

## Button

```elm
appButton =
    Widget.Button.make ReverseText "Reverse"
        |> Button.withWidth (Bounded 100)
        |> Button.withSelected False
        |> Button.withTitle "Press to reverse text"
        |> Button.toElement
```

The point is that you can use as many or as few "withXXX" functions as you please.

## Bar 

Display a bar `maxValue` pixels wide where the indicator
takes up the fraction `value / maxValue` of the total width.

```elm
myBar maxValue value =
    Widget.Bar.make (value / maxValue)
        |> Widget.Bar.withRGBHex "#A00"
        |> Widget.Bar.toElement
```

## Text field

```elm
dashboardInput msg text label =
    Widget.TextField.make msg text label
        |> TextField.withHeight 30
        |> TextField.withWidth 50
        |> TextField.withLabelWidth 70
        |> TextField.toElement

rateInput model = 
    dashboardInput AcceptTickRate model.tickRateString "Rate"
```

## Text area

```elm
textInput model =
    Widget.TextArea.make GotText model.data "Enter text"
        |> TextArea.withWidth 400
        |> TextArea.withHeight 533
        |> TextArea.toElement
```

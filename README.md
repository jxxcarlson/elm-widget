# Widget

This package is a collection of configurable UI widgets: buttons, 
text fields, bars, etc.  Based on [Brian Hick's Robot Buttons from Mars].
Below are some examples.

## Button

```elm
appButton =
    button ReverseText "Reverse"
        |> Button.withWidth (Bounded 100)
        |> Button.withSelected False
        |> Button.toElement
```


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
    TextField.make msg text label
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
    TextArea.input GotText model.data "Enter text"
        |> TextArea.withWidth 400
        |> TextArea.withHeight 533
        |> TextArea.toElement
```
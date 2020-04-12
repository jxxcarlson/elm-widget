module Widget.Style exposing (noFocus)

{-| Example:

        Element.layoutWith { options =
          [ focusStyle Widget.Style.focus ] }

@docs noFocus

-}

import Element


{-| -}
noFocus : Element.FocusStyle
noFocus =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }

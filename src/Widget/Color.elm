module Widget.Color exposing
    ( black
    , charcoal
    , darkGray
    , darkRed
    , lightRed
    , mediumGray
    , pureWhite
    , white
    )

import Element exposing (..)


gray g =
    Element.rgb g g g


darkRed =
    Element.rgb 0.45 0 0


lightRed =
    Element.rgb 0.7 0 0


white =
    gray 0.9


pureWhite =
    gray 1.0


mediumGray =
    gray 0.6


darkGray : Color
darkGray =
    gray 0.4


charcoal : Color
charcoal =
    gray 0.2


black : Color
black =
    gray 0

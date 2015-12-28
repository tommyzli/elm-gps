import StartApp.Simple exposing (start)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
import Graphics.Element exposing (..)


main =
  start { model = initial, view = view, update = update }

port coordinates : Signal { latitude : String, longitude : String }
location = Signal.map update (Location coordinates)


---- CONSTANTS ----
apiKey : String
apiKey = "abc"


---- MODEL ----

type alias Model =
  { drinkChoice: Maybe String
  , latitude: Maybe String
  , longitude: Maybe String
  }

initial : Model
initial =
  { drinkChoice = Nothing
  , latitude = Nothing
  , longitude = Nothing
  }


---- UPDATE ----

type Action
  = Selected String
  | Location { latitude: String, longitude: String}
    
update : Action -> Model -> Model
update action model =
  case action of
    Selected choice -> { model | drinkChoice = Just choice }
    Location coordinates -> { model | latitude = Just coordinates.latitude, longitude = Just coordinates.longitude }


---- VIEW ----

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [ a [ onClick address (Selected "beer")] [ text "Beer" ] ]
    , h1 [] [ a [ onClick address (Selected "wine") ] [ text "Wine" ] ]
    , h1 [] [ a [ onClick address (Selected "spirit") ] [ text "Spirits" ] ]
    , button [] [ text "Choose a drink" ]
    , maybeChoice model
    , maybeLocation model
    ]
    
maybeChoice : Model -> Html
maybeChoice model =
  case model.drinkChoice of
    Just choice -> div [] [ text ("You chose: " ++ choice) ]
    Nothing -> span [] []

maybeLocation: Model -> Html
maybeLocation model =
  div []
  [ case model.latitude of
    Just latitude -> div [] [ text latitude ]
    Nothing -> span [] []
  , case model.longitude of
    Just longitude -> div [] [ text longitude ]
    Nothing -> span [] []
  ]
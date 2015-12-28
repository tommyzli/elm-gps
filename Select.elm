module Select where

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)

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


-- Import events from JS
--port coordinates : Signal { lat : String, long : String }
--coords = (Location <~ (lat ++ long))


---- UPDATE ----

type Action
  = Selected String
  | Location String String
    
update : Action -> Model -> Model
update action model =
  case action of
    Selected choice -> { model | drinkChoice = Just choice }
    Location latitude longitude -> { model | latitude = Just latitude, longitude = Just longitude }


---- VIEW ----

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [ a [ onClick address (Selected "beer")] [ text "Beer" ] ]
    , h1 [] [ a [ onClick address (Selected "wine") ] [ text "Wine" ] ]
    , h1 [] [ a [ onClick address (Selected "spirit") ] [ text "Spirits" ] ]
    , button [] [ text "Choose a drink" ]
    , maybeChoice model
    ]
    
maybeChoice : Model -> Html
maybeChoice model =
  case model.drinkChoice of
    Just choice -> div [] [ text ("You chose: " ++ choice) ]
    Nothing -> span [] []
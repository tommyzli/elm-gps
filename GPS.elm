module GPS where

import Effects exposing (Effects, Never)
import Task
import Html exposing (..)
import Html.Events exposing (onClick)


---- MODEL ----

type alias Model =
  { latitude: String
  , longitude: String
  }

init : (Model, Effects Action)
init =
  ( { latitude = ""
    , longitude = ""
    }
  , Effects.none
  )


---- UPDATE ----

type Action
  = GotLocation { latitude: String, longitude: String }

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    GotLocation coords ->
      ( { model | latitude = coords.latitude, longitude = coords.longitude }
      , receivedLocation model
      )

receivedLocation : { latitude: String, longitude: String } -> Effects Action
receivedLocation _ = Effects.none

---- VIEW ----

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ div [] [ text ("Coordinates " ++ model.latitude ++ ", " ++ model.longitude) ]
    ]

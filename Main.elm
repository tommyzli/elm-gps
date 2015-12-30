import StartApp exposing (start)

import Effects exposing (Effects, Never)
import Task
import Html exposing (..)
import Html.Events exposing (onClick)
import Http

---- Main ----
app =
  start
    { init = initial
    , update = update
    , view = view
    , inputs = [result]
    }

main = app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


port coordinates : Signal { latitude : String, longitude : String }
result : Signal Action
result = Signal.map GotLocation coordinates


---- MODEL ----

type alias Model =
  { latitude: String
  , longitude: String
  }

initial : (Model, Effects Action)
initial =
  ( { latitude = ""
    , longitude = ""
    }
  , Effects.none
  )


---- UPDATE ----

type Action
  = GotLocation Model
    
update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    GotLocation coords -> 
      ( { model | latitude = coords.latitude, longitude = coords.longitude }
      , getClosestStore model
      )

-- TODO: implement
getClosestStore : { latitude: String, longitude: String } -> Effects Action
getClosestStore _ = Effects.none

---- VIEW ----

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ div [] [ text ("Coordinates " ++ model.latitude ++ ", " ++ model.longitude) ]
    ]
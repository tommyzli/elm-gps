import StartApp exposing (start)

import GPS

import Effects exposing (Never)
import Task

---- Main ----
app =
  start
    { init = GPS.init
    , update = GPS.update
    , view = GPS.view
    , inputs = [result]
    }

main = app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


port coordinates : Signal { latitude : String, longitude : String }
result : Signal GPS.Action
result = Signal.map GPS.GotLocation coordinates

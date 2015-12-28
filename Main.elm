import Select exposing (update, view)
import StartApp.Simple exposing (start)

main =
  start { model = { drinkChoice = Nothing, latitude = Nothing, longitude = Nothing }, view = view, update = update }

port coordinates : Signal { lat : String, long : String }
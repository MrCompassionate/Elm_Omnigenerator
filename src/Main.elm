module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)

-- MODEL

type alias Model =
    { userInput : String
    , errorMessage : Maybe String
    }


init : Model
init =
    { userInput = ""
    , errorMessage = Nothing
    }


-- UPDATE

type Msg
    = UpdateInput String
    | SendToBackend


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateInput input ->
            { model | userInput = input, errorMessage = validate input }

        SendToBackend ->
            -- Here you can call your backend.
            model


-- Validation function to check if the input is a valid integer
validate : String -> Maybe String
validate input =
    if String.any (\char -> char < '0' || char > '9') input then
        Just "Please enter a valid integer."
    else
        Nothing


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Enter an integer", onInput UpdateInput, value model.userInput ] []
        , button [ onClick SendToBackend ] [ text "Send to Backend" ]
        , maybeDisplayError model.errorMessage
        ]


maybeDisplayError : Maybe String -> Html Msg
maybeDisplayError maybeMsg =
    case maybeMsg of
        Just msg ->
            div [ style "color" "red" ] [ text msg ]

        Nothing ->
            text ""


-- MAIN

main =
    Browser.sandbox { init = init, update = update, view = view }
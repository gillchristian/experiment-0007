module Layouts.Sidebar.Header.Settings exposing (Model, Msg, Props, layout)

import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events
import Layout exposing (Layout)
import Layouts.Sidebar.Header
import Route exposing (Route)
import Route.Path
import Shared
import View exposing (View)


type alias Props =
    {}


type alias Tab =
    ( String, Route.Path.Path )


layout : Props -> Shared.Model -> Route () -> Layout Layouts.Sidebar.Header.Props Model Msg contentMsg
layout props shared route =
    Layout.new
        { init = init
        , update = update
        , view = view route
        , subscriptions = subscriptions
        }
        |> Layout.withParentProps
            { title = "Settings"
            , shouldPadContent = False
            }



-- MODEL


type alias Model =
    { counter : Int }


init : () -> ( Model, Effect Msg )
init _ =
    ( { counter = 0 }
    , Effect.none
    )



-- UPDATE


type Msg
    = Increment


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }
            , Effect.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view :
    Route ()
    -> { toContentMsg : Msg -> contentMsg, content : View contentMsg, model : Model }
    -> View contentMsg
view route { toContentMsg, model, content } =
    { title = content.title
    , body =
        [ Html.div [ class "tabs" ]
            (List.map (viewTab route)
                [ ( "General", Route.Path.Settings )
                , ( "Account", Route.Path.Settings_Account )
                , ( "Notifications", Route.Path.Settings_Notifications )
                ]
            )
        , Html.div
            [ class "pad-16"
            , style "display" "flex"
            , style "gap" "1rem"
            , style "align-items" "center"
            ]
            [ Html.button [ class "btn", Html.Events.onClick Increment ]
                [ Html.text ("Settings (nested) Counter: " ++ String.fromInt model.counter)
                ]
                |> Html.map toContentMsg
            , Html.text <|
                if model.counter == 0 then
                    "State was (re) initialized."

                else
                    "State was preserved."
            ]
        , Html.div [ class "page pad-16" ] content.body
        ]
    }


viewTab : Route () -> ( String, Route.Path.Path ) -> Html msg
viewTab route ( label, path ) =
    Html.a
        [ class "tab"
        , classList
            [ ( "tab--active", route.path == path )
            ]
        , Route.Path.href path
        ]
        [ Html.text label ]

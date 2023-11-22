module Pages.Home_ exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html
import Html.Attributes exposing (class, href, target)
import Layouts
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
        |> Page.withLayout toLayout


toLayout : Model -> Layouts.Layout Msg
toLayout model =
    Layouts.Sidebar_Header
        { title = "Dashboard"
        , shouldPadContent = True
        }



-- INIT


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init () =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Dashboard"
    , body =
        [ Html.div [ class "page" ]
            [ Html.p [] [ Html.text "Welcome to the dashboard!" ]
            , Html.p [] [ Html.text "Increase the sidebar's counter then navigate to another page and back to see the counter persist!" ]
            , Html.p [] [ Html.text "Similarly, the settings counter state should persist across page navigations within the settings pages." ]
            , Html.p []
                [ Html.text "See the code: "
                , Html.a
                    [ href
                        "https://github.com/gillchristian/experiment-0007"
                    , target "_blank"
                    ]
                    [ Html.text "github.com/gillchristian/experiment-0007" ]
                ]
            ]
        ]
    }

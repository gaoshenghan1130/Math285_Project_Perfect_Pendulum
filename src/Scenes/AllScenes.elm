module Scenes.AllScenes exposing (allScenes)

{-| This module is generated by Messenger, don't modify this.

This module records all the scenes.

@docs allScenes

-}

import Scenes.Home.Export as Home
import Scenes.Home.Global as HomeG
import Scenes.SceneSettings exposing (SceneT)


{-| allScenes
Add all the scenes here
-}
allScenes : List ( String, SceneT )
allScenes =
    [ ( "Home", HomeG.sceneToST Home.scene )
    ]
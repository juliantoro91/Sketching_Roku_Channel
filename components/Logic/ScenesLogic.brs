sub InitScenes ()

    ? "ScenesLogic - InitScenes"

    ' Scenes array initialization
    m.scenes = []
    
    ' for 2 scenes: > scene = CreateObject(“MasterScene”) > scenes = Push(scene) > Add scene to MainScene
    for i = 0 to 1 Step 1
        
        scene = CreateObject("roSGNode", "MasterScene")
        m.scenes.Push(scene)
        m.top.AppendChild(scene)

    end for

end sub


function ReturnScene(sceneID = m.top.sceneID as Integer) as Object

    ? "ScenesLogic - ReturnScene"

    ' return scenes(sceneID)
    return m.scenes[sceneID]

end function
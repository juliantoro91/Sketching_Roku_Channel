sub init()
    
    ? "MainScene - Init"
    
    ' Background Setup
    m.top.backgroundColor = "0xEEEEEEFF"
    m.top.backgroundUri = ""

    m.screenVariables = LoadScreenVariables()

    InitScenes()

    scene = RetunScene(m.top.sceneID)

    screen = NewStartupScreen()

    'AddScreenToScene(screen, scene)

    m.top.ObserveField("changeScene", "OnChangeActualScene")
    
End sub


function LoadScreenVariables() as Object

    ? "MainScene - LoadScreenVariables"

    route = m.top.screenVariablesRoute ' The route of the file with the screen variables

    loaderTask = ReadAsciiFile(route)

    screenVariables = ParseJSON(loaderTask) ' To storage the screen variables
    
    return screenVariables.screenVariables
    
end function


sub OnChangeActualScene()

end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    ' decide the behavior of keys when pressed to control all screens with ScreenStack Node
    ? "OnKeyEvent-Scene"
    if press
        if key="back"
            RemoveScreen(invalid)
            result = true
        end if
    end if
    return result 
end function
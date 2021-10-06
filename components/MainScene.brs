sub init()
    
    ? "MainScene - Init"
    
    ' Set background
    m.top.backgroundColor = "0xEEEEEEFF"
    m.top.backgroundUri = "pkg:/images/FadeBackground.png"

    ' Set scene size: SetScreenDimensions()
    SetScreenDimensions(m.top, 1, 1)

    ' LoadScreenVariables()
    m.top.screenVariables = LoadScreenVariables()

    ' InitScenes()
    InitScenes()

    ' NewStartupScreen()
    screen = NewStartupScreen()

    ' Set changeScene observer
    m.top.ObserveField("changeScene", "OnChangeActualScene")
    
End sub


function LoadScreenVariables() as Object

    ? "MainScene - LoadScreenVariables"

    ' Set route
    route = m.top.screenVariablesRoute ' The route of the file with the screen variables

    ' ReadAsciiFile(route) and ParseJSON
    loaderTask = ReadAsciiFile(route)
    screenVariables = ParseJSON(loaderTask) ' To storage the screen variables
    
    'Return AssocArray
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
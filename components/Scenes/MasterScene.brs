' This function loads the screen variables, they're used to control the generation of different screens, based on their names, dimensions and translate info
function LoadScreenVariables() as Object

    ? "MasterScene - LoadScreenVariables"

    route = "pkg:/source/ScreenVariables.json" ' The route of the file with the screen variables

    loaderTask = ReadAsciiFile(route)

    screenVariables = ParseJSON(loaderTask) ' To storage the screen variables
    
    return screenVariables.screenVariables
    
end function


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
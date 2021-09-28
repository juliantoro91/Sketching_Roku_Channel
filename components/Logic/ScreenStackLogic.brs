sub AddScreen(screen as Object)

    ? "ScreenStackLogic - AddScreen"
    
    if screen <> invalid

        ChangeScreen(screen, "Add")
        
    end if
    
end sub


sub RemoveScreen (screen as Object)

    ? "ScreenStackLogic - CloseScreen"
    
    if screen = invalid OR screen.isSameNode(GetCurrentScreen())
        
        ChangeScreen(screen, "Remove")
            
    end if
    
end sub


sub ChangeScreen(screen as Object, action as String)

    ? "ScreenStackLogic - ChangeScreen"

    scene = ReturnScene()

    if action = "Add"

        prevScreen = GetCurrentScreen()

    else if action = "Remove"

        prevScreen = scene.screenStack.Pop()

    end if

    if prevScreen <> invalid

        actualChild.layerOne.GetChild(0)
        scene.layerOne.RemoveChild(actualChild)
        previousScreen.reparent(scene.layerOne, false)
        scene.layerOne.visible = true

    end if

    if action = "Add"

        scene.screenStack.Push(screen)

    else if action = "Remove"

        screen = GetCurrentScreen()

    end if

    if screen <> invalid

        scene.layerTwo.AppendChild(screen)
        screen.SetFocus(true)
        scene.layerTwo.visible = false
        scene.startTransition = true

    end if

end sub


function GetCurrentScreen() as Object

    ? "ScreenStackLogic - GetCurrentScreen"

    scene = ReturnScene()
    
    return scene.screenStack.Peek()
    
end function

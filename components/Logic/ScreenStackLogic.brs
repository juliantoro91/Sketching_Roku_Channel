sub InitScreenStack ()

    ? "ScreenStackLogic - InitScreenStack"
    
    ' Array to store screens
    m.screenStack = []
    
end sub


sub AddScreen(screen as Object)

    ? "ScreenStackLogic - AddScreen"
    
    previousScreen = m.screenStack.Peek()
    
    if screen <> invalid 'AND screen <> previousScreen
    
        if previousScreen <> invalid
        
            m.top.layerOne.RemoveChild(m.top.layerOne.GetChild(0))            
            previousScreen.reparent(m.top.layerOne, false)
            
        end if
            
        m.screenStack.Push(screen)
        m.top.layerTwo.AppendChild(screen)
        
        screen.SetFocus(true)
        
    end if
    
end sub


sub RemoveScreen (screen as Object)

    ? "ScreenStackLogic - CloseScreen"
    
    if m.screenStack.Count() > 1
        if screen = invalid OR screen.isSameNode(GetCurrentScreen())
        
            if screen = invalid then screen = m.screenStack.Pop()
            previousScreen = GetCurrentScreen()
            
            m.top.layerOne.RemoveChild(m.top.layerOne.GetChild(0))            
            screen.reparent(m.top.layerOne, false)
            if screen.stopVideo <> invalid then screen.stopVideo = true
            
            m.top.layerTwo.AppendChild(previousScreen)
        
            previousScreen.SetFocus(true)
            
        end if
    end if
    
end sub


sub GetCurrentScreen () as Object

    ? "ScreenStackLogic - GetCurrentScreen"
    
    return m.screenStack.Peek()
    
end sub

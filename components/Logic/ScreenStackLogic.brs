sub InitScreenStack ()

    ? "ScreenStackLogic - InitScreenStack()"

    m.screenStack = []
    
end sub

sub ShowScreen(screen as Object)

    ? "ScreenStackLogic - ShowScreen()"
    
    if screen <> invalid AND screen <> m.screenStack.Peek()
    
        previousScreen = m.screenStack.Peek()
        if previousScreen <> invalid then previousScreen.visible = false
        
        m.screenStack.Push(screen)
        m.top.AppendChild(screen)
        
        screen.SetFocus(true)
        screen.visible = true
        
    end if
    
end sub

sub CloseScreen (screen as Object)

    ? "ScreenStackLogic - CloseScreen()"
    
    if m.screenStack.Count() > 0
        if screen = invalid OR screen = m.screenStack.Pop()
            
            screen.visible=false
            m.top.removeChild(screen)
            
            previousScreen = m.screenStack.Peek()
            previousScreen.visible=true
            previousScreen.SetFocus(true)
            
        end if
    end if
    
end sub

sub GetCurrentScreen () as Object

    ? "ScreenStackLogic - GetCurrentScreen()"
    
    return m.screenStack.Peek()
    
end sub
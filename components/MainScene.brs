sub init()
    'm.overLogo=m.top.FindNode("overLogo")
    'm.startLoadingIndicator=m.top.FindNode("startLoadingIndicator")
    m.top.backgroundColor="0xffffffff"
    m.top.backgroundUri=""
    
    InitScreenStack()
    ShowUserScreen()
    'm.top.brackground="pkg:/images/splash_hd.jpg"
    
    'm.top.SetFocus(true)
End sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    ' decide the behavior of keys when pressed to control all screens with ScreenStack Node
    ? "OnKeyEvent-Home"
    if press
        if key="back"
            CloseScreen(invalid)
            result = true
        end if
    end if
    return result 
end function

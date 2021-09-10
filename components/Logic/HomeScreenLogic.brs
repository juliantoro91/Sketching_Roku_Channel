sub ShowHomeScreen()

    ? "HomeScreenLogic - ShowHomeScreen()"
    
    m.homeScreen = CreateObject("RoSGNode","HomeScreen")
    
    m.homeContentTask = CreateObject("RoSGNode","MainLoaderTask")
    m.homeContentTask.url = m.homeScreen.url
    m.homeContentTask.control="run"
    m.homeContentTask.observeField("content","OnHomeContentTaskChange")
    
    ShowScreen(m.homeScreen)
    
end sub

sub OnHomeContentTaskChange()

    ? "HomeScreen Logic - OnHomeContentTaskChange()"
    
    m.homeScreen.content = m.homeContentTask.content
    
end sub
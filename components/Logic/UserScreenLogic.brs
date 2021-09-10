sub ShowUserScreen()

    ? "UserScreenLogic - ShowUserScreen()"

    m.userScreen = CreateObject("RoSGNode","UserScreen")
    
    m.userContentTask = CreateObject("RoSGNode","MainLoaderTask")
    m.userContentTask.url = m.userScreen.url
    m.userContentTask.control="run"
    m.userContentTask.observeField("content","OnUserContentTaskChange")
    
    ShowScreen(m.userScreen)
    
    ' Observers
    m.userScreen.observeField("itemSelected","OnSelectedItem")
    
end sub


sub OnUserContentTaskChange()

    ? "UserScreenLogic - OnUserContentTaskChange()"

    m.userScreen.content = m.userContentTask.content.GetChild(0)
    
end sub


sub OnSelectedItem()
    
    ? "UserScreenLogic - OnSelectedItem"
    
    ShowHomeScreen()
    
end sub
sub init()
    
    ? "MainScene - Init"
    
    ' Layer's variables
    m.layerOne = m.top.FindNode("sceneLayerOne")
    m.top.layerOne = m.layerOne
    m.layerTwo = m.top.FindNode("sceneLayerTwo")
    m.top.layerTwo = m.layerTwo
    
    ' Background Setup
    m.top.backgroundColor = "0xEEEEEEFF"
    m.top.backgroundUri = ""
    
    ' Layers Setup
    SetScreenDimensions(m.layerOne, 1, 1)
    SetScreenDimensions(m.layerTwo, 1, 1)
    
    m.screenVariables = LoadScreenVariables()
    
    InitScreenStack()
    NewScreen(m.screenVariables.StartupScreen)
    
End sub
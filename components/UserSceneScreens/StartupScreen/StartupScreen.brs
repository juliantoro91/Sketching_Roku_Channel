sub Init()

    ? "StartupScreen - Init"

    m.startupLogo = m.top.FindNode("startupLogo")
    m.videoLogo = m.top.FindNode("videoLogo")
    m.temporalFrame = m.top.FindNode("temporalFrame")
    
    

    'm.videoLogo.width = m.top.width
    'm.videoLogo.height = m.top.height

    m.top.ObserveField("content","OnContentChange")

    ' Reparent Children
    for each child in m.temporalFrame.GetChildren(-1, 0)
        child.reparent(m.masterFrame, false)
    end for
    
end sub

sub OnContentChange()
    
    if m.top.content <> invalid
        m.startupLogo.width = m.top.width
        m.startupLogo.height = m.top.height
        m.startupLogo.loadWidth = m.startupLogo.width
        m.startupLogo.loadHeight = m.startupLogo.height
        m.startupLogo.loadDisplayMode = "scaleToFit"
        m.startupLogo.uri = m.top.content.GetChild(0).url
    end if
    'm.videoLogo.
end sub
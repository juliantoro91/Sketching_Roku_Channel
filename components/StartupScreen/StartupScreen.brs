sub Init()

    ? "StartupScreen - Init"

    m.startupLogo = m.top.FindNode("startupLogo")
    m.startupVideo = m.top.FindNode("startupVideo")

    m.top.video = m.startupVideo

    m.top.ObserveField("content", "ScreenSetup")

    m.top.ObserveField("visible", "OnVisibleChange")

end sub


sub SpecificScreenSetup()

    ? "StartupScreen - SpecificScreenSetup"

    m.startupLogo.uri = m.top.content.GetChild(0).url
    m.startupLogo.width = m.top.width
    m.startupLogo.height = m.top.height
    m.startupLogo.loadWidth = m.top.width
    m.startupLogo.loadHeight = m.top.height
    m.startupLogo.loadDisplayMode = "scaleToFit"
    m.startupLogo.visible = true

    m.startupVideo.content = m.top.content.GetChild(1)
    m.startupVideo.width = m.top.width
    m.startupVideo.height = m.top.height
    m.startupVideo.bufferingBarVisibilityAuto = false
    m.startupVideo.visible = false
    m.startupVideo.control = "play"
    
end sub

sub OnVisibleChange()

    ? "StartupScreen - OnVisibleChange"

    'if not m.top.visible then m.startupVideo.control = "stop"

end sub
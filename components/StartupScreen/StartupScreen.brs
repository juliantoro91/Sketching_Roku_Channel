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
    'm.startupVideo

end sub

sub OnVisibleChange()

    ? "StartupScreen - OnVisibleChange"

    if not m.top.visible then m.top.removeChild(m.startupVideo)

end sub
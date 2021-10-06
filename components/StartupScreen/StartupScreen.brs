sub Init()

    ? "StartupScreen - Init"

    ' Initialize startupLogo/Animation
    m.startupLogo = m.top.FindNode("startupLogo")
    m.startupAnimation = m.top.FindNode("startupAnimation")

    ' animator = CreateObject(“FrameAnimator”)
    m.animator = createObject("roSGNode", "FrameAnimator")

    ' Set content observer
    m.top.ObserveField("content", "ScreenSetup")
    ' Set visible observer
    m.top.ObserveField("visible", "OnVisibleChange")
    ' Set animator.loaded observer
    m.animator.ObserveField("loaded", "OnLoadedAnimation")

end sub


sub SpecificScreenSetup()

    ? "StartupScreen - SpecificScreenSetup"

    content = m.top.content

    ' Set startupLogo uri and size
    content = GetChildByID(m.top.content, m.startupLogo.id)
    m.startupLogo.uri = content.url
    m.startupLogo.width = m.top.width
    m.startupLogo.height = m.top.height
    m.startupLogo.loadWidth = m.top.width
    m.startupLogo.loadHeight = m.top.height
    m.startupLogo.loadDisplayMode = "scaleToFit"
    m.startupLogo.visible = true
    
    ' Set startupAnimation size
    content = GetChildByID(m.top.content, m.startupAnimation.id)
    m.startupAnimation.width = m.top.width
    m.startupAnimation.height = m.top.height
    m.startupAnimation.loadWidth = m.top.width
    m.startupAnimation.loadHeight = m.top.height
    m.startupAnimation.loadDisplayMode = "scaleToFit"

    ' LoadFrames()
    m.frames = []
    m.fps = 0
    route = content.route
    name = content.name
    file = content.file
    totalFrames = val(content.totalFrames)
    duration = val(content.duration)

    LoadFrames(route, name, file, totalFrames, duration)

    ' startupAnimation NOT visible
    m.startupAnimation.visible = false

    ' Start animator
    m.animator.callFunc("start", m.frames, m.fps, m.startupAnimation)
    
end sub

sub OnVisibleChange()

    ? "StartupScreen - OnVisibleChange"

    ' if visible = false: Finish startupAnimation
    if not m.top.visible then m.animator.callFunc("finish")

end sub

sub OnLoadedAnimation()

    ? "StartupScreen - OnLoadedAnimation"

    ' Set startupLogo NOT visible
    m.startupLogo.visible = false


    ' Set startupAnimation visible
    m.startupAnimation.visible = true

    ' Set animationStarted to TRUE
    m.top.animationLoaded = true
    
end sub
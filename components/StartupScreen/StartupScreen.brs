sub Init()

    ? "StartupScreen - Init"

    m.startupLogo = m.top.FindNode("startupLogo")
    m.startupAnimation = m.top.FindNode("startupAnimation")


    ' TEST
    m.decoder = createObject("roSGNode", "GIFDecoder")
    m.decoder.delegate = m.top
    m.animator = createObject("roSGNode", "FrameAnimator")
    

    'm.top.video = m.startupVideo

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
    m.startupLogo.visible = false

    m.startupAnimation.uri = "pkg:/images/StartupVideo_GIF.gif"
    m.startupAnimation.width = m.top.width
    m.startupAnimation.height = m.top.height
    m.startupAnimation.loadWidth = m.top.width
    m.startupAnimation.loadHeight = m.top.height
    m.startupAnimation.loadDisplayMode = "scaleToFit"
    m.startupAnimation.visible = true


    ' Start decoder
    m.decoder.callFunc("decodeGIF", "pkg:/images/GIF.gif")
    ' Created usign web tool: https://ezgif.com/video-to-gif/
    ' Method: Preserve transparency (transparent video to transparent GIF)
    
end sub

sub OnVisibleChange()

    ? "StartupScreen - OnVisibleChange"

    'if not m.top.visible then m.startupVideo.control = "stop"

end sub

sub gifDecoderDidFinish(frames as Object, fps as Float)
    m.animator.callFunc("start", frames, fps, m.startupAnimation)
end sub
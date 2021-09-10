sub init()
    
    ? "MainScene - Init()"
    
    ' Element variables
    m.overLogo=m.top.FindNode("overLogo")
    'm.startLoadingIndicator=m.top.FindNode("startLoadingIndicator")
    m.masterFrameRect = m.top.findNode("mainMasterFrameRect")
    m.layerOne = m.top.FindNode("sceneLayerOne")
    m.top.layerOne = m.layerOne
    m.layerTwo = m.top.FindNode("sceneLayerTwo")
    m.top.layerTwo = m.layerTwo
    
    ' Background Setup
    m.top.backgroundColor = "0xffffffff"
    m.top.backgroundUri = ""
    
    ' Screen Setup
    widthFactor = 0.9
    heightFactor = 0.94
    SetScreenDimensions(m.top, widthFactor, heightFactor)
    m.top.masterFrameDeviation = [0, 0]
    CenterMasterFrameRect(m.masterFrameRect, m.top.masterFrameDeviation)
    
    ' Layers Setup
    SetScreenDimensions(m.layerOne, 1, 1)
    SetScreenDimensions(m.layerTwo, 1, 1)
    
    ' Logo Translation and Rotation
    m.overlogo.rotation = Pi() / 2
    centerX = CreateObject("roFloat")
    centerX.SetFloat(m.top.width - m.overLogo.height)
    centerY = CreateObject("roFloat")
    centerY.SetFloat(m.top.height)
    m.overLogo.translation = [centerX, centerY]
    
    InitScreenStack()
    ShowUserScreen()
    
    ' Animation
    m.shader = m.top.findNode("sceneShader")
    m.animation = m.top.findNode("sceneAnimation")
    m.interpolator = m.top.findNode("sceneAnimationInterpolator")
    m.animationChange = false
    
    SetScreenDimensions(m.shader, 1, 1)
    
    ' Tracking layer changes
    m.layerOne.observeField("change","OnFirstAnimation")
    m.layerTwo.observeField("change","OnFirstAnimation")
    m.interpolator.observeField("fraction","OnSecondAnimation")
    
End sub


sub OnFirstAnimation()

    ? "Scene - OnFirstAnimation";" : ";m.layerOne.change.operation;" / ";m.layerTwo.change.operation
    
    if m.layerOne.change.operation = "add" and m.layerTwo.change.operation = "remove"
        
        m.layerOne.visible = true
        m.layerTwo.visible = false
        
        m.animationChange = false
        
        m.animation.control = "start"
        
    end if
    
end sub


sub OnSecondAnimation()
    
    if m.interpolator.fraction > 0.5 and not m.animationChange
    
        ? "Scene - OnSecondAnimation"
        
        m.layerOne.visible = false
        m.layerTwo.visible = true
        
        m.animationChange = true
        
    end if
    
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    ' decide the behavior of keys when pressed to control all screens with ScreenStack Node
    ? "OnKeyEvent-Scene"
    if press
        if key="back"
            CloseScreen(invalid)
            result = true
        end if
    end if
    return result 
end function

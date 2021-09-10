sub Init()

    ? "HomeScreen - Init()"
    
    ' Node identification
    m.top.id = "homeScreen"
    m.top.url = "https://testappjue.web.app/Sketching/SketchingContent.json"
    
    ' Element variables definition
    m.masterFrame = m.top.FindNode("masterFrame")
    m.masterFrameRect = m.top.FindNode("masterFrameRect")
    m.temporalFrame = m.top.FindNode("temporalFrame")
    
    m.backgroundFrame = m.top.FindNode("backgroundFrame")
    m.homeBackground = m.top.FindNode("homeBackground")
    
    m.descriptionFrameRect = m.top.FindNode("homeDescriptionFrameRect")
    m.descriptionLogo = m.top.FindNode("homeDescriptionLogo")
    m.descriptionLabel = m.top.FindNode("homeDescriptionLabel")
    m.descriptionButtonOne = m.top.FindNode("homeDescriptionButtonPlay")
    m.descriptionButtonTwo = m.top.FindNode("homeDescriptionButtonInfo")
    m.descriptionButtonsFrameRect = m.top.FindNode("homeDescriptionButtonsFrameRect")
    m.descriptionButtonOne.FocusedTextFont.size = m.descriptionButtonOne.textFont.size
    m.descriptionButtonTwo.FocusedTextFont.size = m.descriptionButtonTwo.textFont.size
    
    m.rowlistVariableSpacing = m.top.findNode("rowlistVariableSpacing")
    m.rowlistAnimation = m.top.findNode("rowlistVariableSpacingAnimation")
    m.rowlistInterpolator = m.top.findNode("rowlistVariableSpacingAnimationInterpolator")
    m.minRowlistVariableSpace = 10
    m.maxRowlistVariableSpace = 180
    
    m.screenGrid = m.top.FindNode("homeScreenGrid")
    m.fadeBottom = m.top.FindNode("homeFadeBottom")
    
    ' Background
    m.animatedBackground = m.top.FindNode("homeAnimatedBackground")
    m.fadeOverlayBackground = m.top.FindNode("homeFadeOverlayBackground")
    m.overlayBackground = m.top.FindNode("homeOverlayBackground")
    
    ' Add fields
    m.descriptionFrameRect.addFields({"avoidDimensionalChange" : "true"}) ' to avoid width change
    m.descriptionlogo.addFields({"avoidDimensionalChange" : "true"}) ' to avoid width change
    m.descriptionButtonsFrameRect.addFields({"avoidDimensionalChange" : "true"}) ' to avoid width change
    
    ' Observers
    m.top.observeField("visibleState","OnVisibleChange")
    m.top.observeField("content","OnScreenContentChange")
    m.descriptionButtonOne.observeField("buttonSelected","HomeTimerFires")
    m.top.observeField("focusedChild","OnFocusChange")
    
    ' Variable to control initial setup of Grid
    m.gridInitialSetup = true
    
    ' Screen Setup
    widthFactor = 0.80
    heightFactor = 0.87
    SetScreenDimensions (m.top, widthFactor, HeightFactor)
    m.top.masterFrameDeviation = [50, 25]
    m.masterFrame.horizAlignment = "left"
    
    ' Additional settings
    m.fadeOverlayBackground.uri = "pkg:/images/videoFadeOverlay.png" ' Fade Overlay Background
    SetScreenDimensions(m.fadeOverlayBackground, 1, 1)
    m.fadeOverlayBackground.loadWidth = m.fadeOverlayBackground.width
    m.fadeOverlayBackground.loadHeight = m.fadeOverlayBackground.height
    
    SetScreenDimensions(m.overlayBackground, 1, 1) ' Overlay Background
    
    m.fadeBottom.uri = "pkg:/images/bottomOverlay.png" ' Fade at Bottom
    m.fadeBottom.width = m.fadeOverlayBackground.width 
    m.fadeBottom.loadWidth = m.fadeBottom.width
    CenterX = CreateObject("roFloat")
    CenterX.SetFloat(0)
    CenterY = CreateObject("roFloat")
    CenterY.SetFloat(m.fadeOverlayBackground.height - m.fadeBottom.height)
    m.fadeBottom.translation = [CenterX, CenterY]
    
    ' Reparent Children
    for each child in m.temporalFrame.GetChildren(m.temporalFrame.GetChildCount(),0)
        child.reparent(m.masterFrame, false)
    end for
    for each child in m.homeBackground.GetChildren(m.homeBackground.GetChildCount(),0)
        child.reparent(m.backgroundFrame, false)
    end for
    
    ' Timer to control grid visibility
    m.homeTimer = CreateObject("roSGNode", "Timer")
    m.homeTimer.duration = 10
    m.homeTimer.observeField("fire", "HomeTimerFires")
    
end sub


sub OnFocusChange()

    if m.screenGrid.hasFocus() then m.rowlistVariableSpacing.height = m.minRowlistVariableSpace
    
end sub


sub OnVisibleChange()

    ? "HomeScreen - OnVisibleChange()"
    
    if m.top.visible
    
        m.screenGrid.SetFocus(true)
    
    end if
    
end sub


sub OnScreenContentChange()
    
    ? "HomeScreen - OnScreenContentChange()"
    
    m.screenGrid.content = m.top.content
    
    OnFrameChange(m.masterFrame, m.top)
    
end sub


sub OnScreenGridChange()
    
    OnHomeScreenGridChange()
    
end sub


sub OnHomeScreenGridChange()

    ? "HomeScreen - OnScreenGridChange()"

    ' UserScreenGrid - Layout Setup
    screenGridWidth = m.top.width - (m.screenGrid.boundingRect().width - m.top.width)
    screenGridHeight = m.screenGrid.itemSize[1]
    m.screenGrid.itemsize = [screenGridWidth, screenGridHeight]
    
    if m.gridInitialSetup
        m.screenGrid.numRows = m.screenGrid.content.GetChildCount()
        m.gridInitialSetup = false
    end if
    
    ' Increasing initial spacing between description and rowlist
    m.rowlistVariableSpacing.height = m.minRowlistVariableSpace
    m.screenGrid.SetFocus(true)
    
end sub


sub OnFocusedItemChange()

    ? "homeScreen - OnFocusedItemChange()"
    
    row = m.top.itemFocused[0]
    item = m.top.itemFocused[1]
    
    if m.top.content <> invalid AND row <> -1 AND item <> -1
        
        content = m.top.content.GetChild(row).GetChild(item)
        
        if content <> invalid
            m.descriptionLogo.uri = content.contentLogo
            m.descriptionLabel.text = content.description
            m.animatedBackground.content = content
        end if
    
    end if
    
    m.homeTimer.control = "start"
    
end sub


sub HomeTimerFires()

    ? "homeScreen - HomeTimerFires()"
    
    m.top.hideMasterFrame = true
    
end sub


sub OnHideMasterFrame()

    ? "homeScreen - OnHideMasterFrame()"
    
    if not m.top.stopVideo
        if m.top.hideMasterFrame
            
            m.masterFrameRect.visible = false
            m.fadeBottom.visible = false
            m.fadeOverlayBackground.visible = false
            m.overlayBackground.visible = false
            
            m.animatedBackGround.focusable = true
            m.animatedBackground.SetFocus(true)
            
            m.homeTimer.control = "stop"
            
        else
        
            m.masterFrameRect.visible = true
            m.fadeBottom.visible = true
            m.fadeOverlayBackground.visible = true
            m.overlayBackground.visible = true
            m.screenGrid.SetFocus(true)
            
        end if
    end if
    
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean

    result = false

    if press
        if key="up"
            if m.screenGrid.hasFocus()
                m.descriptionButtonOne.SetFocus(true)
                m.rowlistInterpolator.keyValue = [m.minRowlistVariableSpace, m.maxRowlistVariableSpace]
                m.rowListAnimation.control = "start"
                result = true
            end if
        else if key="down"
            if m.descriptionButtonOne.hasFocus() or m.descriptionButtonTwo.hasFocus()
                m.screenGrid.setFocus(true)
                m.rowlistInterpolator.keyValue = [m.maxRowlistVariableSpace, m.minRowlistVariableSpace]
                m.rowListAnimation.control = "start"
                result = true
            end if
        else if key="right"
            if m.descriptionButtonOne.hasFocus()
                m.descriptionButtonTwo.SetFocus(true)
                result = true
            end if
        else if key="left"
            if m.descriptionButtonTwo.hasFocus()
                m.descriptionButtonOne.SetFocus(true)
                result = true
            end if
        end if
    end if
    
    return result
    
end function
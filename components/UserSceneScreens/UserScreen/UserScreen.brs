sub Init()

    ? "UserScreen - Init()"
    
    ' Node initial setup
    m.top.id = "userScreen"
    m.top.url = "https://testappjue.web.app/Sketching/SketchingUserContent.json"
    
    ' Element Variables definition
    m.masterFrame = m.top.FindNode("masterFrame")
    m.masterFrameRect = m.top.FindNode("masterFrameRect")
    m.temporalFrame = m.top.FindNode("temporalFrame")
    m.screenLogoFrame = m.top.FindNode("userScreenLogoFrame")
    m.screenLogo = m.top.FindNode("userScreenLogo")
    m.screenGrid = m.top.FindNode("userScreenGrid")
    
    ' Add fields
    m.screenLogoFrame.addFields({"avoidDimensionalChange" : "true"}) ' to avoid width change
    
    ' Observers
    m.top.observeField("visibleState","OnVisibleChange")
    m.top.observeField("content","OnScreenContentChange")
    m.top.observeField("focusedChild","OnFocusChange")
    
    ' Variable to control initial setup of Grid
    m.gridInitialSetup = true
    
    ' Screen Setup
    widthFactor = 0.625
    heightFactor = widthFactor
    SetScreenDimensions (m.top, widthFactor, heightFactor)
    m.top.masterFrameDeviation = [0, 0]
    
    ' Reparent Children
    for each child in m.temporalFrame.GetChildren(m.temporalFrame.GetChildCount(),0)
        child.reparent(m.masterFrame, false)
    end for
    
end sub


sub OnFocusChange()
    if m.top.isInFocusChain() then m.screenGrid.SetFocus(true)
end sub


sub OnVisibleChange()

    ? "UserScreen - OnVisibleChange()"
    
    if m.top.visible
        m.screenGrid.SetFocus(true)
    end if
    
end sub


sub OnScreenContentChange()
    
    ? "UserScreen - OnScreenContentChange()"
    
    m.screenGrid.content = m.top.content
    
    OnFrameChange(m.masterFrame, m.top)
    
end sub


sub OnScreenGridChange()
    
    OnUserScreenGridChange()
    
end sub


sub OnUserScreenGridChange()

    ? "UserScreen - OnUserScreenGridChange()"

    ' UserScreenGrid - Layout Setup
    screenGridWidth = m.top.width * 0.8
    childrenQ = m.screenGrid.content.GetChildCount()
    grossWidth = m.screenGrid.itemSize[0] * childrenQ
    
    itemSpacing = SetItemSpacings(screenGridWidth, grossWidth, childrenQ)
    itemSpacings = []
    
    for i = 0 to (childrenQ-2)
        itemSpacings.Push(itemSpacing)
    end for
    
    m.screenGrid.columnSpacings = itemSpacings
    
    if m.gridInitialSetup
        m.screenGrid.numColumns = childrenQ
        m.gridInitialSetup = false
    end if
    
end sub


sub OnFocusedItemChange()

    ? "UserScreen - OnFocusedItemChange()"
    
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean

    result = false
    
    if press
    end if
    
    return result
    
end function
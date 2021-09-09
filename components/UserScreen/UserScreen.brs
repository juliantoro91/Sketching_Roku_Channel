sub Init()

    ? "UserScreen - Init()"
    
    ' Element Variables
    m.masterFrame = m.top.FindNode("masterFrame")
    m.masterFrameRect = m.top.FindNode("masterFrameRect")
    m.userScreenLogoFrame = m.top.FindNode("userScreenLogoFrame")
    m.userScreenLogo = m.top.FindNode("userScreenLogo")
    m.userScreenGrid = m.top.FindNode("userScreenGrid")
    m.labelsFrameRect = m.top.FindNode("labelsFrameRect")
    
    ' Add field to avoid width change
    m.userScreenLogoFrame.addFields({"avoidDimensionalChange" : "true"})
    
    ' Observers
    m.top.observeField("visible","OnVisibleChange")
    m.top.observeField("focusedChild","OnFocusedChildChange")
    
    ' Variable to control initial setup of Grid
    m.gridInitialSetup = true
    
end sub


sub OnVisibleChange()
    if m.top.visible then m.userScreenGrid.SetFocus(true)
end sub


sub OnFocusedChildChange()
    if m.top.hasFocus() then m.userScreenGrid.SetFocus(true)
end sub


sub OnUserScreenGridChange()

    ? "UserScreen - OnUserScreenGridChange()"

    ' UserScreenGrid - Layout Setup
    userScreenGridWidth = m.top.width * 0.8
    childrenQ = m.userScreenGrid.content.GetChildCount()
    grossWidth = m.userScreenGrid.itemSize[0] * childrenQ
    
    itemSpacing = SetItemSpacings(userScreenGridWidth, grossWidth, childrenQ)
    itemSpacings = []
    
    for i = 0 to (childrenQ-2)
        itemSpacings.Push(itemSpacing)
    end for
    
    m.userScreenGrid.columnSpacings = itemSpacings
    
    if m.gridInitialSetup
        m.userScreenGrid.numColumns=childrenQ
        m.gridInitialSetup = false
    end if
    
end sub


sub OnFrameChange()

    ? "UserScreen - OnFrameChange()"

    if m.top.dimensionChange
    
        isVertical = false
        if m.masterFrame.layoutDirection = "vert" then isVertical = true
    
        if AutoLayout(m.masterFrame, isVertical) then ? "AutoLayout Success"
        CenteringLayout(m.masterFrame)
        
        OnUserScreenGridChange()
        
        OnMasterFrameRectChange()
        
        m.top.dimensionChange = false
        
    end if
    
end sub


sub OnFocusedItemChange()

    ? "UserScreen - OnFocusedItemChange()"
    
    item = m.top.itemFocused
    
    if not m.top.dimensionChange and item > -1
    
        content = m.top.content.GetChild(item)
        dimensions = content.title.split("x")
        
        width = dimensions[0].ToFloat()
        height = dimensions[1].ToFloat()
        
        m.top.width = width
        m.top.height = height
        
        ? "Change width: ";width
        ? "Change height: ";height
        
        m.top.dimensionChange = true
        
    end if
    
end sub


sub OnMasterFrameRectChange()
    
    ? "UserScreen - OnMasterFrameRectChange()"
    dimensions = m.masterFrameRect.boundingRect()
    
    centerX = CreateObject("roFloat")
    centerX.SetFloat((1280 - dimensions.width) / 2)
    
    centerY = CreateObject("roFloat")
    centerY.SetFloat((720 - dimensions.height) / 2)
    
    m.masterFrameRect.translation = [centerX, centerY]
    
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean

    result = false
    
    if press
    end if
    
    return result
    
end function
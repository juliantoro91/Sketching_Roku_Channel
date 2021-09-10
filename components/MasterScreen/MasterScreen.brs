'***** FUNCTIONS TO CONTROL SCREEN SETUP AND AUTOLAYOUT *****

sub SetScreenDimensions (node as Object, widthFactor as Float, heightFactor as Float)
    
    ? "MasterScreeen - SetScreenDimensions()"
    
    screenDimensions = CreateObject("roDeviceInfo").GetDisplaySize()
    m.width = screenDimensions.w
    m.height = screenDimensions.h
    
    
    node.width = m.width * widthFactor
    node.height = m.height * heightFactor
    
end sub


sub CenterMasterFrameRect(masterFrameRect as Object, deviation as Object)
    
    ? "MasterScreeen - CenterMasterFrameRect()"
    deviationX = deviation[0]
    deviationY = deviation[1]
    
    centerX = CreateObject("roFloat")
    centerX.SetFloat(deviationX + (m.width - m.top.width) / 2)
    
    centerY = CreateObject("roFloat")
    centerY.SetFloat(deviationY + (m.height - m.top.height) / 2)
    
    masterFrameRect.translation = [centerX, centerY]
    
end sub


function AutoLayout (node as Object, isVertical as Boolean) as Boolean

    ? "MasterScreeen - AutoLayout()"
    
    ' Get parent and verify its existence
    parent = node.GetParent()
    if parent = invalid then return false
    
    ' Verify the Layout Structure
    if parent.threadInfo().node.type <> "Rectangle" then return false
    if node.threadInfo().node.type <> "LayoutGroup" then return false
    
    ' Get parent dimensions
    parentWidth = parent.width
    parentHeight = parent.height
    
    childrenQ = node.GetChildCount()
    for each child in node.GetChildren(childrenQ,0)
    
        if child.width <> invalid
            if child.avoidDimensionalChange = invalid
                if isVertical
                    child.width = parentWidth
                else
                    child.height = parentheight
                end if
            end if
        end if
        
        ' Verifying child recurrence in function
        if child.threadInfo().node.type = "Rectangle" and child.GetChildCount() = 1 and child.GetChild(0).threadInfo().node.type = "LayoutGroup"
            
            childIsVertical = false
            if child.GetChild(0).layoutDirection = "vert" then childIsVertical = true
            
            if AutoLayout(child.GetChild(0), childIsVertical) then ? "AutoLayout Success"
            CenteringLayout(child.GetChild(0))
            
        end if
        
    end for
    
    grossDimension = 0 ' Variable to store the gross dimension of all components
        
    ' Calculate itemSpacings
    if isVertical
        grossDimension = node.boundingRect().height
        itemSpacing = SetItemSpacings(parentHeight, grossDimension, childrenQ)
    else
        grossDimension = node.boundingRect().width
        itemSpacing = SetItemSpacings(parentWidth, grossDimension, childrenQ)
    end if
    
    ? "itemSpacing : ";node.id;" : ";itemSpacing
    
    ' Set itemSpacings
    node.itemSpacings = itemSpacing
    
    return true
      
end function


function SetItemSpacings (parentDimension as Float, grossDimension as Float, childrenQ as Integer) as Float

    ? "MasterScreeen - SetItemSpacings"
    
    itemSpacing = (parentDimension - grossDimension) / (childrenQ - 1)
    
    return itemSpacing
    
end function


sub OnFrameChange(masterFrame as Object, node as Object)

    ? "MasterScreeen - OnFrameChange()"
    
    isVertical = false
    if masterFrame.layoutDirection = "vert" then isVertical = true

    if AutoLayout(masterFrame, isVertical) then ? "AutoLayout Success"
    CenteringLayout(masterFrame)
    
    'OnScreenGridChange()
    node.callFunc("OnScreenGridChange")
    
    masterFrameRect = masterFrame.GetParent()
    
    CenterMasterFrameRect(masterFrameRect, node.masterFrameDeviation)
    
end sub
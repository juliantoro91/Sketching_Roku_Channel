'***** FUNCTIONS TO CONTROL SCREEN SETUP AND AUTOLAYOUT *****

sub ScreenSetup()

    ? "MasterItem - SetupScreen"

    SetScreenDimensions(m.top, m.top.widthFactor, m.top.heightFactor)

    m.masterFrame = m.top.FindNode("masterFrame")
    m.masterFrameLG = m.top.FindNode("masterFrameLG")
    temporalFrame = m.top.FindNode("temporalFrame")

    for each child in temporalFrame.GetChildren(-1, 0)

        child.Reparent(m.masterFrameLG, false)

    end for

    m.top.callFunc("SpecificScreenSetup")

    isVertical = false
    if m.masterFrameLG.layoutDirection = "vert" then isVertical = true


    if AutoLayout(m.masterFrameLG, isVertical) then ? ">>> AutoLayout Success"
    CenteringLayout(m.masterFrameLG)

    CenterMasterFrame(m.masterFrame, m.top.masterFrameDeviation)

    m.top.loadCompleted = true

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
    
    for each child in node.GetChildren(-1, 0)
    
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
    
    ? ">>> itemSpacings: ";node.id;" | ";itemSpacing
    
    ' Set itemSpacings
    node.itemSpacings = itemSpacing
    
    return true
      
end function


function SetItemSpacings (parentDimension as Float, grossDimension as Float, childrenQty as Integer) as Float

    ? "MasterScreeen - SetItemSpacings"
    
    itemSpacing = (parentDimension - grossDimension) / (childrenQty - 1)
    
    return itemSpacing
    
end function


sub CenterMasterFrame(masterFrame as Object, deviation as Object) ' CHANGE NAME
    
    ? "MasterScreeen - CenterMasterFrameRect()"
    deviationX = deviation[0]
    deviationY = deviation[1]

    screenWidth = screenDimensions.w
    screenHeight = screenDimensions.h
    
    centerX = CreateObject("roFloat")
    centerX.SetFloat(deviationX + (screenWidth - m.top.width) / 2)
    
    centerY = CreateObject("roFloat")
    centerY.SetFloat(deviationY + (screenHeight - m.top.height) / 2)
    
    masterFrame.translation = [centerX, centerY]
    
end sub
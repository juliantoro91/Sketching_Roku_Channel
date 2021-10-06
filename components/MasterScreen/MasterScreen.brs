'***** FUNCTIONS TO CONTROL SCREEN SETUP AND AUTOLAYOUT *****

sub ScreenSetup()

    ? "MasterScreen - SetupScreen"

    ' Initialize master,back and temporal frames
    masterFrame = m.top.FindNode("masterFrame")
    masterFrameLG = m.top.FindNode("masterFrameLG")
    temporalMasterFrame = m.top.FindNode("temporalFrame")

    backFrame = m.top.FindNode("backgroundFrame")
    temporalBackFrame = m.top.FindNode("temporalBackground")

    ' SetScreenDimensions()
    SetScreenDimensions(m.top, m.top.widthFactor, m.top.heightFactor)

    ' Set masterFrame Size: usign alias in interface fields

    ' Set backFrame Size
    if m.top.fullSizedBackground
        SetScreenDimensions(backFrame, 1, 1)
    else
        backFrame.width = m.top.width
        backFrame.height = m.top.height
    end if

    ' Reparent temporalFrame's children
    ReparentChildren(temporalMasterFrame, masterFrameLG)
    ReparentChildren(temporalBackFrame, backFrame)

    ' Call Function "Specific Screen Setup"
    m.top.callFunc("SpecificScreenSetup")

    ' AutoLayout() masterFrame
    if AutoLayout(masterFrameLG) then ? ">>> AutoLayout Success"
    
    ' AligFrame() master and back
    AlignFrame(masterFrame, m.top.masterDeviation)
    if not m.top.fullSizedBackground then AlignFrame(backFrame, m.top.masterDeviation)

    ' Set loadComplete to true
    m.top.loadCompleted = true

end sub


sub ReparentChildren(temporal, frame)

    ? "MasterScreen - ReparentChildren"

    ' for each child in temportal: > Reparent to frame
    if temporal.GetChildCount() <> 0
        for each child in temporal.GetChildren(-1, 0)

            child.Reparent(frame, false)

        end for
    end if

end sub


function AutoLayout (node as Object) as Boolean

    ? "MasterScreeen - AutoLayout()"
    
    ' Get parent
    parent = node.GetParent()
    if parent = invalid then return false

    ' Verify AutoLayout() Structure (parent as “Rectangle” and “Child” as “LayoutGroup”)
    if parent.threadInfo().node.type = "Rectangle" and parent.GetChildCount() = 1 and node.threadInfo().node.type = "LayoutGroup"  
        isVertical = false
        if node.layoutDirection = "vert" then isVertical = true
    else
        return false
    end if

    ' Set parent width and height
    parent.width = m.top.width
    parent.height = m.top.height
    
    ' Set children width or height
    for each child in node.GetChildren(-1, 0)
        
        if child.width <> invalid
            if child.avoidDimensionalChange = invalid
                if isVertical
                    child.width = parent.width
                else
                    child.height = parent.height
                end if
            end if
        end if

        ' Child AutoLayout()
        if AutoLayout(child) then ? ">>> AutoLayout Success"
        
    end for
    
    grossDimension = 0 ' Variable to store the gross dimension of all components
        
    ' SetItemSpacings()
    childrenQty = node.GetChildCount()
    
    if isVertical
        grossDimension = node.boundingRect().height
        itemSpacing = SetItemSpacings(parent.height, grossDimension, childrenQty)
    else
        grossDimension = node.boundingRect().width
        itemSpacing = SetItemSpacings(parent.width, grossDimension, childrenQty)
    end if
    
    ? ">>> itemSpacings: ";node.id;" | ";itemSpacing

    node.itemSpacings = itemSpacing

    ' AlignLayout()
    AlignLayout(node)
    
    return true
      
end function


function SetItemSpacings(parentDimension as Float, grossDimension as Float, childrenQty as Integer) as Float

    ? "MasterScreeen - SetItemSpacings"

    ' Calculate Item Spacing
    if childrenQty > 1
        itemSpacing = (parentDimension - grossDimension) / (childrenQty - 1)
    else
        itemSpacing = 0
    end if
    
    ' Return spacing
    return itemSpacing
    
end function


sub AlignFrame(frame as Object, deviation as Object)
    
    ? "MasterScreeen - AlignFrame()"
    deviationX = deviation[0]
    deviationY = deviation[1]

    screenDimensions = CreateObject("roDeviceInfo").GetDisplaySize()
    screenWidth = screenDimensions.w
    screenHeight = screenDimensions.h
    
    ' Use deviation and screen size to center frame
    centerX = CreateObject("roFloat")
    centerX.SetFloat(deviationX + (screenWidth - m.top.width) / 2)
    
    centerY = CreateObject("roFloat")
    centerY.SetFloat(deviationY + (screenHeight - m.top.height) / 2)
    
    frame.translation = [centerX, centerY]
    
end sub


sub LoadFrames(route as String, name as String, file as String, totalFrames as Float, duration as Float)
    
    ? "MasterScreen - LoadFrames"
    
    frames = m.frames

    ' Set base route Set base name
    uri = route + name

    'Populate frames Array
    for i = 1 to totalFrames step 1

        index = Str(i)
        frames.Push(uri + Right(index, Len(index)-1) + file)

    end for
    
    ' Calculate and set fps
    m.fps = duration/totalFrames

end sub
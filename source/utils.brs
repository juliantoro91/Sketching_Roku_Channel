'***** SCREENS AND LAYOUTS *****

sub SetScreenDimensions (node as Object, widthFactor as Float, heightFactor as Float)
    
    ? "Utils - SetScreenDimensions"
    
    ' CreateObject(“roDeviceInfo”)
    screenDimensions = CreateObject("roDeviceInfo").GetDisplaySize()
    'Get Display Size
    screenWidth = screenDimensions.w
    screenHeight = screenDimensions.h
    
    ' Set node width and height usign factors and display size
    node.width = screenWidth * widthFactor
    node.height = screenHeight * heightFactor
    
end sub


sub AlignLayout(node as Object)

    ? "Utils - AlignLayout"

    node.translation = [0, 0]
    
    ' Adjust LayoutGroup translation
    coordenates = node.boundingRect()
    
    if coordenates.x <> 0 OR coordenates.y <> 0 then node.translation = [-coordenates.x, -coordenates.y]
    
end sub


sub GetTheScene()
end sub


sub GetUserID()
end sub


function GetChildByID(node as Object, id as String) as Object

    ? "utils - GetChildByID"

    if node.GetChildCount() < 1 then return invalid

    ' for each child in node children:
    for each child in node.GetChildren(-1, 0)

        ' > Check child.id and return child
        if child.id = id then return child

    end for

    return invalid

end function


'***** GENERAL USE FUNCTIONS *****

function Pi() as Float

    return 3.1416

end function
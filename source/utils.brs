'***** SCREENS AND LAYOUTS *****

sub CenteringLayout(node as Object)

    ? "CenteringLayout()"

    node.translation = [0, 0]
    
    coordenates = node.boundingRect()
    
    if coordenates.x <> 0 OR coordenates.y <> 0 then node.translation = [-coordenates.x, -coordenates.y]
    
end sub


sub SetScreenDimensions (node as Object, widthFactor as Float, heightFactor as Float)
    
    ? "MasterScreeen - SetScreenDimensions()"
    
    screenDimensions = CreateObject("roDeviceInfo").GetDisplaySize()
    screenWidth = screenDimensions.w
    screenHeight = screenDimensions.h
    
    
    node.width = screenWidth * widthFactor
    node.height = screenHeight * heightFactor
    
end sub


'***** GENERAL USE FUNCTIONS *****

function Pi() as Float

    return 3.1416

end function
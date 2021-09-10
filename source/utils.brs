'***** SCREENS AND LAYOUTS *****

sub CenteringLayout(node as Object)

    ? "CenteringLayout()"

    node.translation = [0, 0]
    
    coordenates = node.boundingRect()
    
    if coordenates.x <> 0 OR coordenates.y <> 0 then node.translation = [-coordenates.x, -coordenates.y]
    
end sub


'***** GENERAL USE FUNCTIONS *****

function Pi() as Float

    return 3.1416

end function
sub Init()

    m.itemPoster = m.top.FindNode("itemPoster")

end sub

sub OnItemContentChange()
    
    item = m.top.itemContent
    if item <> invalid
        m.itemPoster.uri = item.itemThumbnail
    end if
    
end sub
sub Init()
    
    m.userPoster = m.top.FindNode("userPoster")
    m.userLabel = m.top.FindNode("userLabel")
    
    m.itemFrame = m.top.FindNode("itemFrame")
    
    ? "item boundingRect"
    CenteringLayout(m.itemFrame)
    
end sub


sub OnItemContentChange()
    
    item = m.top.itemContent
    m.userPoster.uri = item.thumbnail
    m.userLabel.text = item.title
    
end sub
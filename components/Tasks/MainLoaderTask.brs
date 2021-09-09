sub init()

    m.top.functionName = "GetContent"
    
end sub


sub GetContent()

    ? "MainLoaderTask - GetContent()"
    
    url = CreateObject("roURLTransfer")
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    url.SetURL(m.top.url)
    
    url = url.GetToString()
    
    rootChildren = []
    
    json = ParseJson(url)
    
    content = CreateObject("RoSGNode","ContentNode")
    
    if json <> invalid
        for each category in json
            
            value = json.Lookup(category)
            
            if Type(value) = "roArray"

                'row = CreateObject("RoSGNode","ContentNode")
                'row.title = category
                'row.children = []
                
                for each item in value
                    
                    itemData = GetData(item)
                    content.AppendChild(itemData)
                    
                end for
            end if
            
            'content.AppendChild(row)
            
        end for
    end if
    
    m.top.content = content
    
end sub


function GetData(item as Object) as Object
    
    itemData = CreateObject("RoSGNode","ContentNode")
    addFields = {}
    
    for each element in item
        
        addFields[element] = item[element]
        
    end for
    
    itemData.AddFields(addFields)
    
    return itemData
    
end function
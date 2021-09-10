sub init()

    ? "MainLoaderTask - Init()"

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
    
    if json <> invalid then content = ParseContent(json)
    
    m.top.content = content
    
end sub


function ParseContent(item as Object) as Object

    ? "MainLoaderTask - ParseContent()"

    data = CreateObject("RoSGNode","ContentNode")
    
    setFields = {}
    addFields = {}
    
    for each element in item
    
        if type(item.Lookup(element)) = "roArray"
            
            components = item.Lookup(element)
            row = CreateObject("RoSGNode", "ContentNode")
            row.Title = element
            
            hasChilds = false
            if type(components[0]) = "roAssociativeArray" then hasChilds = true
            
            if hasChilds
            
                for each component in components 
                    field = ParseContent(component)
                    row.AppendChild(field)
                end for
                
                data.AppendChild(row)
                
            end if
            
        end if
        
        if data.HasField(element)
            setFields[element] = item[element]
        else
            addFields[element] = item[element]
        end if
        
    end for
    
    data.SetFields(setFields)
    data.AddFields(addFields)
    
    return data
    
end function
sub init()

    ? "MainLoaderTask - Init()"

    ' Set functionName to “ProcessContent”
    m.top.functionName = "ProcessContent"
    
end sub


sub ProcessContent()

    ? "MainLoaderTask - ProcessContent()"

    ' json = GetContent()
    json = GetContent()
    
    ' content = CreateObject(“ContentNode”)
    content = CreateObject("RoSGNode","ContentNode")
    
    ' ParseContent(json)
    if json <> invalid then content = ParseContent(json)
    
    ' Set content
    m.top.content = content.GetChild(0)

end sub


function GetContent() as Object

    ? "MainLoaderTask - GetContent()"
    
    ' url = CreateObject(“roURLTransfer”)
    url = CreateObject("roURLTransfer")
    ' Set certificates
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    ' Set URL
    url.SetURL(m.top.url)
    ' Get URL to String
    url = url.GetToString()
    ' ParseJson(url)
    json = ParseJson(url)
    'Return parsed url
    return json
    
end function


function ParseContent(item as Object) as Object

    ? "MainLoaderTask - ParseContent()"

    ' data = CreateObject(“ContentNode”)
    data = CreateObject("RoSGNode","ContentNode")
    
    ' Intialize setFields and addFields
    setFields = {}
    addFields = {}
    
    ' For each element in item: create row content, set title and analize if it has children to ParseContent of each one
    for each element in item
    
        if type(item.Lookup(element)) = "roArray"
            
            components = item.Lookup(element)
            row = CreateObject("RoSGNode", "ContentNode")
            row.Title = element
            
            hasChildren = false
            if type(components[0]) = "roAssociativeArray" then hasChildren = true
            
            if hasChildren
            
                for each component in components 
                    field = ParseContent(component)
                    row.AppendChild(field)
                end for

                ' Append row to data
                data.AppendChild(row)
                
            end if
            
        end if
        
        ' Set and Add Fields
        if data.HasField(element)
            setFields[element] = item[element]
        else
            addFields[element] = item[element]
        end if
        
    end for
    
    data.SetFields(setFields)
    data.AddFields(addFields)
    
    ' Return data
    return data
    
end function
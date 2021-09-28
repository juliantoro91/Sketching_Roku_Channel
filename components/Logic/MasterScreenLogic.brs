function NewScreen(params as Object) as Object

    ? "MasterScreenLogic - NewScreen"

    if params = invalid or not type(params) = "roAssociativeArray" then return invalid
        
    screen = CreateObject("roSGNode", params.name)

    screen.url = params.url

    contentTask = CreateObject("roSGNode", "MainLoaderTask")
    contentTask.url = screen.url
    
    m.screen = screen

    HDScreenWidth = 1280
    HDScreenHeight = 720
    widthFactor = calculateFactor(params.widthFactor, params.widthDefault, HDScreenWidth)
    heightFactor = calculateFactor(params.heightFactor, params.heightDefault, HDScreenHeight)

    screen.widthFactor = widthFactor
    screen.heightFactor = heightFactor
    screen.masterFrameDeviation = [params.Xdeviation, params.Ydeviation]
    screen.visible = false

    contentTask.control = "run"
    contentTask.ObserveField("content", "OnMasterScreenContentChange")

    screen.ObserveField("loadCompleted", "OnLoadedScreen")

    return screen

end function


sub OnMasterScreenContentChange(event as Object)

    ? "MasterScreenLogic - OnMasterScreenContentChange"
    
    content = event.GetData()

    if content <> invalid

       m.screen.content = content
       
       m.screen = invalid
       
    end if

end sub


sub OnLoadedScreen(event as Object)

    ? "MasterScreenLogic - OnLoadedScreen"

    screen = event.GetRoSGNode()

    AddScreen(screen)

end sub


' This function calculates the specific factor to be used in the screen setup
function calculateFactor(factor as Object, default as Object, screen as Object) as Object

    ? "MasterScreenLogic - calculateFactor"

    result = 0

    if not val(factor) > 0
        if val(default) > 0
            result = val(default) / screen
        else
            result = 1
        end if
    else
        result = val(factor)
    end if

    return result

end function
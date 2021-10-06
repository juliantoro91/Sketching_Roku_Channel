function NewScreen(params as Object) as Object

    ? "MasterScreenLogic - NewScreen"

    if params = invalid or not type(params) = "roAssociativeArray" then return invalid
        
    ' screen = CreateObject(params.name)
    screen = CreateObject("roSGNode", params.name)

    screen.url = params.url

    ' contentTask = CreateObject(“MainLoaderT.”)
    contentTask = CreateObject("roSGNode", "MainLoaderTask")
    ' Set contentTask url
    contentTask.url = screen.url
    
    m.screen = screen

    ' Calculate width and height factors
    HDScreenWidth = 1280
    HDScreenHeight = 720
    widthFactor = calculateFactor(params.widthFactor, params.widthDefault, HDScreenWidth)
    heightFactor = calculateFactor(params.heightFactor, params.heightDefault, HDScreenHeight)

    ' Set screen size factors and deviation
    screen.widthFactor = widthFactor
    screen.heightFactor = heightFactor
    screen.masterDeviation = [params.Xdeviation, params.Ydeviation]
    
    ' Set screen as NOT visible
    screen.visible = false

    ' Set screen.fullSizedBackground
    screen.fullSizedBackground = params.fullSizedBackground

    ' RUN contentTask
    contentTask.control = "run"
    ' Set contentTask.content observer
    contentTask.ObserveField("content", "OnMasterScreenContentChange")

    ' Set screen.loadComplete observer
    screen.ObserveField("loadCompleted", "OnLoadedScreen")

    ' Return screen
    return screen

end function


sub OnMasterScreenContentChange(event as Object)

    ? "MasterScreenLogic - OnMasterScreenContentChange"
    
    content = event.GetData()

    ' screen.content = contentTask.content
    if content <> invalid

       m.screen.content = content
       
       m.screen = invalid
       
    end if

end sub


sub OnLoadedScreen(event as Object)

    ? "MasterScreenLogic - OnLoadedScreen"

    ' AddScreen(screen)
    screen = event.GetRoSGNode()

    AddScreen(screen)

end sub


' This function calculates the specific factor to be used in the screen setup
function calculateFactor(factor as Object, default as Object, screen as Object) as Object

    ? "MasterScreenLogic - calculateFactor"

    result = 0

    ' Check if it has a valid factor or use defined default value
    if not val(factor) > 0
        if val(default) > 0
            result = val(default) / screen
        else
            result = 1
        end if
    else
        result = val(factor)
    end if

    ' Return factor
    return result

end function
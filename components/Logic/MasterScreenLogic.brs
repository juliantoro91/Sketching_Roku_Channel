sub NewScreen(params as Object)

    ? "MasterScreenLogic - NewScreen"

    if type(params) = "roAssociativeArray"
        
        screen = CreateObject("roSGNode", params.name)

        screen.url = params.url

        contentTask = CreateObject("roSGNode", "MainLoaderTask")
        contentTask.url = screen.url
        contentTask.control = "run"
        m.screen = screen
        contentTask.ObserveField("content", "OnMasterScreenContentChange")

        HDScreenWidth = 1280
        HDScreenHeight = 720
        widthFactor = calculateFactor(params.widthFactor, params.widthDefault, HDScreenWidth)
        heightFactor = calculateFactor(params.heightFactor, params.heightDefault, HDScreenHeight)

        screen.widthFactor = widthFactor
        screen.heightFactor = heightFactor
        screen.masterFrameDeviation = [params.Xdeviation, params.Ydeviation]
        screen.visible = false
        
        screen.runSetup = true

        AddScreen(screen)

    end if

end sub


' This function calculates the specific factor to be used in the screen setup
function calculateFactor(factor as Object, default as Object, screen as Object) as Object

    ? "MasterScreenLogin - calculateFactor"

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


sub OnMasterScreenContentChange(event as Object)

    ? "MasterScreenLogic - OnMasterScreenContentChange"

    content = event.GetData()

    if content <> invalid

       m.screen.content = content
       m.screen = invalid
       
    end if

end sub
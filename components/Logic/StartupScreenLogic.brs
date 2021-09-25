sub NewStartupScreen()

    ? "StartupScreenLogic - NewStartupScreen"

    params = m.top.screenVariables.startupScreen

    screen = NewScreen(params)

    screen.ObserveField("videoState","OnVideoStateChange")

end sub


sub OnVideoStateChange(event as Object)

    ? "StartupScreenLogic - OnVideoStateChange"

    node = event.getRoSGNode()

    data = event.GetData()

    if not data = "playing"

        node.video.visible = false

        if data = "finished" or "error"

            node.control = "play"

        end if

    else

        node.video.visible = true

    end if

end sub
sub NewStartupScreen()

    ? "StartupScreenLogic - NewStartupScreen"

    ' Load StartupScreen params
    params = m.top.screenVariables.startupScreen

    ' screen = NewScreen(params)
    m.screen = NewScreen(params)

    ' Set animationStarted observer
    m.screen.ObserveField("animationLoaded","OnAnimationLoaded")

end sub


sub OnAnimationLoaded(event as Object)

    ? "StartupScreenLogic - OnAnimationLoaded"
    
    
end sub
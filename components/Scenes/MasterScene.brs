sub Init()

    ? "MasterScene - Init"

    ' ScreenStack array initialization
    m.screenStack = []
    m.top.screenStack = m.screenStack

    ' MasterScene size = MainScene size
    scene = m.top.GetScene()
    m.top.width = scene.width
    m.top.height = scene.height

    ' Layers initialization
    m.layerOne = m.top.findNode("sceneLayerOne")
    m.layerTwo = m.top.findNode("sceneLayerTwo")
    m.top.layerOne = m.layerOne
    m.top.layerTwo = m.layerTwo

    m.layerOne.width = m.top.width
    m.layerOne.height = m.top.height
    m.layerTwo.width = m.top.width
    m.layerTwo.height = m.top.height

    ' Animation initialization
    m.animation = m.top.findNode("transitionAnimation")
    m.interpolator = m.top.findNode("transitionAnimationInterpolator")

    ' Set layers.visible observer
    m.layerOne.ObserveField("visible", "OnChangeChildrenVisibility")
    m.layerTwo.ObserveField("visible", "OnChangeChildrenVisibility")

    ' Set startTransition observer
    m.top.ObserveField("startTransition", "OnTransitionAnimation")

end sub


sub OnChangeChildrenVisibility(event as Object)

    ? "MasterScene - OnChangeChildrenVisibility"

    field = event.GetField()

    if not field = "visible" then return

    data = event.GetData()
    node = event.getRoSGNode()

    ' For each child in layer > Set child visible as layer visible
    for each child in node.GetChildren(-1, 0)

        child.visible = data

    end for

end sub


sub OnTransitionAnimation()

    ? "MasterScene - OnTransitionAnimation"

    if m.top.startTransition

        ' Start animation
        m.animation.control = "start"

        ' Set interpolator.fraction observer
        m.interpolator.ObserveField("fraction", "AnimationChange")

    end if

end sub


sub AnimationChange()

    ' if interpo.fraction > 0.5 and startTransition: / startTranstion set to False / layerOne NOT visible / layerTwo visible
    if m.interpolator.fraction > 0.5 and m.top.startTransition

        ? "MasterScene - AnimationChange"

        m.top.startTransition = false
        m.interpolator.UnObserveField("fraction")

        m.layerOne.visible = false
        m.layerTwo.visible = true

    end if

end sub
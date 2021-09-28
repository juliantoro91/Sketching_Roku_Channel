sub Init()

    ? "MasterScene - Init"

    m.screenStack = []
    m.top.screenStack = m.screenStack

    SetScreenDimensions(m.top, 1, 1)

    m.layerOne = m.top.findNode("sceneLayerOne")
    m.layerTwo = m.top.findNode("sceneLayerTwo")
    m.top.layerOne = m.layerOne
    m.top.layerTwo = m.layerTwo

    m.layerOne.width = m.top.width
    m.layerOne.height = m.top.height
    m.layerTwo.width = m.top.width
    m.layerTwo.height = m.top.height

    m.animation = m.top.findNode("transitionAnimation")
    m.interpolator = m.top.findNode("transitionAnimationInterpolator")

    m.layerOne.ObserveField("visible", "OnChangeChildrenVisibility")
    m.layerTwo.ObserveField("visible", "OnChangeChildrenVisibility")

    m.top.ObserveField("startTransition", "OnTransitionAnimation")

end sub


sub OnChangeChildrenVisibility(event as Object)

    ? "MasterScene - OnChangeChildrenVisibility"

    field = event.GetField()

    if not field = "visible" then return

    data = event.GetData()
    node = event.getRoSGNode()

    for each child in node.GetChildren(-1, 0)

        child.visible = data

    end for

end sub


sub OnTransitionAnimation()

    ? "MasterScene - OnTransitionAnimation"

    if m.top.startTransition

        m.animation.control = "start"

        m.interpolator.ObserveField("fraction", "AnimationChange")

    end if

end sub


sub AnimationChange()

    if m.interpolator.fraction > 0.5 and m.top.startTransition

        ? "MasterScene - AnimationChange"

        m.top.startTransition = false

        m.layerOne.visible = false
        m.layerTwo.visible = true

    end if

end sub
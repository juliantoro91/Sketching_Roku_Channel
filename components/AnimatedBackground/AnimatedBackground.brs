sub Init()

    ? "AnimatedBackground - Init()"
    
    ' Element variables definition
    m.layerOne = m.top.FindNode("backgroundLayerOne")
    m.oldVideo = m.top.FindNode("backgroundOldVideo")
    oldVideo = CreateObject("roSGNode","Video")
    m.oldVideo.appendChild(oldVideo)
    m.oldPoster = m.top.FindNode("backgroundOldPoster")
    m.oldPosterRect = m.top.FindNode("backgroundOldPosterRect")
    
    m.layerTwo = m.top.FindNode("backgroundLayerTwo")
    m.newVideo = m.top.FindNode("backgroundNewVideo")
    newVideo = CreateObject("roSGNode","Video")
    m.newVideo.appendChild(newVideo)
    m.newPoster = m.top.FindNode("backgroundNewPoster")
    m.newPosterRect = m.top.FindNode("backgroundNewPosterRect")
    
    m.shader = m.top.FindNode("backgroundShader")
    m.animation = m.top.FindNode("backgroundAnimation")
    m.interpolator = m.top.FindNode("backgroundAnimationInterpolator")
    m.animationChange = false
    
    m.posterAnimation = m.top.FindNode("backgroundPosterAnimation")
    m.posterInterpolator = m.top.FindNode("backgroundPosterAnimationInterpolator")
    
    ' Observers
    m.top.observeField("content","OnContentChange")
    m.top.observeField("focusedChild","OnFocusChange")
    ? "********** " m.top.focusedChild
    m.interpolator.observeField("fraction","OnSecondAnimation")
    
    ' Screen Setup
    SetScreenDimensions (m.top, 1, 1)
    
    ' Additional settings
    SetChildrenDimensions(m.top)
    
    m.oldPoster.loadWidth = m.oldPoster.width
    m.oldPoster.loadHeight = m.oldPoster.height
    m.newPoster.loadWidth = m.oldPoster.width
    m.newPoster.loadHeight = m.oldPoster.height
    
    ' Timer to control video starts
    m.videoTimer = CreateObject("roSGNode", "Timer")
    m.videoTimer.duration = 3
    m.videoTimer.observeField("fire", "ControlVideoStarts")
    m.isTimerActive = false
    
end sub


sub OnFocusChain()

    ? m.top.hasFocus()
    if m.top.isInFocusChain() then m.newVideo.GetChild(0).SetFocus(true)
    
end sub


sub SetChildrenDimensions(node as Object)

    ? "AnimatedBackground - SetChildrenDimensions()"
    
    for each child in node.GetChildren(node.GetChildCount(),0)
    
        if child.width <> invalid then child.width = node.width
        if child.height <> invalid then child.height = node.height
        
        if child.GetChildCount() > 0 then SetChildrenDimensions(child)
        
    end for

end sub


sub OnContentChange()

    ? "AnimatedBackground - OnContentChange()"
    
    content = m.top.content
    
    m.oldPoster.uri = m.newPoster.uri
    m.oldPosterRect.opacity = m.newPosterRect.opacity
    m.oldVideo.removeChildIndex(0)
    oldVideo =  m.newVideo.GetChild(0)
    oldVideo.reparent(m.oldVideo, false)
    oldVideo.unobserveField("state")
    
    m.layerOne.visible = true
    m.layerTwo.visible = false
    
    m.newPoster.uri = content.thumbnail
    m.newPosterRect.opacity = 1
    newVideo = CreateObject("roSGNode","Video")
    SetVideoContent(newVideo, content)
    m.newVideo.appendChild(newVideo)
    
    newVideo.observeField("state","OnVideoStateChange")
    ? "********** " m.top.focusedChild
    m.animationChange = false
    m.animation.control = "start"
    
end sub


sub SetVideoContent(video as Object, content as Object)

    ? "AnimatedBackground - SetVideoContent()"
    
    videoContent = CreateObject("roSGNode","ContentNode")
    
    videoContent.id = content.id
    videoContent.length = content.videoLength
    videoContent.url = content.videoUrl
    videoContent.streamFormat = content.videoFormat
    
    video.content = videoContent.Clone(true)

end sub


sub OnSecondAnimation()
    
    if m.interpolator.fraction > 0.5 and not m.animationChange
    
        ? "AnimatedBackground - OnSecondAnimation()"
        
        oldVideo = m.oldVideo.GetChild(0)
        oldVideo.control = "stop"
        
        m.layerOne.visible = false
        m.layerTwo.visible = true
    
        newVideo = m.newVideo.GetChild(0)
        newVideo.control = "play"
        
        m.animationChange = true
        
        m.isTimerActive = true
        m.videoTimer.control = "start"

    end if
    
end sub


sub ControlVideoStarts()

    ? "AnimatedBackground - ControlVideoStarts()"
    
    m.isTimerActive = false
    
    m.top.stopVideo = false
    
    newVideo = m.newVideo.GetChild(0)
    newVideo.control = "play"

end sub


sub OnVideoStateChange(event as Object)

    ? "AnimatedBackground - OnVideoStateChange()"
    
    video = event.GetRoSGNode()
    parent = video.GetParent()
    container = parent.GetParent()
    poster = container.GetChild(1)
    
    ? "Event in: ";parent.id;" / ";video.state
    
    if video.state = "playing" or video.state = "paused"
        
        if m.isTimerActive
            
            video.control = "pause"
            
        else
            
            actualOpacity = poster.opacity
            m.posterInterpolator.keyValue = [actualOpacity, 0.0]
            
            if actualOpacity > 0 then m.posterAnimation.control = "start"
            
        end if
        
    else if video.state = "finished" or video.state = "stopped"
        
        actualOpacity = poster.opacity
        m.posterInterpolator.keyValue = [actualOpacity, 1.0]
        
        if actualOpacity < 1 then m.posterAnimation.control = "start"
        
        m.top.hideMasterFrame = false
        
    end if
    
end sub


sub OnStopsVideo()

    ? "AnimatedBackground - OnStopsVideo()"
    
    if m.top.stopVideo
    
        newVideo = m.newVideo.GetChild(0)
        newVideo.control = "stop"
        
    end if
    
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean

    result = false
    
    if press
        if key="back"
            
            m.top.hideMasterFrame = false
            result = true
            
        else if key="OK"
            
            newVideo = m.newVideo.GetChild(0)
            
            if newVideo.state = "playing"
                newVideo.control = "pause"
            else
                newVideo.control = "resume"
            end if
            
            result = true
            
        end if
    end if
    
    return result
    
end function


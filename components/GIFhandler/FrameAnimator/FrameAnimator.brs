sub init()
    m.animator = CreateObject("roSGNode", "Timer")
    m.animator.ObserveField("fire", "displayNextFrame")
    m.animator.repeat = true
  
    m.frames = []
    m.frameIndex = -1
    m.poster = invalid
  end sub
  
  function start(frames as Object, fps as Float, poster as Object)
    m.frames = frames
    m.poster = poster
  
    m.animator.duration = fps
    'm.animator.duration = 0.25
    m.animator.control = "start"
  end function
  
  function finish()
    m.animator.control = "stop"
  
    ' Restore first frame
    if m.frames.count() > 0 m.poster.uri = m.frames[0]
  
    m.frameIndex = -1
    m.frames = []
    m.poster = invalid
  end function
  
  sub displayNextFrame()
    m.frameIndex++
    if m.frameIndex >= 61
      m.frameIndex = 0
    end if
    index = m.frameIndex + 1
    uri = StrI(index)
    uri = Right(uri, Len(uri)-1)
    if index < 10
      uri = "00"+uri
    else
      uri = "0"+uri
    end if
    uri = "pkg:/images/test/ezgif-frame-"+uri+".png"
    m.poster.uri = uri
    ? "f: ";uri
  end sub
' Code taked from https://medium.com/float-left-insights/how-to-display-animated-gifs-on-roku-using-scenegraph-4adec93ffa2d
sub Init()

  ? "FrameAnimator - Init"

  'animator = CreateObject(“Timer”)
  m.animator = CreateObject("roSGNode", "Timer")
  m.animator.repeat = true

  'Set animator.fire observer
  m.animator.ObserveField("fire", "displayNextFrame")

  ' Initialize frames, frameIndex and poster
  m.frames = []
  m.frameIndex = -1
  m.poster = invalid

end sub


function Start(frames as Object, fps as Float, poster as Object)

  ? "FrameAnimator - Start"

  ' Set Frames, poster, duration
  m.frames = frames
  m.poster = poster

  m.animator.duration = fps

  ' Start animator
  m.animator.control = "start"

end function


function Finish()

  ? "FrameAnimator - Finish"

  ' Stop animator
  m.animator.control = "stop"

  ' Restore first frame
  if m.frames.count() > 0 m.poster.uri = m.frames[0]

  ' Reset frames, frameIndex and Poster
  m.frameIndex = -1
  m.frames = []
  m.poster = invalid

end function


sub DisplayNextFrame()

  '? "FrameAnimator - DisplayNextFrame"

  ' Increase frameIndex
  m.frameIndex++

  ' if frameIndex > frames.count(): > frameIndex = 0 > if not loaded: >> loaded set to TRUE
  if m.frameIndex > m.frames.count() - 1

    m.frameIndex = 0

    if not m.top.loaded then m.top.loaded = true

  end if

  ' Set poster.uri usign frames and frameIndex
  m.poster.uri = m.frames[m.frameindex]
  
end sub
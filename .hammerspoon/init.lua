hs.window.animationDuration = 0

layoutUnits = {
  rightHalf = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  leftHalf = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  fullScreen = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
  rightThird = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  leftTwoThirds = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  topRightQuarter = { x = 0.70, y = 0.00, w = 0.30, h = 0.50 },
  bottomRightQuarter = { x = 0.70, y = 0.50, w = 0.30, h = 0.50 }
}

function bindHotKey(modifiers, key, action)
  hs.hotkey.bind(modifiers, key, action)
end

function moveTo(unit)
  return function()
    hs.window.focusedWindow():move(unit, nil, true)
  end
end

function moveToBottomHalfKeepingWidth()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screenFrame = win:screen():frame()
  win:setFrame({
    x = frame.x,
    y = screenFrame.y + screenFrame.h * 0.50,
    w = frame.w,
    h = screenFrame.h * 0.50
  }, 0)
end

function toggleAppVisibility(appName, appPath)
  return function()
    local app = hs.application.find(appName)
    if app and app:isFrontmost() then
      app:hide()
    else
      hs.application.launchOrFocus(appPath)
    end
  end
end

hotKeyBindings = {
  { { 'ctrl', 'command' }, 'right', moveTo(layoutUnits.rightHalf) },
  { { 'ctrl', 'command' }, 'left', moveTo(layoutUnits.leftHalf) },
  { { 'ctrl', 'command' }, 'up', moveTo(layoutUnits.fullScreen) },
  { { 'ctrl', 'command' }, 'down', moveToBottomHalfKeepingWidth },

  { { 'ctrl', 'shift', 'command' }, 'right', moveTo(layoutUnits.rightThird) },
  { { 'ctrl', 'shift', 'command' }, 'left', moveTo(layoutUnits.leftTwoThirds) },
  { { 'ctrl', 'shift', 'command' }, 'up', moveTo(layoutUnits.topRightQuarter) },
  { { 'ctrl', 'shift', 'command' }, 'down', moveTo(layoutUnits.bottomRightQuarter) },

  { { 'ctrl' }, 'q', toggleAppVisibility('Warp', '/Applications/Warp.app') },
  { { 'ctrl' }, 'e', toggleAppVisibility('Finder', '/System/Library/CoreServices/Finder.app') }
}

for _, binding in ipairs(hotKeyBindings) do
  bindHotKey(binding[1], binding[2], binding[3])
end

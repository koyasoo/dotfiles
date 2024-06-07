
hs.window.animationDuration = 0
units = {
  right       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top         = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
  bot         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  sright      = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  sleft       = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  stop        = { x = 0.70, y = 0.00, w = 0.30, h = 0.50 },
  sbot        = { x = 0.70, y = 0.50, w = 0.30, h = 0.50 }
}

mash = { 'ctrl', 'command' }
hs.hotkey.bind(mash, 'right', function() 
  hs.window.focusedWindow():move(units.right, nil, true) 
end
)
hs.hotkey.bind(mash, 'left', function() 
  hs.window.focusedWindow():move(units.left, nil, true) 
end
)
hs.hotkey.bind(mash, 'up', function() 
  hs.window.focusedWindow():move(units.top, nil, true) 
end
)
hs.hotkey.bind(mash, 'down', function() 
  hs.window.focusedWindow():move(units.bot, nil, true) 
end
)
mash = { 'ctrl', 'shift', 'command' }
hs.hotkey.bind(mash, 'right', function() 
  hs.window.focusedWindow():move(units.sright, nil, true) 
end
)
hs.hotkey.bind(mash, 'left', function() 
  hs.window.focusedWindow():move(units.sleft, nil, true) 
end
)
hs.hotkey.bind(mash, 'up', function() 
  hs.window.focusedWindow():move(units.stop, nil, true) 
end
)
hs.hotkey.bind(mash, 'down', function() 
  hs.window.focusedWindow():move(units.sbot, nil, true) 
end
)
hs.hotkey.bind({'ctrl'}, 'q', function()
  local warp = hs.application.find('Warp')
  if warp:isFrontmost() then
    warp:hide()
  else
    hs.application.launchOrFocus('/Applications/Warp.app')
  end
end
)
hs.hotkey.bind({'ctrl'}, 'e', function()
  local finder = hs.application.find('Finder')
  if finder:isFrontmost() then
    finder:hide()
  else
    hs.application.launchOrFocus('/System/Library/CoreServices/Finder.app')
  end
end
)
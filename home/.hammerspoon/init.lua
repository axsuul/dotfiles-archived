-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")
hyper = {'cmd', 'ctrl', 'shift', 'alt'}

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
  -- hs.alert.show('in')
end

-- Passthrough
hyper_keys = {
  'a', 
  'w', 
  'x', 
  'd', 
  't',
  'c',
  'v',
  'tab',
  '`'
}

for i, key in pairs(hyper_keys) do
  passthrough = function()
    hs.eventtap.keyStroke(hyper, key)
    k.triggered = true
  end
  -- Uncomment line below when binding new
  -- k:bind({}, key, nil, passthrough, passthrough)
  k:bind({}, key, passthrough, nil, nil)
end

-- Applications
apps = {
  {'b', 'Google Chrome'},
  {'e', 'Evernote'},
  {'f', 'Finder'},
  {'g', 'Telegram'},
  {'h', 'Google Hangouts'},
  {'k', 'Slack'},
  {'m', 'iTerm2'},
  {'o', 'Todoist'},
  {'p', 'Spotify'},
  {'l', 'Airmail 3'}
}

for i, app in ipairs(apps) do
  launchapp = function()
    hs.application.launchOrFocus(app[2])
    k.triggered = true
  end

  k:bind({}, app[1], launchapp, nil, nil) 
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  -- hs.alert.show('out')
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- Reload config when any lua file in config directory changes
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == '.lua' then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
        print('reloaded')
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")
hyper = {'cmd', 'ctrl', 'shift', 'alt'}

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  print('F18 Pressed')
  k.triggered = false
  k.modifier = false
  k:enter()

  trigger_modifier = function()
    k.modifier = true
  end

  -- Only trigger as modifier if held longer than thisj
  hs.timer.doAfter(0.25, trigger_modifier)
  -- hs.alert.show('in')
end

-- https://github.com/Hammerspoon/hammerspoon/issues/1011#issuecomment-261114434
-- Necessary to define a new function to get faster key strokes for repeating
fastKeyStroke = function(modifiers, key)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(key), true):post()
  event.newKeyEvent(modifiers, string.lower(key), false):post()

  k.triggered = true
end

-- Passthrough
passthrough_definitions = {
  -- 1Password
  {hyper, '1'},

  -- Alfred
  {hyper, 'v'},

  -- Fantastical
  {hyper, 'c'},

  -- macOS Sidebar
  {hyper, '\\'},

  -- Moom
  {hyper, 'a'},
  {hyper, 's'},
  {hyper, 'd'},
  {hyper, 'tab'},
  {hyper, '9'},
  {hyper, '0'},

  -- Alfred
  {hyper, 'space'},
}

for i, definition in pairs(passthrough_definitions) do
  -- Note that Lua copies by reference so assigning variable doesn't work
  -- modifier is definition[1]
  -- key is definition[2]

  passthrough = function()
    print('Triggering passthrough: hyper + ' .. definition[2])

    fastKeyStroke(definition[1], definition[2])
    -- k.triggered = true
  end

  -- Uncomment line below when binding new
  k:bind({}, definition[2], passthrough, nil, nil)
end

-- Applications
apps = {
  {';', 'Discord'},
  {'/', 'Intercom'},
  {'b', 'Safari'},
  {'e', 'Evernote'},
  {'f', 'Finder'},
  {'g', 'Telegram'},
  {'i', 'Polymail'},
  {'m', 'Sublime Text'},
  {'n', 'iTerm'},
  {'o', 'com.culturedcode.ThingsMac', true},
  {'p', 'Spotify'},
  {'r', 'Google Chrome'},
  {'t', 'Google Translate'},
  {'u', 'Slack'},
  {'w', 'Bear'},
  {'x', 'Messages'},
  {'y', 'WhatsApp'},
}

for i, app in ipairs(apps) do
  launchApplication = function()
    -- Third argument is if we need to go by Bundle ID. Some apps seem to only work by targeting the Bundle ID instead
    if app[3] then
      hs.application.launchOrFocusByBundleID(app[2])
    else
      hs.application.launchOrFocus(app[2])
    end

    k.triggered = true
  end

  k:bind({}, app[1], launchApplication, nil, nil)
end

-- function onAppLaunched(appName, eventType, app)
--   if eventType == hs.application.watcher.launched then
--     if appName == 'Firefox' then
--       browser = 'Firefox'
--       safariPid = app:pid()

--       print("Firefox launched, setting browser to Firefox with PID " .. safariPid)
--     end
--   elseif eventType == hs.application.watcher.terminated then
--     if app:pid() == safariPid then
--       browser = 'Google Chrome'
--       safariPid = nil

--       print("Application with PID " .. safariPid .. " matching Safari terminated, setting browser to Google Chrome")
--     end
--   end
-- end

-- Open specific browser depending on what's open
-- appWatcher = hs.application.watcher.new(onAppLaunched)
-- appWatcher:start()

-- Arrow key bindings. Capslock must be held down first before the other modifiers for these to trigger
hs.fnutils.each({
  -- basic arrow key movement
  { modifiers={}, key='h', direction='Left' },
  { modifiers={}, key='j', direction='Down' },
  { modifiers={}, key='k', direction='Up' },
  { modifiers={}, key='l', direction='Right' },

  -- shift + arrow key movement
  { modifiers={'shift'}, key='h', direction='Left' },
  { modifiers={'shift'}, key='j', direction='Down' },
  { modifiers={'shift'}, key='k', direction='Up' },
  { modifiers={'shift'}, key='l', direction='Right' },

  -- option + arrow key movement
  { modifiers={'option'}, key='h', direction='Left' },
  { modifiers={'option'}, key='j', direction='Down' },
  { modifiers={'option'}, key='k', direction='Up' },
  { modifiers={'option'}, key='l', direction='Right' },

  -- option + cmd + arrow key movement
  { modifiers={'option', 'cmd'}, key='h', direction='Left' },
  { modifiers={'option', 'cmd'}, key='j', direction='Down' },
  { modifiers={'option', 'cmd'}, key='k', direction='Up' },
  { modifiers={'option', 'cmd'}, key='l', direction='Right' },

  -- option + shift + arrow key movement
  { modifiers={'option', 'shift'}, key='h', direction='Left' },
  { modifiers={'option', 'shift'}, key='j', direction='Down' },
  { modifiers={'option', 'shift'}, key='k', direction='Up' },
  { modifiers={'option', 'shift'}, key='l', direction='Right' },

  -- cmd + arrow key movement
  { modifiers={'cmd'}, key='h', direction='Left' },
  { modifiers={'cmd'}, key='j', direction='Down' },
  { modifiers={'cmd'}, key='k', direction='Up' },
  { modifiers={'cmd'}, key='l', direction='Right' },

  -- cmd + shift + arrow key movement
  { modifiers={'cmd', 'shift'}, key='h', direction='Left' },
  { modifiers={'cmd', 'shift'}, key='j', direction='Down' },
  { modifiers={'cmd', 'shift'}, key='k', direction='Up' },
  { modifiers={'cmd', 'shift'}, key='l', direction='Right' },

  -- ctrl + shift + arrow key movement
  { modifiers={'ctrl', 'shift'}, key='h', direction='Left' },
  { modifiers={'ctrl', 'shift'}, key='j', direction='Down' },
  { modifiers={'ctrl', 'shift'}, key='k', direction='Up' },
  { modifiers={'ctrl', 'shift'}, key='l', direction='Right' }
}, function(config)
  k:bind(config.modifiers, config.key,
    function() fastKeyStroke(config.modifiers, config.direction) end,
    nil,
    function() fastKeyStroke(config.modifiers, config.direction) end
  )
end)

-- k:bind({'shift'}, 'k', function() fastKeyStroke({'shift'}, 'Up') end, fastKeyStroke({'shift'}, 'Up'), nil)
-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()

  if not k.triggered then
    -- If hotkey held longer than this amount of time
    -- let it remain as modifier and don't send ESCAPE
    if not k.modifier then
      hs.eventtap.keyStroke({}, 'ESCAPE')
    else
      print("Modifier detected")
    end
  end
end

-- Bind the Hyper key
hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- Bind so that modifiers can be pressed first before Hyper
-- key for combinations
hs.hotkey.bind({'shift'}, 'F18', pressedF18, releasedF18)
hs.hotkey.bind({'cmd'}, 'F18', pressedF18, releasedF18)

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

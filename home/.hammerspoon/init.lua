-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")
hyper = {'cmd', 'ctrl', 'shift', 'alt'}

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
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

-- Passthrough
hyper_keys = {
  -- 1Password
  '1',

  -- Moom
  'a', 'w', 'x', 'd', 's', 'tab', '9', '0',

  -- Alfred
  'v',

  -- macOS Sidebar
  '\\',

  -- TextExpander
  's',

  'c',
  '`',
  '-',
  '=',
}

passthrough_definitions = {
  -- 1Password
  {hyper, '1'},

  -- Moom
  {hyper, 'a'},
  {hyper, 'w'},
  {hyper, 'x'},
  {hyper, 'd'},
  {hyper, 's'},
  {hyper, 'tab'},
  {hyper, '9'},
  {hyper, '0'},

  -- Alfred
  {hyper, 'v'},

  -- macOS Sidebar
  {hyper, '\\'},

  -- Mate Translate
  {hyper, 't'},

  -- TextExpander
  {hyper, '`'},

  -- Finder
  {hyper, 'c'},

  -- Anki
  {hyper, '='},

  -- ??
  {hyper, '-'},
}

for i, definition in pairs(passthrough_definitions) do
  -- Note that Lua copies by reference so assigning variable doesn't work
  -- modifier is definition[2]
  -- key is definition[2]

  passthrough = function()
    hs.eventtap.keyStroke(definition[1], definition[2])
    k.triggered = true
  end

  -- Uncomment line below when binding new
  k:bind({}, definition[2], passthrough, nil, nil)
end

-- Applications
apps = {
  {'e', 'Evernote'},
  {'r', 'Bear'},
  {'y', 'WhatsApp'},
  {'u', 'Slack'},
  {'i', 'Polymail'},
  {'o', 'Todoist'},
  {'p', 'Spotify'},
  {'f', 'Finder'},
  {'g', 'Telegram'},
  {';', 'Discord'},
  {'n', 'iTerm2'},
  {'m', 'Sublime Text'},
  {'=', 'Anki'},
}

for i, app in ipairs(apps) do
  launchApplication = function()
    hs.application.launchOrFocus(app[2])
    k.triggered = true
  end

  k:bind({}, app[1], launchApplication, nil, nil)
end

-- Default browser
browser = 'Google Chrome'
safariPid = nil

function onAppLaunched(appName, eventType, app)
  if eventType == hs.application.watcher.launched then
    if appName == 'Firefox' then
      browser = 'Firefox'
      safariPid = app:pid()

      print("Firefox launched, setting browser to Firefox with PID " .. safariPid)
    end
  elseif eventType == hs.application.watcher.terminated then
    if app:pid() == safariPid then
      browser = 'Google Chrome'
      safariPid = nil

      print("Application with PID " .. safariPid .. " matching Safari terminated, setting browser to Google Chrome")
    end
  end
end

-- Open specific browser depending on what's open
appWatcher = hs.application.watcher.new(onAppLaunched)
appWatcher:start()

launchBrowser = function()
  hs.application.launchOrFocus(browser)
  k.triggered = true
end

k:bind({}, 'b', launchBrowser, nil, nil)

-- https://github.com/Hammerspoon/hammerspoon/issues/1011#issuecomment-261114434
-- Necessary to define a new function to get faster key strokes for repeating
fastKeyStroke = function(modifiers, key)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(key), true):post()
  event.newKeyEvent(modifiers, string.lower(key), false):post()

  k.triggered = true
end

-- Arrow keys
hs.fnutils.each({
  { modifiers={}, key='h', direction='Left' },
  { modifiers={'shift'}, key='h', direction='Left' },
  { modifiers={'cmd'}, key='h', direction='Left' },
  { modifiers={'shift', 'cmd'}, key='h', direction='Left' },
  { modifiers={}, key='j', direction='Down' },
  { modifiers={'shift'}, key='j', direction='Down' },
  { modifiers={'cmd'}, key='j', direction='Down' },
  { modifiers={'shift', 'cmd'}, key='j', direction='Down' },
  { modifiers={}, key='k', direction='Up' },
  { modifiers={'shift'}, key='k', direction='Up' },
  { modifiers={'cmd'}, key='k', direction='Up' },
  { modifiers={'shift', 'cmd'}, key='k', direction='Up' },
  { modifiers={}, key='l', direction='Right' },
  { modifiers={'shift'}, key='l', direction='Right' },
  { modifiers={'cmd'}, key='l', direction='Right' },
  { modifiers={'shift', 'cmd'}, key='l', direction='Right' }
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

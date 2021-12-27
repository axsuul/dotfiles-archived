-- Set global variable for hyper mode
hyperMode = hs.hotkey.modal.new({}, 'F17')

reloadConfig = function(files)
  isConfigReloaded = false

  for _,file in pairs(files) do
    if file:sub(-4) == '.lua' then
      isConfigReloaded = true
    end
  end

  if isConfigReloaded then
    hs.reload()

    print('Config reloaded')
  end
end

-- Trigger a key stroke that can be repeated without delay
triggerFastKeyStroke = function(modifiers, key)
  hs.eventtap.keyStroke(modifiers, string.lower(key), 0)

  hyperMode.isActive = true
end

enterHyperMode = function()
  print('Hyper mode: entered')

  hyperMode.isActive = false
  hyperMode.actsAsModifier = false
  hyperMode:enter()

  triggerHyperModeActsAsModifier = function()
    hyperMode.actsAsModifier = true
  end

  -- Only trigger as modifier if held longer than this amount of time
  hs.timer.doAfter(0.25, triggerHyperModeActsAsModifier)
end

leaveHyperMode = function()
  hyperMode:exit()

  if not hyperMode.isActive then
    if not hyperMode.actsAsModifier then
      -- send ESCAPE key if not meant to act as modifier
      hs.eventtap.keyStroke({}, 'ESCAPE')

      print('Hyper mode: acted as ESCAPE')
    else
      print('Hyper mode: acted as modifier')
    end
  end

  print('Hyper mode: left')
end

-- Support hyper modifier bindings which trigger as cmd + ctrl + shift + alt + {key}
hyperModifierKey = {'cmd', 'ctrl', 'shift', 'alt'}
hyperModifierBindings = {
  -- 1Password
  {hyperModifierKey, '1'},

  -- Alfred
  {hyperModifierKey, 'space'},
  {hyperModifierKey, 'v'},

  -- Fantastical
  {hyperModifierKey, 'c'},

  -- macOS Notification Center
  {hyperModifierKey, '\\'},

  -- Moom
  {hyperModifierKey, 'a'},
  {hyperModifierKey, 's'},
  {hyperModifierKey, 'd'},
  {hyperModifierKey, 'tab'},
  {hyperModifierKey, '9'},
  {hyperModifierKey, '0'},
}

for i, binding in pairs(hyperModifierBindings) do
  -- Note that Lua copies by reference so assigning variable doesn't work
  -- modifier is binding[1]
  -- key is binding[2]
  triggerHyperBindings = function()
    print('Triggering hyper modifier + ' .. binding[2])

    triggerFastKeyStroke(binding[1], binding[2])
  end

  hyperMode:bind({}, binding[2], triggerHyperBindings, nil, nil)
end

-- For launching/showing applications based on hyper mode key bindings
hyperModeApplicationBindings = {
  {';', 'Discord'},
  {'/', 'Intercom'},
  {'b', 'Safari'},
  {'e', 'Notes'},
  {'f', 'Finder'},
  {'g', 'Telegram'},
  {'i', 'Polymail'},
  {'m', 'Visual Studio Code'},
  {'n', 'iTerm'},
  {'o', 'com.culturedcode.ThingsMac', true},
  {'p', 'Spotify'},
  {'r', 'Google Chrome'},
  {'t', 'DeepL'},
  {'u', 'Slack'},
  {'w', 'Bear'},
  {'x', 'Messages'},
  {'y', 'WhatsApp'},
}

for i, binding in ipairs(hyperModeApplicationBindings) do
  launchApplication = function()
    print('Launching or focusing ' .. binding[2])

    -- Third argument is if we need to go by Bundle ID. Some apps seem to only work by targeting the Bundle ID instead
    if binding[3] then
      hs.application.launchOrFocusByBundleID(binding[2])
    else
      hs.application.launchOrFocus(binding[2])
    end

    hyperMode.isActive = true
  end

  hyperMode:bind({}, binding[1], launchApplication, nil, nil)
end

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
  hyperMode:bind(config.modifiers, config.key,
    function() triggerFastKeyStroke(config.modifiers, config.direction) end,
    nil,
    function() triggerFastKeyStroke(config.modifiers, config.direction) end
  )
end)

-- Enter hyper mode when F18 (should be mapped using hidutil) is pressed
hs.hotkey.bind({}, 'F18', enterHyperMode, leaveHyperMode)

-- Bind so that modifiers can also be pressed first before entering hyper mode for combinations
hs.hotkey.bind({'cmd'}, 'F18', enterHyperMode, leaveHyperMode)
hs.hotkey.bind({'ctrl'}, 'F18', enterHyperMode, leaveHyperMode)
hs.hotkey.bind({'option'}, 'F18', enterHyperMode, leaveHyperMode)
hs.hotkey.bind({'shift'}, 'F18', enterHyperMode, leaveHyperMode)

-- Reload config when any lua file in config directory changes
hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()

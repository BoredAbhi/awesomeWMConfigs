local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')

-- Theme
beautiful.init(require('theme'))

-- Init all modules
require('module.notifications')
require('module.auto-start')
require('module.decorate-client')
require('module.backdrop')
require('module.panel')
require('module.exit-screen')

-- Setup all configurations
require('conf.client')
require('conf.tags')
_G.root.keys(require('conf.keys.global'))

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
  function(s)
    -- If wallpaper is a function, call it with the screen
    gears.wallpaper.set(beautiful.wallpaper, 1, true)
  end
)

-- Signal function to execute when a new client appears.
_G.client.connect_signal(
  'manage',
  function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not _G.awesome.startup then
      awful.client.setslave(c)
    end

    if _G.awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

-- Enable sloppy focus, so that focus follows mouse.

_G.client.connect_signal(
  'mouse::enter',
  function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = true})
  end
)

_G.client.connect_signal(
  'focus',
  function(c)
    c.border_color = beautiful.border_focus
  end
)
_G.client.connect_signal(
  'unfocus',
  function(c)
    c.border_color = beautiful.border_normal
  end
)

--My Auto Start Apps :
do
  local cmds =
  {
    "redshift-gtk -l 12.97:77.59",
    "feh --randomize --bg-fill /home/awbhijeet/Pictures/Light_Minimal",
    "udiskie -nT"
  }

  for _,i in pairs(cmds) do
    awful.util.spawn(i)
  end
end


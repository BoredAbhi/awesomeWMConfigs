local wibox = require('wibox')
local mat_list_item = require('widgets.mat-list-item')
local mat_slider = require('widgets.mat-slider')
local mat_icon_button = require('widgets.mat-icon-button')
local clickable_container = require('widgets.clickable-container')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local spawn = require('awful.spawn')

local slider =
  wibox.widget {
  read_only = false,
  widget = mat_slider
}

slider:connect_signal(
  'property::value',
  function()
    spawn('light -S ' .. math.max(slider.value, 1))
  end
)

watch(
  [[bash -c "light -G"]],
  1,
  function(widget, stdout, stderr, exitreason, exitcode)
    local brightness = string.match(stdout, '(%d+)')

    slider:set_value(tonumber(brightness))
  end
)

local icon =
  wibox.widget {
  image = icons.brightness,
  widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local brightness_setting =
  wibox.widget {
  button,
  slider,
  widget = mat_list_item
}

return brightness_setting

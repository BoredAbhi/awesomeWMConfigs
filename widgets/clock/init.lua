-------------------------------------------------
-- My Clock Widget
-------------------------------------------------

local awful = require('awful')
local naughty = require('naughty')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widgets.clickable-container')
local gears = require('gears')
-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv('HOME')
--local PATH_TO_ICONS = HOME .. '/.config/awesome/widgets/battery/icons/'
--
--widget = textclock
--widget_button = clock_widget
--
local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 11">%H\n%M</span>')
local clock_widget = wibox.container.margin(textclock, 13, 13, 8, 8)

clock_widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn('/home/awbhijeet/Webapps/google-calendar-sign-in-linux-x64/google-calendar-sign-in')
            end
        )
    )
)

return widget_button

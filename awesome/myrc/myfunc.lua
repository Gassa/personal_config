local naughty = require("naughty")
local awful = require("awful")

function gradient(min, max, val)
  if (val > max) then val = max end
  if (val < min) then val = min end

  local v = val - min
  local d = (max - min) * 0.5
  local red, green

  if (v <= d) then
    red = (255 * v) / d
    green = 255
  else
    red = 255
    green = 255 - (255 * (v-d)) / (max - min - d)
  end

  return string.format("#%02x%02x00", green, red)
end

function run_once(cmd)
   findme = cmd
   firstspace = cmd:find(" ")
   if firstspace then
      findme = cmd:sub(0, firstspace-1)
   end
   awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

function repeat_every(func, seconds)
   func()
   local t = timer({ timeout = seconds })
   t:connect_signal("timeout", func)
   t:start()
end

function os.capture(cmd, raw)
   local f = assert(io.popen(cmd, 'r'))
   local s = assert(f:read('*a'))
   f:close()
   if raw then return s end
   s = string.gsub(s, '^%s+', '')
   s = string.gsub(s, '%s+$', '')
   s = string.gsub(s, '[\n\r]+', ' ')
   return s
end


function delay_raise()
   -- 5 ms ages in computer time, but I won't notice it.
   local raise_timer = timer { timeout = 0.005 }
   raise_timer:connect_signal("timeout",
             function()
                if client.focus then
                   client.focus:raise()
                end
                raise_timer:stop()
   end)
   raise_timer:start()
end

function debug_print(where, msg)
    naughty.notify { text = where ..":" .. msg, 
                     timeout = 5, hover_timeout = 0.5 }
end                     

local mod = "SUPER"
hl.bind(mod .. " + C", hl.dsp.window.close({}))
hl.bind(mod .. " + M", hl.dsp.exit())
hl.bind(mod .. " + P", hl.dsp.window.pseudo({}))
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

for key, dir in pairs({ LEFT = "l", RIGHT = "r", UP = "u", DOWN = "d", A = "l", D = "r", W = "u", S = "d" }) do
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i), follow = true }))
end

for key, shift in pairs({ A = "-1", LEFT = "-1", D = "+1", RIGHT = "+1" }) do
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.focus({ workspace = shift }))
    hl.bind(mod .. " + SHIFT + CTRL + " .. key, hl.dsp.window.move({ workspace = shift, follow = true }))
end
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "-1" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Old bindel = repeating + locked; bindl = locked.
local repeat_locked = { repeating = true, locked = true }
local locked = { locked = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), repeat_locked)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeat_locked)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), repeat_locked)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeat_locked)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), repeat_locked)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), repeat_locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
hl.bind("F11", hl.dsp.window.fullscreen({}))

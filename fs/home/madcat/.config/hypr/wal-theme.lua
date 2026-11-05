-- Adapter for Pywal's legacy .conf output, shared with hyprlock.
-- Read on each Hyprland Lua configuration reload so Pywal stays the source of truth.
local base = (os.getenv("HOME") or "/home/madcat") .. "/.config/hypr/"
local palette = {}
local file, err = io.open(base .. "wal-theme.conf", "r")
if not file then error("Cannot open wal-theme.conf: " .. tostring(err)) end
for line in file:lines() do
    local name, value = line:match("^%s*%$([%w_]+)%s*=%s*(.-)%s*$")
    if name and value then palette[name] = value end
end
file:close()
assert(palette.color8 and palette.color15, "Missing required Pywal colors in wal-theme.conf")
return palette

local base = (os.getenv("HOME") or "/home/madcat") .. "/.config/hypr/modules/submaps/scripts/"
hl.bind("SUPER + ALT + K", hl.dsp.submap("refresh"))
hl.define_submap("refresh", function()
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("SUPER + W", hl.dsp.exec_cmd(base .. "refresh.waybar.sh"))
    hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd(base .. "refresh.waybar.sh 1"))
    hl.bind("SUPER + I", hl.dsp.exec_cmd(base .. "refresh.hypridle.sh"))
end)

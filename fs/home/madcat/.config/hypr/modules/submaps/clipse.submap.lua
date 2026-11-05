local base = (os.getenv("HOME") or "/home/madcat") .. "/.config/hypr/"
hl.bind("SUPER + V", hl.dsp.exec_cmd("alacritty --class clipse -e 'clipse'"))
hl.bind("SUPER + V", hl.dsp.submap("clipse"))
hl.define_submap("clipse", function()
    hl.bind("RETURN", hl.dsp.pass({ window = "class:clipse" }))
    hl.bind("RETURN", hl.dsp.focus({ last = true })) -- old focuscurrentorlast
    hl.bind("RETURN", hl.dsp.exec_cmd("sleep 0.01 && " .. base .. "modules/submaps/scripts/clipse-auto-paste.sh"))
    hl.bind("escape", hl.dsp.pass({ window = "class:clipse" }))
    hl.bind("Q", hl.dsp.pass({ window = "class:clipse" }))
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("Q", hl.dsp.submap("reset"))
    hl.bind("RETURN", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + ALT + S", hl.dsp.submap("moveWindow"))
hl.define_submap("moveWindow", function()
    hl.bind("escape", hl.dsp.submap("reset"))
    for key, dir in pairs({ A = "l", D = "r", W = "u", S = "d" }) do
        hl.bind(key, hl.dsp.window.move({ direction = dir }))
    end
end)

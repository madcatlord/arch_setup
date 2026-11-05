# Hyprland 0.57 migration

The Hyprland compositor config was migrated to `hyprland.lua` and modular `.lua` files.
`hyprlock.conf` and `hypridle.conf` **remain .conf**: these tools still use hyprlang.
`wal-theme.conf` also remains so that hyprlock and the Pywal theme producer can use it; `wal-theme.lua` is an adapter that reads its current values on Hyprland config reload.

## Install

1. Back up `~/.config/hypr` before replacing any files.
2. Copy the contents of the `hypr/` directory to `~/.config/hypr/`, preserving executable permissions on scripts.
3. Start Hyprland 0.57. The compositor loads `hyprland.lua` automatically.
4. Run `hyprctl configerrors`, inspect `hyprctl binds`, test submaps, monitor positions, screenshot and lock screen. Check the console/log if anything fails.
5. After updating colors with Pywal, run `hyprctl reload` to re-read `wal-theme.conf` in Hyprland; hyprlock continues to read `.conf`.

## Caveats

* This migration was checked against the 0.57 online documentation and Lua parser, not a live Hyprland 0.57 session.
* The old `focuscurrentorlast` dispatcher used by clipse is approximated using `hl.dsp.focus({last=true})` (not guaranteed exactly equivalent).
* The legacy `hyprctl dispatch ...` invocation format changed; active helper scripts were migrated.
* The original `wal-theme.conf` is read as plaintext by the Lua adapter; keep its current `$name = value` format.
* The user-supplied `wal-theme.conf` path is hard-coded; the theme and script locations still assume the original home and executable paths.
* With the new focus and submap Lua API, test `SUPER+V` / Enter / Escape carefully before relying on clipboard autopaste.
* `hypridle` and `hyprlock` are not Hyprland compositor Lua configurations, so keeping them in their supported legacy formats is intentional.

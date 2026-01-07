# TODOs for nvim setup

## General
- Autopairs
    - When pressing CR while {|}, the result is {\n|\n}, rather than {\n\t|\n}
        - New issue: its weirdly indented. Autopairs seems to just generally be pretty ass, at least it has heavy problems in combination with autolist. Maybe find an alternative
    - When Pressing " while "" is present should amount to """ | """
    - Doesnt work for <>
- NoNeckPain
    - Disable NNP when going to a Buffer that is not markdown
    - Remove winbar.lua from side-buffers, as well as lualine
- Extract all keymaps into their own directory or file, this way making sure there arent any keymaps floating around where you dont expect them

## Python
- LSP
    - BasedPyright and Ruff are not well synchronized, BasedPyright is either off or way too verbose

## Markup
- Hybrid Mode of Markview flickers the entire list when working on List Items. For example, adding a new line to a list will flicker the entirety of an ordered list, while for an unordered list, walking through the list will shortly lower the indent by one character and then correct the indent almost immediately again
- Pressing O does not continue the list, while o does. O should also properly extend the list, including proper indention
- Adding a list item with indention under text does not work, as in markview does not render it. Example:

Example Text:
    - Item 1
    - Item 2

- No Idea what Marksman does, research


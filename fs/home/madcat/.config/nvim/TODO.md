# TODOs for nvim setup

## General
- Autopairs
    - When pressing CR while {|}, the result is {\n|\n}, rather than {\n\t|\n}
    - When Pressing " while "" is present should amount to """ | """
    - Doesnt work for <>
- NoNeckPain
    - Disable NNP when going to a Buffer that is not markdown
    - Remove winbar.lua from side-buffers, as well as lualine

## Python
- LSP
    - BasedPyright and Ruff are not well synchronized, BasedPyright is either off or way too verbose

## Markup
- List Items whose content needs to be wrapped should start the following lines under the first letter of the bullet point, not under the bullet point itself. Example as for how it shouldnt be can be seen in this very List Item
- Hybrid Mode of Markview flickers the entire list when working on List Items. For example, adding a new line to a list will flicker the entirety of an ordered list, while for an unordered list, walking through the list will shortly lower the indent by one character and then correct the indent almost immediately again 
- Pressing O does not continue the list, while o does. O should also properly extend the list, including proper indention
- Make Tab and Shift Tab change the indention of the current List Item, rather than C-t and C-d (in insert mode)
- Adding a list item with indention under text does not work, as in markview does not render it. Example:

Example Text:
    - Item 1
    - Item 2

- No Idea what Marksman does, research
- We have no visual indicator of a misspelled word, only a diagnostic message. If we do start using native spell for that, then we need to add project specific dictionaries, and also codeactions from harper need to be synced to spell corrections

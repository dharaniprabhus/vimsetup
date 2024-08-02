vim.g.mapleader = " "
-- Define and set up key bindings
local keybindings = {}

-- General key bindings
keybindings.general = {
    n = {
        ["rr"] = { ":nohl<CR>", "clear search Highlights" },
        ["zz"] = { "<cmd>w<CR>", "Save File" },
        ["zx"] = { "<cmd>x<CR>", "Save and Quit" },
        ["<Leader>tn"] = { ":tabnew<CR>", "Create new tab" },
        ["<Leader>te"] = { ":tabedit ", "Edit tab" },
        ["<Leader>tt"] = { ":tabnext<CR>", "Next tab" },
        ["<Leader>tp"] = { ":tabprevious<CR>", "Previous tab" },
        ["<Leader>tc"] = { ":tabclose<CR>", "Close tab" },
        ["<Leader>to"] = { ":tabonly<CR>", "Make this Only tab" },
    },
    i = {
        ["kj"] = { "<ESC>", "Exit Insert mode" },
        ["zz"] = { "<cmd>w<CR><ESC>", "Save File" },
        ["zx"] = { "<cmd>x<CR>", "Save and Quit" },
    },
}

for mode, mappings in pairs(keybindings.general) do
    for key, value in pairs(mappings) do
        vim.api.nvim_set_keymap(mode, key, value[1], { noremap = true, silent = true, desc = value[2] })
    end
end

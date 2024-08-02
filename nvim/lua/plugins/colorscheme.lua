return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        local transparent = false -- set to true if you would like to enable transparency

        local bg = "#D3D3D3"
        local bg_dark = "#A9A9A9"
        local bg_highlight = "#C0C0C0"
        local bg_search = "#FFD700"
        local bg_visual = "#FFA07A"
        local fg = "#000000"
        local fg_dark = "#333333"
        local fg_gutter = "#4F4F4F"
        local border = "#696969"

        require("tokyonight").setup({
            style = "day",
            transparent = transparent,
            styles = {
                sidebars = transparent and "transparent" or "dark",
                floats = transparent and "transparent" or "dark",
            },
            on_colors = function(colors)
                colors.bg = bg
                colors.bg_dark = transparent and colors.none or bg_dark
                colors.bg_float = transparent and colors.none or bg_dark
                colors.bg_highlight = bg_highlight
                colors.bg_popup = bg_dark
                colors.bg_search = bg_search
                colors.bg_sidebar = transparent and colors.none or bg_dark
                colors.bg_statusline = transparent and colors.none or bg_dark
                colors.bg_visual = bg_visual
                colors.border = border
                colors.fg = fg
                colors.fg_dark = fg_dark
                colors.fg_float = fg
                colors.fg_gutter = fg_gutter
                colors.fg_sidebar = fg_dark
            end,
        })

        vim.cmd("colorscheme tokyonight")
    end,
}

return {
	"EthanJWright/vs-tasks.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ta", function()
			require("telescope").extensions.vstask.tasks()
		end, { noremap = true, silent = true })
		keymap.set("n", "<leader>ti", function()
			require("telescope").extensions.vstask.inputs()
		end, { noremap = true, silent = true })
		keymap.set("n", "<leader>tl", function()
			require("telescope").extensions.vstask.launch()
		end, { noremap = true, silent = true })
	end,
}

return function(use)
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end
	})
	use {"sitiom/nvim-numbertoggle"}
	use {"ntpeters/vim-better-whitespace"}
	use({
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({})
		end
	})
--	use {"SirVer/ultisnips"}
--	use {"honza/vim-snippets"}
end

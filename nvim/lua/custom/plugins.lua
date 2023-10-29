return function(use)
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end
	})
	use {"sitiom/nvim-numbertoggle"}
	use {"ntpeters/vim-better-whitespace"}
	use {"mbbill/undotree"}
	use {"rebelot/kanagawa.nvim"}
	-- use({"theprimeagen/harpoon"})
	--use({
	--	"nvim-tree/nvim-web-devicons",
	--	config = function()
	--		require("nvim-web-devicons").setup({
	--			color_icons = true,
	--			default = true,
	--			strict = true,
	--		})
	--	end
	--})
	--use({
	--	"nvim-tree/nvim-tree.lua",
	--	config = function()
	--		require("nvim-tree").setup({})
	--	end
	--})
	--use({
	--	"nvim-tree/nvim-tree.lua",
	--	config = function()
	--		require("nvim-tree").setup(h
	--			sort_by = "case_sensitive",
	--			renderer = {
	--				group_empty = true,
	--			},
	--			filters = {
	--				dotfiles = true,
	--			},
	--		})
	--	end
	--})
--	use {"SirVer/ultisnips"}
--	use {"honza/vim-snippets"}
end

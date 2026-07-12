return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
  config = function()
  	require("oil").setup({
	    default_file_explorer = true,
	    columns = {
	        "icon",
	        "permissions",
	        "size",
	        -- "mtime",
	    },
	    buf_options = {
	        buflisted = false,
	        bufhidden = "hide",
	    },
	    win_options = {
	        wrap = false,
	        signcolumn = "no",
	        cursorcolumn = false,
	        foldcolumn = "0",
	        spell = false,
	        list = false,
	        conceallevel = 3,
	        concealcursor = "nvic",
	    },
	})
  end
}

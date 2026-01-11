vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		local Input = require("nui.input")
		local event = require("nui.utils.autocmd").event

		vim.ui.input = function(opts, on_confirm)
			opts = opts or {}
			on_confirm = on_confirm or function() end

			local input = Input({
				position = "50%",
				size = {
					width = opts.width or 40,
				},
				border = {
					style = "double",
					text = {
						top = opts.prompt or "Input",
						top_align = "center",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			}, {
				prompt = "> ",
				default_value = opts.default or "",
				on_submit = function(value)
					on_confirm(value)
				end,
			})

			input:mount()

			input:on(event.BufLeave, function()
				input:unmount()
			end)
		end
	end,
})

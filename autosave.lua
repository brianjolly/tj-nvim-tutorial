local bufnr = 37 -- :echo nvim_get_current_buf()

-- :help autocmd
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("TjsCoolTutorial", { clear = true }),
	pattern = "*.go",
	callback = function ()
		local append_data = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
			end
		end

		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"output of main:"})
		vim.fn.jobstart({"go", "run", "main.go"}, {
			stdout_buffered = true,
			on_stdout = append_data,
			on_stderr = append_data,
		})
	end,
})

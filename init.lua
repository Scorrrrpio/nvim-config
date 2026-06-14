-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'  -- in netrw too

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Leader keymappings
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist)

-- Basic diagnostics UI
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	signs = true,
	update_in_insert = false,
})

-- TypeScript LSP
vim.lsp.config('ts_ls', {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
	root_markers = { 'package.json', 'tsconfig.json', '.git' },
})
vim.lsp.enable('ts_ls')

-- Python LSP
vim.lsp.config('ty', {
	cmd = { 'ty', 'server' },
	filetypes = { 'python' },  -- TODO review
	root_markers = { 'uv.lock', 'pyproject.toml', '.git' },
})
vim.lsp.enable('ty')

-- LSP autocomplete
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
				autotrigger = true,
				convert = function(item)
					return item
				end,
			})
		end
	end,
})
vim.opt.completeopt = {"menu", "menuone", "noselect"}

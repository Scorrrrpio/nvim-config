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

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

-- Autocomplete tab insert
local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	if col == 0 then return false end
	local text = vim.api.nvim_get_current_line()
	return text:sub(col, col):match("%s") == nil
end

vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	elseif has_words_before() then
		return "<C-x><C-o>"
	else
		return "<Tab>"
	end
end, { expr = true })
vim.keymap.set("i", "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	else
		return "<S-Tab>"
	end
end, { expr = true })

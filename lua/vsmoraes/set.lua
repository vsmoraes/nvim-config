vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- Auto-close initial empty buffer when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        -- Check if we're in a new tab (tab number > 1) and there's an initial empty buffer
        if vim.fn.tabpagenr() > 1 then
            -- Look for tab 1
            local first_tab_wins = vim.fn.tabpagebuflist(1)
            if first_tab_wins and #first_tab_wins == 1 then
                local buf = first_tab_wins[1]
                -- Check if it's empty and unnamed
                if vim.api.nvim_buf_is_loaded(buf) and
                   vim.api.nvim_buf_get_name(buf) == "" and
                   not vim.api.nvim_buf_get_option(buf, "modified") and
                   vim.api.nvim_buf_line_count(buf) == 1 and
                   vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1] == "" then
                    -- Close the first tab
                    vim.cmd("1tabclose")
                end
            end
        end
    end,
})

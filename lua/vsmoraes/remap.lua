vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<S-n>", vim.cmd.NvimTreeToggle)

-- Toggle location list with <leader>e
vim.keymap.set('n', '<leader>e', function()
    local wininfo = vim.fn.getloclist(0, {winid = 0})
    if wininfo.winid ~= 0 then
        vim.cmd('lclose')
    else
        vim.diagnostic.setloclist()
    end
end, { noremap = true, silent = true, desc = "Toggle diagnostics location list" })

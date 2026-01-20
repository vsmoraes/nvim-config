vim.g.mapleader = " "

-- ===========================
-- File Navigation & Management
-- ===========================
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })
vim.keymap.set("n", "<S-n>", vim.cmd.NvimTreeToggle, { desc = "Toggle file tree" })

-- ===========================
-- Tab Management (Barbar)
-- ===========================
vim.keymap.set("n", "<leader>tn", "<Cmd>BufferNext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", "<Cmd>BufferPrevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tc", "<Cmd>BufferClose<CR>", { desc = "Close tab" })

-- ===========================
-- Diagnostics
-- ===========================
vim.keymap.set('n', '<leader>e', function()
    local wininfo = vim.fn.getloclist(0, {winid = 0})
    if wininfo.winid ~= 0 then
        vim.cmd('lclose')
    else
        vim.diagnostic.setloclist()
    end
end, { noremap = true, silent = true, desc = "Toggle diagnostics location list" })

-- ===========================
-- LSP Navigation & Actions
-- ===========================
-- Code actions
vim.keymap.set({ "n", "v" }, "<leader>ca", function()
    require("actions-preview").code_actions()
end, { desc = "Code actions" })

vim.keymap.set({ "n", "v", "i" }, "<C-CR>", function()
    require("actions-preview").code_actions()
end, { desc = "Code actions" })

-- Go to definition
vim.keymap.set('n', 'gd', function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
        if err then
            vim.notify('Error getting definition: ' .. tostring(err), vim.log.levels.ERROR)
        elseif not result or vim.tbl_isempty(result) then
            vim.notify('No definition found', vim.log.levels.WARN)
        else
            require('telescope.builtin').lsp_definitions()
        end
    end)
end, { desc = "Go to definition" })

vim.keymap.set('n', 'gt', function()
    -- Check if any client supports typeDefinition
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local supports_type_def = false

    for _, client in ipairs(clients) do
        if client.server_capabilities.typeDefinitionProvider then
            supports_type_def = true
            break
        end
    end

    if supports_type_def then
        require('telescope.builtin').lsp_type_definitions()
    else
        -- Fallback to regular definition
        require('telescope.builtin').lsp_definitions()
    end
end, { desc = "Go to type definition (fallback to definition)" })

vim.keymap.set('n', 'gr', function()
    local params = vim.lsp.util.make_position_params()
    params.context = { includeDeclaration = true }
    vim.lsp.buf_request(0, 'textDocument/references', params, function(err, result, ctx, config)
        if err then
            vim.notify('Error getting references: ' .. tostring(err), vim.log.levels.ERROR)
        elseif not result or vim.tbl_isempty(result) then
            vim.notify('No references found', vim.log.levels.WARN)
        else
            require('telescope.builtin').lsp_references()
        end
    end)
end, { desc = "Go to references" })

vim.keymap.set('n', 'gi', function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, 'textDocument/implementation', params, function(err, result, ctx, config)
        if err then
            vim.notify('Error getting implementations: ' .. tostring(err), vim.log.levels.ERROR)
        elseif not result or vim.tbl_isempty(result) then
            vim.notify('No implementations found', vim.log.levels.WARN)
        else
            require('telescope.builtin').lsp_implementations()
        end
    end)
end, { desc = "Go to implementation" })


-- ===========================
-- Telescope - Fuzzy Finder
-- ===========================
vim.keymap.set('n', '<leader>pf', function() require('telescope.builtin').find_files() end, { desc = "Find files" })
vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').git_files() end, { desc = "Find git files" })
vim.keymap.set('n', '<leader>pws', function()
    local word = vim.fn.expand("<cword>")
    require('telescope.builtin').grep_string({ search = word })
end, { desc = "Grep word under cursor" })
vim.keymap.set('n', '<leader>pWs', function()
    local word = vim.fn.expand("<cWORD>")
    require('telescope.builtin').grep_string({ search = word })
end, { desc = "Grep WORD under cursor" })
vim.keymap.set('n', '<leader>ps', function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep search" })
vim.keymap.set('n', '<leader>vh', function() require('telescope.builtin').help_tags() end, { desc = "Help tags" })
vim.keymap.set('n', '<leader>vk', function() require('telescope.builtin').keymaps() end, { desc = "View all keymaps" })
vim.keymap.set('n', '<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end, { desc = "Document symbols (methods, functions, classes)" })

-- ===========================
-- Code Formatting
-- ===========================
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    require('conform').format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file or range" })

-- ===========================
-- Git Management
-- ===========================
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame (vertical split on left)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })

-- ===========================
-- Undo Tree
-- ===========================
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree", noremap = true, silent = true })

-- ===========================
-- Terminal Management
-- ===========================
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })
vim.keymap.set('t', '<C-q>', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true, desc = "Close terminal" })

-- ===========================
-- Multi-cursor
-- ===========================
vim.keymap.set({ "n", "v" }, "<C-d>", function()
    require("multicursor-nvim").matchAddCursor(1)
end, { desc = "Select next word occurrence" })

vim.keymap.set({ "n", "v" }, "<C-S-d>", function()
    require("multicursor-nvim").matchAddCursor(-1)
end, { desc = "Select previous word occurrence" })

-- Add cursor on each line of visual selection
vim.keymap.set("v", "<C-l>", function()
    require("multicursor-nvim").addCursorOperator()
end, { desc = "Create cursor on each selected line" })

-- ESC to clear all cursors
vim.keymap.set("n", "<esc>", function()
    local mc = require("multicursor-nvim")
    if not mc.cursorsEnabled() then
        mc.enableCursors()
    elseif mc.hasCursors() then
        mc.clearCursors()
    end
end, { desc = "Clear cursors" })

-- ===========================
-- Run & Test Commands
-- ===========================
vim.keymap.set('n', '<leader>rr', function()
    -- Function to detect project type and return run command
    local function get_run_command()
        -- Check for Gradle (Kotlin/Java)
        if vim.fn.filereadable('build.gradle') == 1 or vim.fn.filereadable('build.gradle.kts') == 1 then
            return './gradlew run'
        end

        -- Check for Go
        if vim.fn.filereadable('go.mod') == 1 then
            return 'go run .'
        end

        -- Check for PHP Composer
        if vim.fn.filereadable('composer.json') == 1 then
            return 'php artisan serve || composer run start || php -S localhost:8000'
        end

        -- Fallback based on current file
        local ft = vim.bo.filetype
        if ft == 'kotlin' then
            return 'kotlinc ' .. vim.fn.expand('%') .. ' -include-runtime -d app.jar && java -jar app.jar'
        elseif ft == 'go' then
            return 'go run ' .. vim.fn.expand('%')
        elseif ft == 'php' then
            return 'php ' .. vim.fn.expand('%')
        end

        return nil
    end

    local cmd = get_run_command()
    if cmd then
        require('toggleterm').exec(cmd, 1)
    else
        print('No run command found for this project/file type')
    end
end, { noremap = true, silent = true, desc = "Run application" })

vim.keymap.set('n', '<leader>rt', function()
    -- Function to detect project type and return test command
    local function get_test_command()
        -- Check for Gradle (Kotlin/Java)
        if vim.fn.filereadable('build.gradle') == 1 or vim.fn.filereadable('build.gradle.kts') == 1 then
            return './gradlew test'
        end

        -- Check for Go
        if vim.fn.filereadable('go.mod') == 1 then
            return 'go test ./...'
        end

        -- Check for PHP
        if vim.fn.filereadable('composer.json') == 1 then
            if vim.fn.filereadable('phpunit.xml') == 1 or vim.fn.filereadable('phpunit.xml.dist') == 1 then
                return 'mc phpunit'
            end
            return 'mc phpunit'
        end

        return nil
    end

    local cmd = get_test_command()
    if cmd then
        require('toggleterm').exec(cmd, 2)
    else
        print('No test command found for this project/file type')
    end
end, { noremap = true, silent = true, desc = "Run tests" })

vim.keymap.set('n', '<leader>tf', function()
    -- Run tests for current file
    local function get_test_file_command()
        -- Get relative path from git root
        local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')
        local current_file_abs = vim.fn.expand('%:p')
        local relative_file

        if git_root ~= '' and vim.fn.isdirectory(git_root) == 1 then
            -- Calculate relative path from git root
            relative_file = current_file_abs:gsub('^' .. git_root:gsub('([^%w])', '%%%1') .. '/', '')
        else
            -- Fallback to relative path from current directory
            relative_file = vim.fn.expand('%')
        end

        -- Check for PHP
        if vim.fn.filereadable('composer.json') == 1 then
            if vim.fn.filereadable('phpunit.xml') == 1 or vim.fn.filereadable('phpunit.xml.dist') == 1 then
                return 'mc phpunit ' .. relative_file
            end
            return 'mc phpunit ' .. relative_file
        end

        -- Check for Go
        if vim.fn.filereadable('go.mod') == 1 then
            return 'go test ' .. vim.fn.expand('%:p:h')
        end

        return nil
    end

    local cmd = get_test_file_command()
    if cmd then
        require('toggleterm').exec(cmd, 2)
    else
        print('No test file command found for this project/file type')
    end
end, { noremap = true, silent = true, desc = "Run tests for current file" })

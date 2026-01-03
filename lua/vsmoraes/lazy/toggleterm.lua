return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<c-\>]],
            direction = 'float',
            float_opts = {
                border = 'curved',
                width = math.floor(vim.o.columns * 0.8),
                height = math.floor(vim.o.lines * 0.8),
            },
        })

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
                    return './vendor/bin/phpunit'
                end
                return 'composer test || ./vendor/bin/pest'
            end

            return nil
        end

        -- Run application
        vim.keymap.set('n', '<leader>rr', function()
            local cmd = get_run_command()
            if cmd then
                require('toggleterm').exec(cmd, 1)
            else
                print('No run command found for this project/file type')
            end
        end, { noremap = true, silent = true, desc = "Run application" })

        -- Run tests
        vim.keymap.set('n', '<leader>rt', function()
            local cmd = get_test_command()
            if cmd then
                require('toggleterm').exec(cmd, 2)
            else
                print('No test command found for this project/file type')
            end
        end, { noremap = true, silent = true, desc = "Run tests" })

        -- Terminal keymaps
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })
        vim.keymap.set('t', '<C-q>', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true, desc = "Close terminal" })
    end,
}

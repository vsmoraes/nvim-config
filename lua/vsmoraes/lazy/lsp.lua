return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "ray-x/lsp_signature.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

            require("lsp_signature").setup({
                bind = true, -- This is mandatory, otherwise border config won't work
                handler_opts = {
                    border = "rounded"
                },
                hint_enable = true, -- Virtual hint enable
                hint_prefix = "📌 ", -- Icon before parameter hint
                hi_parameter = "LspSignatureActiveParameter", -- Highlight current parameter
                max_height = 12, -- Max height of signature floating window
                max_width = 80, -- Max width of signature floating window
                toggle_key = '<C-k>', -- Toggle signature on and off in insert mode
                floating_window_above_cur_line = true, -- Show above cursor line when possible
            })

            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "vtsls",
                    "kotlin_language_server",
                    "intelephense",
                    "buf_ls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    zls = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.zls.setup({
                            root_dir = lspconfig.util.root_pattern(".git"),
                            settings = {
                                zls = {
                                    enable_inlay_hints = true,
                                    enable_snippets = true,
                                    warn_style = true,
                                },
                            },
                        })

                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    format = {
                                        enable = true,
                                        -- Put format options here
                                        -- NOTE: the value should be STRING!!
                                        defaultConfig = {
                                            indent_style = "space",
                                            indent_size = "2",
                                        }
                                    },
                                }
                            }
                        }
                    end,
                    ["intelephense"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.intelephense.setup {
                            capabilities = capabilities,
                            settings = {
                                intelephense = {
                                    files = {
                                        maxSize = 5000000, -- 5MB for large vendor files
                                        associations = {"*.php", "*.phtml"},
                                        exclude = {
                                            "**/.git/**",
                                            "**/.svn/**",
                                            "**/.hg/**",
                                            "**/CVS/**",
                                            "**/.DS_Store/**",
                                            "**/node_modules/**",
                                            "**/bower_components/**",
                                            "**/vendor/**/{Test,test,Tests,tests}/**",
                                        },
                                    },
                                    environment = {
                                        includePaths = {
                                            "./vendor",
                                        },
                                    },
                                    stubs = {
                                        "apache", "bcmath", "bz2", "calendar", "com_dotnet",
                                        "Core", "ctype", "curl", "date", "dba", "dom", "enchant",
                                        "exif", "fileinfo", "filter", "fpm", "ftp", "gd", "hash",
                                        "iconv", "imap", "interbase", "intl", "json", "ldap",
                                        "libxml", "mbstring", "mcrypt", "meta", "mssql", "mysqli",
                                        "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO",
                                        "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
                                        "Phar", "posix", "pspell", "readline", "recode", "Reflection",
                                        "regex", "session", "shmop", "SimpleXML", "snmp", "soap",
                                        "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals",
                                        "sybase", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer",
                                        "wddx", "xml", "xmlreader", "xmlrpc", "xmlwriter", "Zend OPcache",
                                        "zip", "zlib",
                                        "laravel", "phpunit"
                                    },
                                    diagnostics = {
                                        enable = true,
                                    },
                                    completion = {
                                        fullyQualifyGlobalConstantsAndFunctions = false,
                                        triggerParameterHints = true,
                                        insertUseDeclaration = true,
                                        maxItems = 100,
                                    },
                                }
                            }
                        }
                    end,
                }
            })

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "copilot", group_index = 2 },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                    wrap = true,
                    max_width = nil,
                    max_height = nil,
                    focusable = true,  -- Makes the window scrollable
                    style = "minimal",
                },
            })
        end
    }

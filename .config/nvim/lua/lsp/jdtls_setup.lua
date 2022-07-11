local M = {}

function M.setup()

    local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    local home = os.getenv('HOME')
    local maven_home = os.getenv('MAVEN_HOME')
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = '/home/charlie/.cache/jdtls_workspaces/' .. project_name
    local bundles = { vim.fn.glob(home ..
        '/packages/repos/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar') }

    for _, bundle in ipairs(vim.split(vim.fn.glob(home .. '/packages/repos/vscode-java-test/server/*.jar'), '\n')) do
        table.insert(bundles, bundle)
    end

    -- add jol
    require('jdtls').jol_path = home .. '/packages/repos/jol/jol-cli/target/jol-cli.jar'

    local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
    local config = {

        cmd = { 'java-lsp', workspace_dir },
        root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),
        settings = {
            java = {
                signatureHelp = { enabled = true };
                contentProvider = { preferred = 'fernflower' };
                templates = {
                    fileHeader = {
                        "/**",
                        " * @author: ${user}",
                        " * @date: ${date}",
                        " * @description: ${file_name}",
                        " */",
                    },
                    typeComment = {
                        "/**",
                        " * @author: ${user}",
                        " * @date: ${date}",
                        " * @description: ${type_name}",
                        " */",
                    }
                },
                import = {
                    maven = { enabled = true },
                    exclusions = {
                        "**/node_modules/**",
                        "**/.metadata/**",
                        "**/archetype-resources/**",
                        "**/META-INF/maven/**",
                        "**/Frontend/**",
                        "**/CSV_Aggregator/**"
                    },
                },
                maven = {
                    downloadSources = true
                },
                autobuild = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*"
                    },
                    overwrite = false,
                    guessMethodArguments = true,
                };
                sources = {
                    organizeImports = {
                        starThreshold = 9999;
                        staticStarThreshold = 9999;
                    }
                };
                codeGeneration = {
                    generateComments = true,
                    useBlocks = true,
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                    }
                };
                configuration = {
                    maven = {
                        globalSettings = maven_home .. "/conf/settings.xml",
                        userSettings = home .. "/.local/repos/.m2/settings.xml",
                    },
                    runtimes = {
                        {
                            name = "JavaSE-11",
                            path = "/usr/lib/jvm/11.0.6.j9-adpt/",
                        },
                        {
                            name = "JavaSE-18",
                            path = "/usr/lib/jvm/java-18-jdk/",
                        }
                    }
                }
            },
        },
        init_options = {
            bundles = bundles,
            extendedClientCapabilities = extendedClientCapabilities
        },

        flags = {
            allow_incremental_sync = true,
        },
        capabilities = {
            workspace = {
                configuration = true
            },
            textDocument = {
                completion = {
                    completionItem = {
                        snippentSupport = true
                    }
                }
            }
        }
    }


    local on_attach = function(client, bufnr)

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        local opts = { noremap = true, silent = true }

        --dap configuration, basically keymappings
        require('dap_setup').setup()

        -- dap-ui
        require('dap-ui_setup').ssetup()

        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


        -- Mappings.
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<space>h', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        -- extended features of jdtls

        vim.keymap.set('n', '<space>o', "<cmd>lua require('jdtls').organize_imports()<cr>", bufopts)
        vim.keymap.set('n', '<space>cv', "<cmd>lua require('jdtls').extract_variable(true)<cr>", bufopts)
        vim.keymap.set('v', '<space>cv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", bufopts)
        vim.keymap.set('n', '<space>cc', "<cmd>lua require('jdtls').extract_constant()<cr>", bufopts)
        vim.keymap.set('v', '<space>cc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", bufopts)
        vim.keymap.set('v', '<space>cm', "<esc><cmd>require('jdtls').extract_method(true)<cr>", bufopts)

        -- If using nvim-dap
        vim.keymap.set('n', '<space>tc', "<cmd>lua require('jdtls').test_class()<cr>", bufopts)
        vim.keymap.set('n', '<space>tm', "<cmd>lua require('jdtls').test_nearest_method(true)<cr>", bufopts)


        --- lspsaga
        local lspsaga_ok,_ = pcall(require, 'lspsaga')
        if lspsaga_ok then
            vim.keymap.set('n', '<space>rn', require('lspsaga.rename').lsp_rename, bufopts)
            vim.keymap.set('n', '<space>pd', require('lspsaga.definition').preview_definition, bufopts)
            vim.keymap.set("n", "<space>sh", require("lspsaga.signaturehelp").signature_help, bufopts)
            vim.keymap.set("v", "<space>ra", '<cmd>Lspsaga range_code_action<cr>', bufopts)

            vim.keymap.set("n", "<space>cd", require("lspsaga.diagnostic").show_line_diagnostics,
                { silent = true, noremap = true })

            -- jump diagnostic
            vim.keymap.set("n", "[e", require("lspsaga.diagnostic").goto_prev, bufopts)
            vim.keymap.set("n", "]e", require("lspsaga.diagnostic").goto_next, bufopts)
            -- or jump to error
            vim.keymap.set("n", "[E", function()
                require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end, { silent = true, noremap = true })
            vim.keymap.set("n", "]E", function()
                require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
            end, { silent = true, noremap = true })

            vim.keymap.set("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", bufopts)
            vim.keymap.set("t", "<A-t>", "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>", bufopts)
        end

        require('jdtls').setup_dap()
        -- require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        -- require'jdtsl.dap'.setup_dap_main_class_configs()
        -- add the preconfigured Jdt* commands
        require('jdtls.setup').add_commands()



        --- update galaxyline -----
        -- jdtls takes a retarted amount of time to start and galaxyline doesn't have any callback
        -- so this settings basically updates the provider of the lsp section with the client.name

        local status_ok, galaxyline = pcall(require, 'galaxyline')
        if status_ok then
            galaxyline.section.mid[1] = {
                ShowLspClient = {
                    icon = ' LSP:',
                    provider = function() return client.name end,
                },
            }
        end

        -- Set some keybinds conditional on server capabilities
        if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
        elseif client.server_capabilities.documentRangeFormattingProvider then
            vim.keymap.set('n', '<space>f', vim.lsp.buf.range_formatting, bufopts)
        end

        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.documentHighlightProvider then
            local highlight = vim.api.nvim_create_augroup("lsp_doc_highlight", { clear = true })
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = 0,
                command = 'lua vim.lsp.buf.document_highlight()',
                desc = "highlight text when cursor holds",
                group = highlight
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = 0,
                command = 'lua vim.lsp.buf.clear_references()',
                desc = "clear references when cursor moves",
                group = highlight
            })

        end
        local hp = client.server_capabilities.hoverProvider
        if hp == true or (type(hp) == "table" and next(hp) ~= nil) then
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
        end
    end

    config.on_attach = on_attach
    config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    local on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end

    config.on_init = on_init

    require('jdtls').start_or_attach(config)

-------------------------------------------------------------------------------------------------
    require('lsp.lspsaga').setup()
end

return M

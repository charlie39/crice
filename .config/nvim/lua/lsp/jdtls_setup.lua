local M = {}

function M.setup()
  local home = os.getenv('HOME')
  local maven_home = os.getenv('MAVEN_HOME')
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = '/home/charlie/.cache/jdtls_workspaces/' .. project_name

  local bundles = { vim.fn.glob(vim.fn.stdpath('data') ..
    '/jars/vscode-java-debug/extension/server/com.microsoft.java.debug.plugin-*.jar') }

  local jars = vim.fn.stdpath('data') .. '/jars/'
  for _, bundle in ipairs(vim.split(vim.fn.glob(jars .. 'vscode-java-test/extension/server/*.jar'), '\n')) do
    table.insert(bundles, bundle)
  end
  for _, bundle in ipairs(vim.split(vim.fn.glob(jars .. 'vscode-pde/extension/server/*.jar'), '\n')) do
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
    -- root_dir = vim.fn.getcwd(),
    -- filetypes =  'java',
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
          downloadSources = true,
          updateSnapshots = true,
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

  config.on_attach = require 'lsp.on_attach'.on_attach
  config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end

  require('jdtls').start_or_attach(config)
end

return M

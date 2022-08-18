local M = {}

function M.setup()

  local home = vim.env.HOME
  local maven_home = vim.env.MAVEN_HOME
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = home .. '/.cache/jdtls_workspaces/' .. project_name
  local lombokjar = '/usr/lib/lombok-common/lombok.jar'
  local eclipse_java_google_style = vim.fn.stdpath('config') .. '/rules/eclipse-java-google-style.xml'
  local jars = vim.fn.stdpath('data') .. '/jars/'

  -- java debug jars
  local bundles = { vim.fn.glob(jars .. 'vscode-java-debug/extension/server/com.microsoft.java.debug.plugin-*.jar') }

  -- java test jars
  for _, bundle in ipairs(vim.split(vim.fn.glob(jars .. 'vscode-java-test/extension/server/*.jar'), '\n')) do
    table.insert(bundles, bundle)
  end
  -- importing eclipse project
  for _, bundle in ipairs(vim.split(vim.fn.glob(jars .. 'vscode-pde/extension/server/*.jar'), '\n')) do
    table.insert(bundles, bundle)
  end

  -- add jol
  require('jdtls').jol_path = home .. '/packages/repos/jol/jol-cli/target/jol-cli.jar'

  local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = {

    -- custom script,for further configurations
    -- cmd = { 'java-lsp', workspace_dir },
    cmd = { 'jdtls', '--jvm-arg=-javaagent:' .. lombokjar, '-data', workspace_dir },
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),
    -- root_dir = vim.fn.getcwd(),
    -- filetypes =  'java',
    settings = {
      java = {
        signatureHelp = { enabled = true };
        contentProvider = { preferred = 'fernflower' };
        implementationsCodeLens = {
          enabled = true
        };
        referencesCodeLens = {
          enabled = true
        };
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
        };
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
        };
        maven = {
          downloadSources = true,
          updateSnapshots = true,
        };
        autobuild = { enabled = true };
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
          hashCodeEquals = {
            userIntanceOf = true
          },
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            codeStyle = "STRING_BUILDER_CHAINED"
          }
        };
        configuration = {
          maven = {
            globalSettings = maven_home .. "/conf/settings.xml",
            userSettings = home .. "/.local/repos/.m2/settings.xml",
          },
          runtimes = {
            {
              name = "JavaSE-1.8",
              path = "/usr/lib/jvm/java-18-jdk/",
            },
            {
              name = "JavaSE-11",
              path = "/usr/lib/jvm/11.0.6.j9-adpt/",
            },
            { name = "JavaSE-17",
              path = vim.env.JAVA_HOME,
            },
            {
              name = "JavaSE-18",
              path = "/usr/lib/jvm/java-18-jdk/",
            }
          }
        };
        format = {
          settings = {
            url = eclipse_java_google_style,
            profile = 'GoogleStyle'
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
      debounce_text_changes = 150,
      server_side_fuzzy_completion = true,
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

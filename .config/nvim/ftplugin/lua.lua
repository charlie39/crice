-- ftplugin/lua.lua
local indent = 2
vim.api.nvim_set_option_value('shiftwidth', indent, { scope = 'local' })
vim.api.nvim_set_option_value('sts', indent, { scope = 'local' })

local ns_ok, ns = pcall(require, 'nvim-surround')
if not ns_ok then
  return
end
--[[ ns.buffer_setup({
  surrounds = {
    ["f"] = function()
      return {
        "function " .. require("nvim-surround.config").get_input(
          "Enter the function name: "
        ) .. "()",
        "end"
      }
    end
    ,
    ['F'] = function()
      return {
        "if " .. require("nvim-surround.config").get_input(
          "Enter the if condition: "
        ) .. " then",
        "end"
      }
    end,
  }
}) ]]

-- ftplugin/python.lua
require("nvim-surround").buffer_setup({
  delimiters = {
    pairs = {
      ["f"] = function()
        return {
          "def " .. require("nvim-surround.utils").get_input(
            "Enter the function name: "
          ) .. "(",
          "):"
        }
      end,
      ['F'] = function()
        return {
          "if " .. require("nvim-surround.utils").get_input(
            "Enter if condition: "
          ) .. ":",
          ""
        }
      end,
    }
  }
})

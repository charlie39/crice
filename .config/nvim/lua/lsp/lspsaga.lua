
-- not in use
local M = {}

M.setup = function()

  local lspsaga_ok, lspsaga_ = pcall(require, 'lspsaga')
  if lspsaga_ok then
    lspsaga_.setup ({})
    --[[ lspsaga_.setup {
      preview = { lines_above = 0,
      lines_below = 10,
    },
    scroll_preview = {
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    request_timeout = 2000,

  finder = {
    --percentage
    max_height = 0.5,
    force_max_height = false,
    keys = {
      jump_to = 'p',
      edit = { 'o', '<CR>' },
      vsplit = 's',
      split = 'i',
      tabe = 't',
      tabnew = 'r',
      quit = { 'q', '<ESC>' },
      close_in_preview = '<ESC>'
    },
  },
    } ]]
  end
end

return M

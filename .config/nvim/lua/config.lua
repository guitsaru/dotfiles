local _, themes = pcall(require, "telescope.themes")
local _, builtin = pcall(require, "telescope.builtin")

local M = {}

function M.find_config_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ Config files ~",
    cwd = "~/.config/nvim",
    search_dirs = { "~/.config/nvim" },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.find_files(opts)
end

function M.live_grep_config_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ Config files ~",
    cwd = "~/.config/nvim",
    search_dirs = { "~/.config/nvim" },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.live_grep(opts)
end

return M

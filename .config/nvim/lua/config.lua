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

function M.reload()
  -- Telescope will give us something like ju/colors.lua, 
  -- so this function convert the selected entry to 
  -- the module name: ju.colors
  local function get_module_name(s)
    local module_name;

    module_name = s:gsub("%.lua", "")
    module_name = module_name:gsub("%/", ".")
    module_name = module_name:gsub("%.init", "")

    return module_name
  end

  for entry in io.popen("cd ~/.config/nvim/lua && find . -type f | grep .lua"):lines() do
    local name = get_module_name(entry)
    require("plenary.reload").reload_module(name)
  end
end

return M

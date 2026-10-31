-- ================================================================================================
-- TITLE : snacks.nvim
-- ABOUT : LazyVim's snacks setup: picker, explorer, notifier, scratch, terminal, toggles.
--         Combined from LazyVim's plugins/init.lua, util.lua, ui.lua,
--         extras/editor/snacks_picker.lua and extras/editor/snacks_explorer.lua.
-- LINKS :
--   > github : https://github.com/folke/snacks.nvim
-- ================================================================================================

local root = function()
  return require("utils.root")()
end

-- LazyVim's dashboard logo
local logo = {
  [[          ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z]],
  [[          ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z]],
  [[          ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z]],
  [[          ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z]],
  [[          ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[          ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  "", -- blank line under the logo (same as LazyVim)
}
-- Pad every line to the same width. The logo depends on the lines being equal width,
-- and your format-on-save (mini.trailspace) removes spaces at the end of lines.
local width = 0
for _, line in ipairs(logo) do
  width = math.max(width, vim.fn.strdisplaywidth(line))
end
for i, line in ipairs(logo) do
  logo[i] = line .. string.rep(" ", width - vim.fn.strdisplaywidth(line))
end

-- Terminal Mappings
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">"
      or vim.schedule(function()
        vim.cmd.wincmd(dir)
      end)
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false }, -- Omarchy turns scroll animation off (LazyVim: true)
    statuscolumn = { enabled = false },
    words = { enabled = true },
    explorer = {},
    dashboard = {
      preset = {
        header = table.concat(logo, "\n"),
        -- stylua: ignore
        keys = {
          { icon = "\u{f002} ",  key = "f", desc = "Find File",       action = ":lua Snacks.picker.files({ cwd = require('utils.root')() })" },
          { icon = "\u{f15b} ",  key = "n", desc = "New File",        action = ":ene | startinsert" },
          { icon = "\u{f502} ",  key = "p", desc = "Projects",        action = ":lua Snacks.picker.projects()" },
          { icon = "\u{f022} ",  key = "g", desc = "Find Text",       action = ":lua Snacks.picker.grep({ cwd = require('utils.root')() })" },
          { icon = "\u{f0c5} ",  key = "r", desc = "Recent Files",    action = ":lua Snacks.picker.recent()" },
          { icon = "\u{f423} ",  key = "c", desc = "Config",          action = ":lua Snacks.picker.files({ cwd = require('utils.config_dir')() })" },
          { icon = "\u{e348} ",  key = "s", desc = "Restore Session", section = "session" },
          { icon = "\u{f04b2} ", key = "l", desc = "Lazy",            action = ":Lazy" },
          { icon = "\u{f426} ",  key = "q", desc = "Quit",            action = ":qa" },
        },
      },
    },
    picker = {
      -- show hidden files (dotfiles) in the file finder, text search and explorer.
      -- .gitignore'd files stay hidden, and the explorer skips the .git folder.
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
        explorer = { hidden = true, exclude = { ".git" } },
      },
      win = {
        input = {
          keys = {
            ["<a-c>"] = { "toggle_cwd", mode = { "n", "i" } },
            ["<a-t>"] = { "trouble_open", mode = { "n", "i" } },
            ["<a-s>"] = { "flash", mode = { "n", "i" } },
            ["s"] = { "flash" },
          },
        },
      },
      actions = {
        toggle_cwd = function(p)
          local r = vim.fs.normalize(root())
          local cwd = vim.fs.normalize(vim.uv.cwd() or ".")
          p:set_cwd(p:cwd() == r and cwd or r)
          p:find()
        end,
        trouble_open = function(...)
          return require("trouble.sources.snacks").actions.trouble_open.action(...)
        end,
        flash = function(picker)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
      },
    },
    terminal = {
      win = {
        keys = {
          nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
          nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
          nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
          nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
          hide_underscore = { "<c-_>", "hide", desc = "which_key_ignore", mode = "t" },
        },
      },
    },
  },
  config = function(_, opts)
    local notify = vim.notify
    require("snacks").setup(opts)
    -- let noice.nvim take over vim.notify (same as LazyVim)
    vim.notify = notify
  end,
  -- stylua: ignore
  keys = {
    -- scratch / profiler
    { "<leader>.",       function() Snacks.scratch() end,                                          desc = "Toggle Scratch Buffer" },
    { "<leader>S",       function() Snacks.scratch.select() end,                                   desc = "Select Scratch Buffer" },
    { "<leader>dps",     function() Snacks.profiler.scratch() end,                                 desc = "Profiler Scratch Buffer" },
    -- notifications
    { "<leader>n",       function() Snacks.picker.notifications() end,                             desc = "Notification History" },
    { "<leader>un",      function() Snacks.notifier.hide() end,                                    desc = "Dismiss All Notifications" },
    -- explorer
    { "<leader>fe",      function() Snacks.explorer({ cwd = root() }) end,                         desc = "Explorer Snacks (root dir)" },
    { "<leader>fE",      function() Snacks.explorer() end,                                         desc = "Explorer Snacks (cwd)" },
    { "<leader>e",       "<leader>fe",                                                             desc = "Explorer Snacks (root dir)",          remap = true },
    { "<leader>E",       "<leader>fE",                                                             desc = "Explorer Snacks (cwd)",               remap = true },
    -- picker
    { "<leader>,",       function() Snacks.picker.buffers() end,                                   desc = "Buffers" },
    { "<leader>/",       function() Snacks.picker.grep({ cwd = root() }) end,                      desc = "Grep (Root Dir)" },
    { "<leader>:",       function() Snacks.picker.command_history() end,                           desc = "Command History" },
    { "<leader><space>", function() Snacks.picker.files({ cwd = root() }) end,                     desc = "Find Files (Root Dir)" },
    -- find
    { "<leader>fb",      function() Snacks.picker.buffers() end,                                   desc = "Buffers" },
    { "<leader>fB",      function() Snacks.picker.buffers({ hidden = true, nofile = true }) end,   desc = "Buffers (all)" },
    { "<leader>fc",      function() Snacks.picker.files({ cwd = require("utils.config_dir")() }) end, desc = "Find Config File" },
    { "<leader>ff",      function() Snacks.picker.files({ cwd = root() }) end,                     desc = "Find Files (Root Dir)" },
    { "<leader>fF",      function() Snacks.picker.files() end,                                     desc = "Find Files (cwd)" },
    { "<leader>fg",      function() Snacks.picker.git_files() end,                                 desc = "Find Files (git-files)" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                                    desc = "Recent" },
    { "<leader>fR",      function() Snacks.picker.recent({ filter = { cwd = true } }) end,         desc = "Recent (cwd)" },
    { "<leader>fp",      function() Snacks.picker.projects() end,                                  desc = "Projects" },
    { "<leader>fh",      function() Snacks.picker.help() end,                                      desc = "Help Pages" },
    { "<leader>fx",      function() Snacks.picker.diagnostics_buffer() end,                        desc = "Diagnostics (file)" },
    { "<leader>fX",      function() Snacks.picker.diagnostics() end,                               desc = "Diagnostics (project)" },
    -- git
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                                  desc = "Git Diff (hunks)" },
    { "<leader>gD",      function() Snacks.picker.git_diff({ base = "origin", group = true }) end, desc = "Git Diff (origin)" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,                                desc = "Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,                                 desc = "Git Stash" },
    { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                  desc = "GitHub Issues (open)" },
    { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,                 desc = "GitHub Issues (all)" },
    { "<leader>gp",      function() Snacks.picker.gh_pr() end,                                     desc = "GitHub Pull Requests (open)" },
    { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                    desc = "GitHub Pull Requests (all)" },
    -- Grep
    { "<leader>sb",      function() Snacks.picker.lines() end,                                     desc = "Buffer Lines" },
    { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                              desc = "Grep Open Buffers" },
    { "<leader>sg",      function() Snacks.picker.grep({ cwd = root() }) end,                      desc = "Grep (Root Dir)" },
    { "<leader>sG",      function() Snacks.picker.grep() end,                                      desc = "Grep (cwd)" },
    { "<leader>sp",      function() Snacks.picker.lazy() end,                                      desc = "Search for Plugin Spec" },
    { "<leader>sw",      function() Snacks.picker.grep_word({ cwd = root() }) end,                 desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
    { "<leader>sW",      function() Snacks.picker.grep_word() end,                                 desc = "Visual selection or word (cwd)",      mode = { "n", "x" } },
    -- search
    { '<leader>s"',      function() Snacks.picker.registers() end,                                 desc = "Registers" },
    { '<leader>s/',      function() Snacks.picker.search_history() end,                            desc = "Search History" },
    { "<leader>sa",      function() Snacks.picker.autocmds() end,                                  desc = "Autocmds" },
    { "<leader>sc",      function() Snacks.picker.command_history() end,                           desc = "Command History" },
    { "<leader>sC",      function() Snacks.picker.commands() end,                                  desc = "Commands" },
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,                               desc = "Diagnostics" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                        desc = "Buffer Diagnostics" },
    { "<leader>sh",      function() Snacks.picker.help() end,                                      desc = "Help Pages" },
    { "<leader>sH",      function() Snacks.picker.highlights() end,                                desc = "Highlights" },
    { "<leader>si",      function() Snacks.picker.icons() end,                                     desc = "Icons" },
    { "<leader>sj",      function() Snacks.picker.jumps() end,                                     desc = "Jumps" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,                                   desc = "Keymaps" },
    { "<leader>sl",      function() Snacks.picker.loclist() end,                                   desc = "Location List" },
    { "<leader>sM",      function() Snacks.picker.man() end,                                       desc = "Man Pages" },
    { "<leader>sm",      function() Snacks.picker.marks() end,                                     desc = "Marks" },
    { "<leader>sR",      function() Snacks.picker.resume() end,                                    desc = "Resume" },
    { "<leader>sq",      function() Snacks.picker.qflist() end,                                    desc = "Quickfix List" },
    { "<leader>su",      function() Snacks.picker.undo() end,                                      desc = "Undotree" },
    -- ui
    { "<leader>uC",      function() Snacks.picker.colorschemes() end,                              desc = "Colorschemes" },
  },
}

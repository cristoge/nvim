local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {

    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    --import any extra modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    --{ import = "lazyvim.plugins.extras.ai.copilot" },
    {
      "CRAG666/code_runner.nvim",
      config = function()
        require("code_runner").setup({
          filetype = {
            java = {
              "cd $dir &&",
              "javac $fileName &&",
              "java $fileNameWithoutExt",
            },
            python = "python3 -u",
            typescript = "ts-node",
            rust = {
              "cd $dir &&",
              "rustc $fileName &&",
              "$dir/$fileNameWithoutExt",
            },
            c = function(...)
              c_base = {
                "cd $dir &&",
                "gcc $fileName -o",
                "/tmp/$fileNameWithoutExt",
              }
              local c_exec = {
                "&& /tmp/$fileNameWithoutExt &&",
                "rm /tmp/$fileNameWithoutExt",
              }
              vim.ui.input({ prompt = "Add more args:" }, function(input)
                c_base[4] = input
                vim.print(vim.tbl_extend("force", c_base, c_exec))
                require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
              end)
            end,
          },
        })
      end,
    },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

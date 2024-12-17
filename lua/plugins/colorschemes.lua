return {
  { "rebelot/kanagawa.nvim" },
  -- Aqui iran los colores que se quieran agregar
  -- -- Lazy
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "2giosangmitom/nightfall.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      })
    end,
  },
  {
    "b0o/lavi.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
  {
    "embark-theme/vim",
    as = "embark",
  },
  {
    "baliestri/aura-theme",
    lazy = false, -- Se carga inmediatamente
    priority = 1000, -- Se carga primero
    init = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim") -- Agrega el tema al runtimepath
    end,
  },
  -- somewhere in your config
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "deepernight",
    },
  },
}

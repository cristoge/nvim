return {
  { "rebelot/kanagawa.nvim" },
  -- Aqui iran los colores que se quieran agregar
  -- -- Lazy
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },

  -- somewhere in your config
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark_vivid",
    },
  },
}

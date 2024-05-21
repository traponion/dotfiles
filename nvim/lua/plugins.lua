return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd[[colorscheme tokyonight-moon]]
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  },
  {
    "github/copilot.vim",
    lazy=false,
    filetypes = {
      plaintext = true,
      yaml = false,
      markdown = true,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
  },
  {
    "vim-denops/denops.vim",
  },
  {
    "vim-skk/skkeleton",
    lazy = false,
    requires = { "vim-denops/denops.vim" },
    init = function()
      vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-enable)', { noremap = true })
      vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-enable)', { noremap = true })

      -- 辞書を探す
      local dictionaries = {}
      local handle = io.popen("ls $HOME/.skk/*") -- フルバスで取得    
      if handle then
        for file in handle:lines() do
          table.insert(dictionaries, file)
        end
        handle:close()
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "skkeleton-initialize-pre",
        callback = function()
          vim.fn["skkeleton#config"]({
            eggLikeNewline = true,
            registerConvertResult = true,
            globalDictionaries = dictionaries,
          })
        end,
      })
    end
  }
}

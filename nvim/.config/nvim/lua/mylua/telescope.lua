local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    --winblend = 10,
    layout_strategy = 'vertical',
    layout_config = {
      --width = 0.8,
      vertical = {
        preview_height = 0.5,
        preview_cutoff = 1,
      },
    },

    mappings = {
      i = {
        --['<C-x>'] = false,
        ['<C-q>'] = actions.send_to_qflist,
        ['<esc>'] = actions.close
      },
    },
  },
  pickers = {
    find_files = {
      -- allow symlinks
      follow = true,
      -- hidden files
      --hidden = true, ignores also .gitignore, shows .git folder
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require'telescope'.load_extension('project')

-- Module to export
local M={}
M.search_nvimdotfiles = function()
  require('telescope.builtin').find_files({
    prompt_title = '< VimRC >',
    cwd = '$HOME/.config/nvim',
  })
end

M.search_xmonaddotfiles = function()
  require('telescope.builtin').find_files({
    prompt_title = '< XMonad >',
    cwd = '$HOME/.xmonad',
    follow = true,
  })
end

return M
